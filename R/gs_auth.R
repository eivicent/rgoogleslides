# Auth state object, initialized properly in .onLoad()
.auth <- NULL

#' Authorize rgoogleslides
#'
#' Authorize rgoogleslides to access the Google Slides API on your behalf.
#' This function is a wrapper around [gargle::token_fetch()].
#'
#' Most users, most of the time, do not need to call `gs_auth()` explicitly --
#' it is triggered automatically by the first action that requires
#' authorization. Even when called, the default arguments often suffice.
#'
#' @param email Optional. If specified, `email` can take several different
#'   forms:
#'   * `"jane@gmail.com"`, an actual email address. If found in the cache,
#'     the associated token is loaded. Otherwise, the OAuth flow is
#'     initiated using this email as a hint.
#'   * `"*@example.com"`, a domain-only pattern. Any cached token matching
#'     this pattern is loaded.
#'   * `TRUE` means that a cached token is loaded if exactly one match is
#'     found.
#'   * `FALSE` or `NA` mean to ignore the cache and always initiate a new
#'     OAuth flow.
#' @param path Path to a service account JSON file.
#' @param scopes A character vector of scopes for the access request.
#' @param cache Specifies the OAuth token cache. Set `FALSE` to disable.
#' @param use_oob Whether to use out-of-band authentication.
#' @param token A token to use directly, an object of class [httr::Token2.0],
#'   or a pre-configured request as returned by `gs_token()`.
#'
#' @return Called for its side effect of storing a token for later use.
#'   Returns the token invisibly.
#'
#' @family auth
#' @export
#'
#' @examplesIf interactive()
#' # trigger interactive OAuth flow
#' gs_auth()
#'
#' # use a specific email
#' gs_auth(email = "jane@example.com")
#'
#' # use a service account
#' gs_auth(path = "path/to/service-account.json")
gs_auth <- function(email = gargle::gargle_oauth_email(),
                    path = NULL,
                    scopes = c(
                      "https://www.googleapis.com/auth/presentations",
                      "https://www.googleapis.com/auth/drive.readonly"
                    ),
                    cache = gargle::gargle_oauth_cache(),
                    use_oob = gargle::gargle_oob_default(),
                    token = NULL) {
  gargle::check_is_service_account(path, hint = "gs_auth_configure")

  client <- gs_oauth_client() %||% cli::cli_abort(c(
    "No OAuth client is available for {.pkg rgoogleslides}.",
    "i" = "The built-in client requires the {.envvar RGOOGLESLIDES_KEY} environment variable.",
    "i" = "Alternatively, call {.fun gs_auth_configure} with your own OAuth client.",
    "i" = "See {.url https://gargle.r-lib.org/articles/get-api-credentials.html}"
  ))

  cred <- gargle::token_fetch(
    scopes = scopes,
    client = client,
    email = email,
    path = path,
    package = "rgoogleslides",
    cache = cache,
    use_oob = use_oob,
    token = token
  )

  if (!inherits(cred, "Token2.0")) {
    cli::cli_abort(c(
      "Can't get Google credentials",
      "i" = "Are you running {.pkg rgoogleslides} in a non-interactive
             session? Consider:",
      "*" = "A service account token, see {.url https://gargle.r-lib.org/articles/get-api-credentials.html}",
      "*" = "{.code gs_auth(path = \"/path/to/your/service-account.json\")}"
    ))
  }

  .auth$set_cred(cred)
  .auth$set_auth_active(TRUE)

  invisible(cred)
}

#' Clear Google Slides credentials
#'
#' Put rgoogleslides into a de-authorized state. After calling `gs_deauth()`,
#' any request that requires authorization will fail.
#'
#' @return None, called for side effects.
#' @family auth
#' @export
#'
#' @examples
#' gs_deauth()
gs_deauth <- function() {
  .auth$set_cred(NULL)
  .auth$set_auth_active(FALSE)
  invisible(NULL)
}

#' Produce a configured token
#'
#' For internal use or for other packages that wish to use the same
#' credentials as rgoogleslides. Returns a token pre-processed into a
#' suitable form for use with [httr::config()].
#'
#' @return An [httr::config()] object with the current credential, or `NULL`
#'   if auth is not active.
#' @family auth
#' @export
#'
#' @examplesIf gs_has_token()
#' gs_token()
gs_token <- function() {
  if (isFALSE(.auth$auth_active)) {
    return(NULL)
  }
  if (!gs_has_token()) {
    gs_auth()
  }
  httr::config(token = .auth$cred)
}

#' Is there a token on hand?
#'
#' Reports whether rgoogleslides has stored a token, ready for use in
#' downstream requests.
#'
#' @return `TRUE` if a token is available, `FALSE` otherwise.
#' @family auth
#' @export
#'
#' @examples
#' gs_has_token()
gs_has_token <- function() {
  inherits(.auth$cred, "Token2.0")
}

#' Edit auth configuration
#'
#' @param client A Google OAuth client, as produced by
#'   [gargle::gargle_oauth_client()].
#' @param path Path to a JSON file with client credentials.
#'
#' @return None, called for side effects.
#' @family auth
#' @export
#'
#' @examplesIf interactive()
#' gs_auth_configure(path = "/path/to/oauth-client.json")
gs_auth_configure <- function(client, path) {
  if (!missing(client) && !missing(path)) {
    cli::cli_abort("Provide exactly one of {.arg client} or {.arg path}, not both.")
  }
  if (missing(client) && missing(path)) {
    cli::cli_abort("Provide one of {.arg client} or {.arg path}.")
  }
  if (!missing(path)) {
    check_string(path)
    client <- gargle::gargle_oauth_client_from_json(path)
  }
  if (!missing(client)) {
    if (!inherits(client, "gargle_oauth_client")) {
      cli::cli_abort(
        "{.arg client} must be a {.cls gargle_oauth_client} object, not {.obj_type_of {client}}."
      )
    }
    .auth$set_client(client)
  }
  invisible()
}

#' Retrieve the configured OAuth client
#'
#' @return A gargle OAuth client object, or `NULL` if not configured.
#' @family auth
#' @export
#'
#' @examples
#' gs_oauth_client()
gs_oauth_client <- function() {
  .auth$client
}

# Extract a fresh raw access token from the gargle credential.
# Triggers auth if needed, then refreshes to ensure the token is not expired.
gs_access_token <- function() {
  if (!gs_has_token()) gs_auth()
  cred <- .auth$cred
  cred$refresh()
  cred$credentials$access_token
}
