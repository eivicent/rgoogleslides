#' @noRd
#' @importFrom R6 R6Class
google_slide_request_container <- R6Class("GoogleSlidesRequest",
  public = list(
    #' @field requests List of accumulated API requests.
    requests = list(),

    #' @description Append a request to the list.
    #' @param request A named list representing a single API request.
    add_request = function(request) {
      self$requests[[length(self$requests) + 1]] <- request
    },

    #' @description Convert accumulated requests to a list for serialization.
    #' @return A list of request objects.
    to_list = function() {
      self$requests
    },

    #' @description Print a human-readable summary.
    print = function(...) {
      n <- length(self$requests)
      types <- vapply(self$requests, function(r) names(r)[[1]], character(1))
      cli::cli_text("<GoogleSlidesRequest> [{n} request{?s}]")
      if (n > 0) {
        cli::cli_ul(types)
      }
      invisible(self)
    }
  )
)
