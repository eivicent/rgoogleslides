#' Commit changes to slides
#'
#' Send a batch of accumulated requests to the Google Slides API.
#'
#' @param id The presentation ID.
#' @param google_slide_request A `GoogleSlidesRequest` object created by the
#'   `add_*_request()` functions.
#'
#' @return A list containing the API response with any reply data.
#' @export
#'
#' @examplesIf gs_has_token()
#' request <- add_create_slide_page_request()
#' commit_to_slides("<presentation-id>", request)
commit_to_slides <- function(id, google_slide_request) {
  check_string(id)
  check_slide_request(google_slide_request)

  url <- gs_build_url("batch", presentation_id = id)
  body <- list(requests = google_slide_request$to_list())

  gs_request_make("POST", url, body = body)
}
