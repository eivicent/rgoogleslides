#' Create a new Google Slides presentation
#'
#' @param title Title of the presentation.
#' @param full_response If `TRUE`, return the full API response. If `FALSE`
#'   (default), return just the presentation ID.
#'
#' @return If `full_response` is `FALSE`, a string with the presentation ID.
#'   If `TRUE`, a list containing the full API response.
#' @export
#'
#' @examplesIf gs_has_token()
#' id <- create_slides("My Presentation")
create_slides <- function(title = NULL, full_response = FALSE) {
  check_string(title, allow_null = TRUE)
  check_bool(full_response)
  url <- gs_build_url("create")
  body <- list(title = title)

  result_list <- gs_request_make("POST", url, body = body)

  if (full_response) {
    result_list
  } else {
    result_list$presentationId
  }
}

#' Get Google Slides properties
#'
#' Retrieve the full properties of a Google Slides presentation.
#'
#' @param id Presentation ID.
#'
#' @return A list containing the presentation properties.
#' @export
#'
#' @examplesIf gs_has_token()
#' props <- get_slides_properties("<presentation-id>")
get_slides_properties <- function(id) {
  check_string(id)
  url <- gs_build_url("get", presentation_id = id)
  gs_request_make("GET", url)
}

#' Get a single page of a Google Slides presentation
#'
#' @param id Presentation ID.
#' @param page_object_id The page object ID.
#' @param response Type of response: `"simple"` returns a parsed object with
#'   helper methods, `"raw"` returns the raw API response list.
#'
#' @return If `response` is `"simple"`, a `SlidePage` R6 object with methods
#'   `get_tables()`, `get_text_boxes()`, and `get_notes()`. If `"raw"`, a
#'   list containing the raw API response.
#' @export
#'
#' @examplesIf gs_has_token()
#' page <- get_slide_page_properties("<presentation-id>", "<page-id>")
get_slide_page_properties <- function(id, page_object_id,
                                      response = c("simple", "raw")) {
  response <- match.arg(response)
  check_string(id)
  check_string(page_object_id)

  url <- gs_build_url(
    "page_get",
    presentation_id = id,
    page_object_id  = page_object_id
  )

  result_list <- gs_request_make("GET", url)

  if (response == "raw") {
    result_list
  } else {
    slide_page_container$new(result_list)
  }
}


#' @noRd
#' @importFrom R6 R6Class
slide_page_container <- R6Class("SlidePage",
  public = list(
    #' @field raw_response The raw API response list.
    raw_response = NULL,

    #' @description Create a new SlidePage object.
    #' @param slide_page_list_response Raw list from API.
    initialize = function(slide_page_list_response) {
      self$raw_response <- slide_page_list_response
    },

    #' @description Retrieve tables from the slide page.
    #' @return A list of tables, each with `object_id` and `table` (a
    #'   data.frame).
    get_tables = function() {
      list_tables <- list()
      for (item in self$raw_response$pageElements) {
        if (!is.null(item$table)) {
          object_id <- item$objectId

          rows <- lapply(item$table$tableRows, function(table_row) {
            vapply(table_row$tableCells, function(table_cell) {
              text_content <- ""
              if (!is.null(table_cell$text$textElements)) {
                for (text_element in table_cell$text$textElements) {
                  if (!is.null(text_element$textRun)) {
                    text_content <- paste0(text_content, text_element$textRun$content)
                  }
                }
              }
              text_content
            }, character(1))
          })

          retrieved_table <- as.data.frame(
            do.call(rbind, rows),
            stringsAsFactors = FALSE
          )
          names(retrieved_table) <- NULL

          list_tables[[length(list_tables) + 1]] <- list(
            object_id = object_id,
            table     = retrieved_table
          )
        }
      }
      list_tables
    },

    #' @description Retrieve text boxes from the slide page.
    #' @return A data.frame with columns `object_id` and `text_content`.
    get_text_boxes = function() {
      results <- list()
      for (item in self$raw_response$pageElements) {
        if (!is.null(item$shape$shapeType) &&
            item$shape$shapeType == "TEXT_BOX") {
          text_content <- ""
          if (!is.null(item$shape$text$textElements)) {
            for (text_element in item$shape$text$textElements) {
              if (!is.null(text_element$textRun)) {
                text_content <- paste0(text_content, text_element$textRun$content)
              }
            }
          }
          results[[length(results) + 1]] <- data.frame(
            object_id    = item$objectId,
            text_content = text_content,
            stringsAsFactors = FALSE
          )
        }
      }
      if (length(results) == 0) {
        data.frame(object_id = character(0), text_content = character(0))
      } else {
        do.call(rbind, results)
      }
    },

    #' @description Retrieve speaker notes from the slide page.
    #' @return A data.frame with columns `object_id` and `text_content`.
    get_notes = function() {
      notes_page <- self$raw_response$slideProperties$notesPage
      if (is.null(notes_page)) {
        return(data.frame(object_id = character(0), text_content = character(0)))
      }

      results <- list()
      for (item in notes_page$pageElements) {
        if (!is.null(item$shape$shapeType) &&
            item$shape$shapeType == "TEXT_BOX") {
          text_content <- ""
          if (!is.null(item$shape$text$textElements)) {
            for (text_element in item$shape$text$textElements) {
              if (!is.null(text_element$textRun)) {
                text_content <- paste0(text_content, text_element$textRun$content)
              }
            }
          }
          results[[length(results) + 1]] <- data.frame(
            object_id    = item$objectId,
            text_content = text_content,
            stringsAsFactors = FALSE
          )
        }
      }
      if (length(results) == 0) {
        data.frame(object_id = character(0), text_content = character(0))
      } else {
        do.call(rbind, results)
      }
    }
  )
)
