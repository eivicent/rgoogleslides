#' Add a create slide request
#'
#' @param google_slides_request A `GoogleSlidesRequest` object, or `NULL` to
#'   create a new one.
#' @param insertion_index Numeric index where the slide should be inserted.
#' @param layout_id Layout ID to use for the new slide.
#' @param predefined_layout Predefined layout name. One of `"BLANK"`,
#'   `"CAPTION_ONLY"`, `"TITLE"`, `"TITLE_AND_BODY"`,
#'   `"TITLE_AND_TWO_COLUMNS"`, `"TITLE_ONLY"`, `"SECTION_HEADER"`,
#'   `"SECTION_TITLE_AND_DESCRIPTION"`, `"ONE_COLUMN_TEXT"`,
#'   `"MAIN_POINT"`, `"BIG_NUMBER"`. Defaults to `"BLANK"`.
#' @param object_id Optional ID for the new slide.
#'
#' @return A `GoogleSlidesRequest` object with the request appended.
#' @export
#'
#' @examplesIf gs_has_token()
#' requests <- add_create_slide_page_request()
#' commit_to_slides("<slide-id>", requests)
add_create_slide_page_request <- function(google_slides_request = NULL,
                                          insertion_index = NULL,
                                          layout_id = NULL,
                                          predefined_layout = NULL,
                                          object_id = NULL) {
  if (is.null(google_slides_request)) {
    google_slides_request <- google_slide_request_container$new()
  }
  check_slide_request(google_slides_request)
  check_index(insertion_index, allow_null = TRUE)
  check_string(layout_id, allow_null = TRUE)
  check_predefined_layout(predefined_layout, allow_null = TRUE)
  check_string(object_id, allow_null = TRUE)

  create_slide_request <- list(createSlide = list(slideLayoutReference = list()))

  if (!is.null(object_id)) {
    create_slide_request[["createSlide"]][["objectId"]] <- object_id
  }
  if (!is.null(insertion_index)) {
    create_slide_request[["createSlide"]][["insertionIndex"]] <- insertion_index
  }

  if (!is.null(layout_id)) {
    create_slide_request[["createSlide"]][["slideLayoutReference"]][["layoutId"]] <- layout_id
  } else if (!is.null(predefined_layout)) {
    create_slide_request[["createSlide"]][["slideLayoutReference"]][["predefinedLayout"]] <- predefined_layout
  } else {
    create_slide_request[["createSlide"]][["slideLayoutReference"]][["predefinedLayout"]] <- "BLANK"
  }

  google_slides_request$add_request(create_slide_request)
  google_slides_request
}


#' Add a create shape request
#'
#' @param google_slides_request A `GoogleSlidesRequest` object, or `NULL`.
#' @param shape_type Shape type (e.g. `"RECTANGLE"`, `"STAR_5"`).
#' @param page_element_property A `PageElementProperty` object with width and
#'   height.
#' @param object_id Optional ID for the new shape.
#'
#' @return A `GoogleSlidesRequest` object with the request appended.
#' @export
#'
#' @examplesIf gs_has_token()
#' prop <- page_element_property("p", 200, 300)
#' request <- add_create_shape_request(shape_type = "RECTANGLE",
#'                                     page_element_property = prop)
add_create_shape_request <- function(google_slides_request = NULL,
                                     shape_type,
                                     page_element_property,
                                     object_id = NULL) {
  if (is.null(google_slides_request)) {
    google_slides_request <- google_slide_request_container$new()
  }
  check_slide_request(google_slides_request)
  check_page_element_property(page_element_property)
  check_shape_type(shape_type)
  check_string(object_id, allow_null = TRUE)

  create_shape_request <- list(
    createShape = list(
      elementProperties = page_element_property$to_list(),
      shapeType = shape_type
    )
  )

  if (!is.null(object_id)) {
    create_shape_request[["createShape"]][["objectId"]] <- object_id
  }

  google_slides_request$add_request(create_shape_request)
  google_slides_request
}


#' Add a create table request
#'
#' @param google_slides_request A `GoogleSlidesRequest` object, or `NULL`.
#' @param page_element_property A `PageElementProperty` object.
#' @param rows Number of rows.
#' @param columns Number of columns.
#' @param object_id Optional ID for the new table.
#'
#' @return A `GoogleSlidesRequest` object with the request appended.
#' @export
#'
#' @examplesIf gs_has_token()
#' prop <- page_element_property("<slide-page-id>", 300, 200)
#' request <- add_create_table_request(
#'   page_element_property = prop, rows = 3, columns = 4
#' )
add_create_table_request <- function(google_slides_request = NULL,
                                     page_element_property,
                                     rows, columns,
                                     object_id = NULL) {
  if (is.null(google_slides_request)) {
    google_slides_request <- google_slide_request_container$new()
  }
  check_slide_request(google_slides_request)
  check_page_element_property(page_element_property)
  check_count(rows)
  check_count(columns)
  check_string(object_id, allow_null = TRUE)

  create_table_request <- list(
    createTable = list(
      elementProperties = page_element_property$to_list(),
      rows = rows,
      columns = columns
    )
  )

  if (!is.null(object_id)) {
    create_table_request[["createTable"]][["objectId"]] <- object_id
  }

  google_slides_request$add_request(create_table_request)
  google_slides_request
}


#' Add an insert text request
#'
#' @param google_slides_request A `GoogleSlidesRequest` object, or `NULL`.
#' @param object_id ID of the shape or table to insert text into.
#' @param row_index Row index (for tables only). Must be provided together with
#'   `column_index`.
#' @param column_index Column index (for tables only). Must be provided together
#'   with `row_index`.
#' @param text Text to insert.
#' @param insertion_index Starting position for the text.
#'
#' @return A `GoogleSlidesRequest` object with the request appended.
#' @export
#'
#' @examplesIf gs_has_token()
#' request <- add_insert_text_request(object_id = "<shape-id>", text = "Hello, world!")
add_insert_text_request <- function(google_slides_request = NULL,
                                    object_id,
                                    row_index = NULL,
                                    column_index = NULL,
                                    text,
                                    insertion_index = NULL) {
  if (is.null(google_slides_request)) {
    google_slides_request <- google_slide_request_container$new()
  }
  check_slide_request(google_slides_request)
  check_string(object_id)
  check_index(row_index, allow_null = TRUE)
  check_index(column_index, allow_null = TRUE)
  check_string(text)
  check_index(insertion_index, allow_null = TRUE)

  if (xor(is.null(row_index), is.null(column_index))) {
    cli::cli_abort(
      "{.arg row_index} and {.arg column_index} must both be provided or both be {.code NULL}."
    )
  }

  insert_text_request <- list(
    insertText = list(text = text, objectId = object_id)
  )

  if (!is.null(row_index) && !is.null(column_index)) {
    insert_text_request[["insertText"]][["cellLocation"]] <- list(
      rowIndex    = row_index,
      columnIndex = column_index
    )
  }
  if (!is.null(insertion_index)) {
    insert_text_request[["insertText"]][["insertionIndex"]] <- insertion_index
  }

  google_slides_request$add_request(insert_text_request)
  google_slides_request
}


#' Add an insert table rows request
#'
#' @param google_slides_request A `GoogleSlidesRequest` object, or `NULL`.
#' @param table_object_id The table to insert rows into.
#' @param row_index The 0-based row index.
#' @param column_index The 0-based column index.
#' @param insert_below If `TRUE`, insert below the reference cell.
#' @param number Number of rows to insert (max 20).
#'
#' @return A `GoogleSlidesRequest` object with the request appended.
#' @export
#'
#' @examplesIf gs_has_token()
#' request <- add_insert_table_rows_request(
#'   table_object_id = "<table-id>",
#'   row_index = 0, column_index = 0, number = 1
#' )
add_insert_table_rows_request <- function(google_slides_request = NULL,
                                          table_object_id,
                                          row_index, column_index,
                                          insert_below = TRUE,
                                          number) {
  if (is.null(google_slides_request)) {
    google_slides_request <- google_slide_request_container$new()
  }
  check_slide_request(google_slides_request)
  check_string(table_object_id)
  check_index(row_index)
  check_index(column_index)
  check_bool(insert_below)
  check_count(number)
  if (number > 20) {
    cli::cli_abort("{.arg number} must be at most 20, not {number}.")
  }

  insert_table_rows_request <- list(
    insertTableRows = list(
      tableObjectId = table_object_id,
      insertBelow   = insert_below,
      number        = number,
      cellLocation  = list(
        rowIndex    = row_index,
        columnIndex = column_index
      )
    )
  )

  google_slides_request$add_request(insert_table_rows_request)
  google_slides_request
}


#' Add an insert table columns request
#'
#' @param google_slides_request A `GoogleSlidesRequest` object, or `NULL`.
#' @param table_object_id The table to insert columns into.
#' @param row_index The 0-based row index.
#' @param column_index The 0-based column index.
#' @param insert_right If `TRUE`, insert to the right of the reference cell.
#' @param number Number of columns to insert (max 20).
#'
#' @return A `GoogleSlidesRequest` object with the request appended.
#' @export
#'
#' @examplesIf gs_has_token()
#' request <- add_insert_table_columns_request(
#'   table_object_id = "<table-id>",
#'   row_index = 0, column_index = 0, number = 1
#' )
add_insert_table_columns_request <- function(google_slides_request = NULL,
                                             table_object_id,
                                             row_index, column_index,
                                             insert_right = TRUE,
                                             number) {
  if (is.null(google_slides_request)) {
    google_slides_request <- google_slide_request_container$new()
  }
  check_slide_request(google_slides_request)
  check_string(table_object_id)
  check_index(row_index)
  check_index(column_index)
  check_bool(insert_right)
  check_count(number)
  if (number > 20) {
    cli::cli_abort("{.arg number} must be at most 20, not {number}.")
  }

  insert_table_columns_request <- list(
    insertTableColumns = list(
      tableObjectId = table_object_id,
      insertRight   = insert_right,
      number        = number,
      cellLocation  = list(
        rowIndex    = row_index,
        columnIndex = column_index
      )
    )
  )

  google_slides_request$add_request(insert_table_columns_request)
  google_slides_request
}


#' Add a delete table row request
#'
#' @param google_slides_request A `GoogleSlidesRequest` object, or `NULL`.
#' @param table_object_id The table to delete a row from.
#' @param row_index The 0-based row index.
#' @param column_index The 0-based column index.
#'
#' @return A `GoogleSlidesRequest` object with the request appended.
#' @export
#'
#' @examplesIf gs_has_token()
#' request <- add_delete_table_row_request(
#'   "<table-id>", row_index = 0, column_index = 0
#' )
add_delete_table_row_request <- function(google_slides_request = NULL,
                                         table_object_id,
                                         row_index, column_index) {
  if (is.null(google_slides_request)) {
    google_slides_request <- google_slide_request_container$new()
  }
  check_slide_request(google_slides_request)
  check_string(table_object_id)
  check_index(row_index)
  check_index(column_index)

  delete_table_row_request <- list(
    deleteTableRow = list(
      tableObjectId = table_object_id,
      cellLocation  = list(
        rowIndex    = row_index,
        columnIndex = column_index
      )
    )
  )

  google_slides_request$add_request(delete_table_row_request)
  google_slides_request
}


#' Add a delete table column request
#'
#' @param google_slides_request A `GoogleSlidesRequest` object, or `NULL`.
#' @param table_object_id The table to delete a column from.
#' @param row_index The 0-based row index.
#' @param column_index The 0-based column index.
#'
#' @return A `GoogleSlidesRequest` object with the request appended.
#' @export
#'
#' @examplesIf gs_has_token()
#' request <- add_delete_table_column_request(
#'   "<table-id>", row_index = 0, column_index = 0
#' )
add_delete_table_column_request <- function(google_slides_request = NULL,
                                            table_object_id,
                                            row_index, column_index) {
  if (is.null(google_slides_request)) {
    google_slides_request <- google_slide_request_container$new()
  }
  check_slide_request(google_slides_request)
  check_string(table_object_id)
  check_index(row_index)
  check_index(column_index)

  delete_table_column_request <- list(
    deleteTableColumn = list(
      tableObjectId = table_object_id,
      cellLocation  = list(
        rowIndex    = row_index,
        columnIndex = column_index
      )
    )
  )

  google_slides_request$add_request(delete_table_column_request)
  google_slides_request
}


#' Add a replace all text request
#'
#' @param google_slides_request A `GoogleSlidesRequest` object, or `NULL`.
#' @param replace_text Replacement text.
#' @param text Text to search for.
#' @param match_case Whether to match case.
#'
#' @return A `GoogleSlidesRequest` object with the request appended.
#' @export
#'
#' @examplesIf gs_has_token()
#' request <- add_replace_all_text_request(replace_text = "new", text = "old")
add_replace_all_text_request <- function(google_slides_request = NULL,
                                         replace_text,
                                         text,
                                         match_case = TRUE) {
  if (is.null(google_slides_request)) {
    google_slides_request <- google_slide_request_container$new()
  }
  check_slide_request(google_slides_request)
  check_string(replace_text)
  check_string(text)
  check_bool(match_case)

  replace_all_text_list <- list(
    replaceAllText = list(
      replaceText  = replace_text,
      containsText = list(text = text, matchCase = match_case)
    )
  )

  google_slides_request$add_request(replace_all_text_list)
  google_slides_request
}


#' Add a delete object request
#'
#' @param google_slides_request A `GoogleSlidesRequest` object, or `NULL`.
#' @param object_id ID of the object to delete.
#'
#' @return A `GoogleSlidesRequest` object with the request appended.
#' @export
#'
#' @examplesIf gs_has_token()
#' request <- add_delete_object_request(object_id = "<shape-id>")
add_delete_object_request <- function(google_slides_request = NULL,
                                      object_id) {
  if (is.null(google_slides_request)) {
    google_slides_request <- google_slide_request_container$new()
  }
  check_slide_request(google_slides_request)
  check_string(object_id)

  delete_object_request <- list(deleteObject = list(objectId = object_id))

  google_slides_request$add_request(delete_object_request)
  google_slides_request
}


#' Add an update slides position request
#'
#' @param google_slides_request A `GoogleSlidesRequest` object, or `NULL`.
#' @param slide_object_ids Character vector of slide IDs to move.
#' @param insertion_index Position to move the slides to.
#'
#' @return A `GoogleSlidesRequest` object with the request appended.
#' @export
#'
#' @examplesIf gs_has_token()
#' request <- add_update_slides_position_request(
#'   slide_object_ids = "<slide-id>", insertion_index = 0
#' )
add_update_slides_position_request <- function(google_slides_request = NULL,
                                               slide_object_ids,
                                               insertion_index) {
  if (is.null(google_slides_request)) {
    google_slides_request <- google_slide_request_container$new()
  }
  check_slide_request(google_slides_request)
  check_character_vector(slide_object_ids)
  check_index(insertion_index)

  update_slides_position_request <- list(
    updateSlidesPosition = list(
      slideObjectIds = as.list(slide_object_ids),
      insertionIndex = insertion_index
    )
  )

  google_slides_request$add_request(update_slides_position_request)
  google_slides_request
}


#' Add a delete text request
#'
#' @param google_slides_request A `GoogleSlidesRequest` object, or `NULL`.
#' @param object_id ID of the shape or table containing the text.
#' @param row_index Row index (for tables only). Must be provided together with
#'   `column_index`.
#' @param column_index Column index (for tables only). Must be provided together
#'   with `row_index`.
#' @param start_index Start index (required for `"FIXED_RANGE"` and
#'   `"FROM_START_INDEX"`).
#' @param end_index End index (required for `"FIXED_RANGE"`).
#' @param type Range type: `"ALL"`, `"FIXED_RANGE"`, or `"FROM_START_INDEX"`.
#'
#' @return A `GoogleSlidesRequest` object with the request appended.
#' @export
#'
#' @examplesIf gs_has_token()
#' request <- add_delete_text_request(object_id = "<shape-id>")
add_delete_text_request <- function(google_slides_request = NULL,
                                    object_id,
                                    row_index = NULL,
                                    column_index = NULL,
                                    start_index = NULL,
                                    end_index = NULL,
                                    type = "ALL") {
  if (is.null(google_slides_request)) {
    google_slides_request <- google_slide_request_container$new()
  }
  check_slide_request(google_slides_request)
  check_string(object_id)
  check_index(row_index, allow_null = TRUE)
  check_index(column_index, allow_null = TRUE)
  check_index(start_index, allow_null = TRUE)
  check_index(end_index, allow_null = TRUE)
  check_range_type(type)

  if (xor(is.null(row_index), is.null(column_index))) {
    cli::cli_abort(
      "{.arg row_index} and {.arg column_index} must both be provided or both be {.code NULL}."
    )
  }

  if (type %in% c("FIXED_RANGE", "FROM_START_INDEX") && is.null(start_index)) {
    cli::cli_abort(
      "{.arg start_index} is required when {.arg type} is {.val {type}}."
    )
  }
  if (type == "FIXED_RANGE" && is.null(end_index)) {
    cli::cli_abort(
      "{.arg end_index} is required when {.arg type} is {.val FIXED_RANGE}."
    )
  }
  if (type != "FIXED_RANGE" && !is.null(end_index)) {
    cli::cli_warn(
      "{.arg end_index} is ignored when {.arg type} is {.val {type}}."
    )
  }

  delete_text_request <- list(
    deleteText = list(objectId = object_id)
  )

  if (!is.null(row_index) && !is.null(column_index)) {
    delete_text_request[["deleteText"]][["cellLocation"]] <- list(
      rowIndex    = row_index,
      columnIndex = column_index
    )
  }

  delete_text_request[["deleteText"]][["textRange"]] <- list(type = type)
  if (type == "FIXED_RANGE") {
    delete_text_request[["deleteText"]][["textRange"]][["startIndex"]] <- start_index
    delete_text_request[["deleteText"]][["textRange"]][["endIndex"]]   <- end_index
  } else if (type == "FROM_START_INDEX") {
    delete_text_request[["deleteText"]][["textRange"]][["startIndex"]] <- start_index
  }

  google_slides_request$add_request(delete_text_request)
  google_slides_request
}


#' Add a create image request
#'
#' @param google_slides_request A `GoogleSlidesRequest` object, or `NULL`.
#' @param page_element_property A `PageElementProperty` object.
#' @param url An image URL, or a Google Drive file ID.
#' @param object_id Optional ID for the new image.
#'
#' @details
#' When `url` is a Google Drive file ID (not an `http://` or `https://` URL),
#' the function constructs a Drive download URL that embeds a short-lived OAuth
#' access token as a query parameter. This URL is sent to the Slides API, which
#' fetches the image server-side. The token is not stored or cached by this
#' package, but it will appear in network logs and the Slides API request body.
#' For sensitive environments prefer passing a publicly accessible HTTPS URL.
#'
#' @return A `GoogleSlidesRequest` object with the request appended.
#' @export
#'
#' @examplesIf gs_has_token()
#' prop <- page_element_property("<slide-page-id>", 300, 200)
#' request <- add_create_image_request(
#'   page_element_property = prop,
#'   url = "https://example.com/image.png"
#' )
add_create_image_request <- function(google_slides_request = NULL,
                                     page_element_property,
                                     url, object_id = NULL) {
  if (is.null(google_slides_request)) {
    google_slides_request <- google_slide_request_container$new()
  }
  check_slide_request(google_slides_request)
  check_page_element_property(page_element_property)
  check_string(url)
  check_string(object_id, allow_null = TRUE)

  create_image_request <- list(
    createImage = list(
      elementProperties = page_element_property$to_list(),
      url = .resolve_image_url(url)
    )
  )

  if (!is.null(object_id)) {
    create_image_request[["createImage"]][["objectId"]] <- object_id
  }

  google_slides_request$add_request(create_image_request)
  google_slides_request
}


#' Add a create video request
#'
#' @param google_slides_request A `GoogleSlidesRequest` object, or `NULL`.
#' @param id Video ID. For `source = "YOUTUBE"` this is the YouTube video ID
#'   (e.g. `"7U3axjORYZ0"`). For `source = "DRIVE"` this is the Google Drive
#'   file ID.
#' @param page_element_property A `PageElementProperty` object.
#' @param source Video source: `"YOUTUBE"` (default) or `"DRIVE"`.
#' @param object_id Optional ID for the new video.
#'
#' @return A `GoogleSlidesRequest` object with the request appended.
#' @export
#'
#' @examplesIf gs_has_token()
#' prop <- aligned_page_element_property("p", align = "full")
#' request <- add_create_video_request(id = "<youtube-id>",
#'                                     page_element_property = prop)
add_create_video_request <- function(google_slides_request = NULL, id,
                                     page_element_property,
                                     source = "YOUTUBE",
                                     object_id = NULL) {
  if (is.null(google_slides_request)) {
    google_slides_request <- google_slide_request_container$new()
  }
  check_slide_request(google_slides_request)
  check_string(id)
  check_page_element_property(page_element_property)
  check_video_source(source)
  check_string(object_id, allow_null = TRUE)

  create_video_request <- list(
    createVideo = list(
      elementProperties = page_element_property$to_list(),
      id     = id,
      source = source
    )
  )

  if (!is.null(object_id)) {
    create_video_request[["createVideo"]][["objectId"]] <- object_id
  }

  google_slides_request$add_request(create_video_request)
  google_slides_request
}


#' Add a replace all shapes with image request
#'
#' @param google_slides_request A `GoogleSlidesRequest` object, or `NULL`.
#' @param image_url Image URL or Google Drive file ID.
#' @param replace_method `"CENTER_INSIDE"` or `"CENTER_CROP"`.
#' @param page_object_ids Character vector of page IDs to restrict to. If
#'   `NULL`, the replacement applies to all pages.
#' @param text Text to match in the shapes to replace.
#' @param match_case Whether to match case.
#'
#' @details
#' When `image_url` is a Google Drive file ID (not an `http://` or `https://`
#' URL), the function constructs a Drive download URL that embeds a short-lived
#' OAuth access token as a query parameter. See `add_create_image_request()`
#' for the full security note.
#'
#' @return A `GoogleSlidesRequest` object with the request appended.
#' @export
#'
#' @examplesIf gs_has_token()
#' request <- add_replace_all_shapes_with_image_request(
#'   image_url = "https://example.com/image.png",
#'   text = "placeholder"
#' )
add_replace_all_shapes_with_image_request <- function(
    google_slides_request = NULL,
    image_url,
    replace_method = "CENTER_INSIDE",
    page_object_ids = NULL,
    text,
    match_case = TRUE) {
  if (is.null(google_slides_request)) {
    google_slides_request <- google_slide_request_container$new()
  }
  check_slide_request(google_slides_request)
  check_string(image_url)
  check_replace_method(replace_method)
  check_character_vector(page_object_ids, allow_null = TRUE)
  check_string(text)
  check_bool(match_case)

  replace_request <- list(
    replaceAllShapesWithImage = list(
      imageUrl      = .resolve_image_url(image_url),
      replaceMethod = replace_method,
      containsText  = list(text = text, matchCase = match_case)
    )
  )

  if (!is.null(page_object_ids)) {
    replace_request[["replaceAllShapesWithImage"]][["pageObjectIds"]] <- as.list(page_object_ids)
  }

  google_slides_request$add_request(replace_request)
  google_slides_request
}
