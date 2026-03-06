#' Create and upload data into a table in slides
#'
#' Creates a table on a slide and fills it with data from a data frame.
#' This makes two API calls: one to create the table and one to fill it.
#'
#' @param id Presentation ID.
#' @param page_element_property A `PageElementProperty` object.
#' @param data A data frame to insert into the table.
#' @param headers If `TRUE`, include column names as the first row.
#'
#' @return A list containing the API response from the text insertion.
#' @export
#'
#' @examplesIf gs_has_token()
#' prop <- page_element_property("<slide-page-id>")
#' create_data_table("<presentation-id>", prop, iris[1:5, ])
create_data_table <- function(id = NULL, page_element_property = NULL,
                              data = NULL, headers = TRUE) {
  check_string(id)
  check_page_element_property(page_element_property)
  if (!is.data.frame(data)) {
    cli::cli_abort("{.arg data} must be a data frame, not {.obj_type_of {data}}.")
  }
  check_bool(headers)

  rows <- nrow(data)
  if (headers) rows <- rows + 1
  columns <- ncol(data)

  create_request <- add_create_table_request(
    page_element_property = page_element_property,
    rows = rows, columns = columns
  )
  result_list <- commit_to_slides(id, create_request)

  object_id <- result_list$replies[[1]]$createTable$objectId
  if (is.null(object_id)) {
    cli::cli_abort(c(
      "Table creation did not return an object ID.",
      "i" = "The API reply was: {.val {result_list$replies[[1]]}}"
    ))
  }

  converted_data <- dataframe_convert(data, headers)
  text_requests <- NULL
  for (row_no in seq_len(nrow(converted_data))) {
    text_requests <- add_insert_text_request(
      text_requests,
      object_id    = object_id,
      row_index    = converted_data$row[row_no],
      column_index = converted_data$column[row_no],
      text         = converted_data$value[row_no]
    )
  }
  commit_to_slides(id, text_requests)
}
