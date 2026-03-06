#' Authorize R package to access Google Slides API
#'
#' @description
#' `r lifecycle::badge("deprecated")`
#'
#' `authorize()` was deprecated in rgoogleslides 1.0.0 in favour of
#' [gs_auth()], which uses the gargle package for authentication and
#' supports service accounts, token caching, and token sharing with
#' other Google API packages.
#'
#' @param ... Arguments passed on to [gs_auth()].
#'
#' @return Called for its side effect of storing a token. Returns the token
#'   invisibly.
#' @keywords internal
#' @export
authorize <- function(...) {
  lifecycle::deprecate_warn("1.0.0", "authorize()", "gs_auth()")
  gs_auth(...)
}
