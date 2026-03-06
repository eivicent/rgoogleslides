.slides_base <- "https://slides.googleapis.com/v1/presentations"

.slides_url <- list(
  create   = .slides_base,
  get      = paste0(.slides_base, "/{presentationId}"),
  batch    = paste0(.slides_base, "/{presentationId}:batchUpdate"),
  page_get = paste0(.slides_base, "/{presentationId}/pages/{pageObjectId}")
)

# Placeholders that must be substituted in each URL template
.slides_url_params <- list(
  create   = character(0),
  get      = "presentationId",
  batch    = "presentationId",
  page_get = c("presentationId", "pageObjectId")
)

#' Make a Google Slides API request
#'
#' Low-level function to execute a request against the Google Slides API
#' using gargle's retry logic for rate limiting and transient errors.
#'
#' @param method HTTP method, e.g. `"GET"` or `"POST"`.
#' @param url Full URL for the API endpoint.
#' @param body Request body (will be encoded as JSON).
#' @param token Token to include, defaults to [gs_token()].
#'
#' @return Parsed JSON response as a list.
#' @noRd
gs_request_make <- function(method, url, body = NULL, token = gs_token()) {
  req <- list(
    method = method,
    url    = url,
    body   = body,
    token  = token
  )

  raw_resp <- gargle::request_make(req)
  response_process(raw_resp, method = method, url = url)
}

#' Process API response
#'
#' @param raw_resp An httr response object.
#' @param method HTTP method string, included in error messages.
#' @param url URL string, included in error messages.
#' @return Parsed JSON as a list.
#' @noRd
response_process <- function(raw_resp, method = NULL, url = NULL) {
  result_content <- httr::content(raw_resp, as = "text", encoding = "UTF-8")

  if (httr::status_code(raw_resp) >= 400) {
    result_list <- jsonlite::fromJSON(result_content, simplifyVector = FALSE)
    msg <- result_list$error$message %||% "Unknown API error"
    cli::cli_abort(c(
      "Google Slides API request failed",
      "x" = msg,
      "i" = "HTTP status: {httr::status_code(raw_resp)}",
      "i" = if (!is.null(method) && !is.null(url)) "{method} {url}" else NULL
    ))
  }

  jsonlite::fromJSON(result_content, simplifyVector = FALSE)
}

#' Build a Google Slides API URL
#'
#' @param endpoint Name of the endpoint: `"create"`, `"get"`, `"batch"`, or
#'   `"page_get"`.
#' @param presentation_id Presentation ID to substitute.
#' @param page_object_id Page object ID to substitute.
#'
#' @return A fully formed URL string.
#' @noRd
gs_build_url <- function(endpoint, presentation_id = NULL,
                         page_object_id = NULL) {
  url <- .slides_url[[endpoint]]

  if (is.null(url)) {
    cli::cli_abort("Unknown endpoint: {.val {endpoint}}")
  }

  if (!is.null(presentation_id)) {
    url <- gsub("{presentationId}", presentation_id, url, fixed = TRUE)
  }
  if (!is.null(page_object_id)) {
    url <- gsub("{pageObjectId}", page_object_id, url, fixed = TRUE)
  }

  required <- .slides_url_params[[endpoint]]
  unsubstituted <- required[
    (required == "presentationId" & is.null(presentation_id)) |
    (required == "pageObjectId"   & is.null(page_object_id))
  ]
  if (length(unsubstituted) > 0) {
    cli::cli_abort(
      c(
        "Missing required argument{?s} for the {.val {endpoint}} endpoint.",
        "x" = "The following ID{?s} must be supplied: {.arg {unsubstituted}}."
      )
    )
  }

  url
}
