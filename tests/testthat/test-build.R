test_that("add_create_slide_page_request creates blank slide by default", {
  req <- add_create_slide_page_request()
  result <- req$to_list()
  expect_length(result, 1)
  expect_equal(
    result[[1]]$createSlide$slideLayoutReference$predefinedLayout,
    "BLANK"
  )
})

test_that("add_create_slide_page_request uses predefined layout", {
  req <- add_create_slide_page_request(predefined_layout = "TITLE")
  result <- req$to_list()
  expect_equal(
    result[[1]]$createSlide$slideLayoutReference$predefinedLayout,
    "TITLE"
  )
})

test_that("add_create_slide_page_request sets objectId inside createSlide only", {
  req <- add_create_slide_page_request(object_id = "my-slide")
  result <- req$to_list()[[1]]
  expect_equal(result$createSlide$objectId, "my-slide")
  expect_null(result$objectId)
})

test_that("add_create_slide_page_request validates inputs", {
  req <- add_create_slide_page_request()
  expect_true(is.google_slide_request(req))
})

test_that("add_create_shape_request builds correct structure", {
  prop <- page_element_property("slide-1", width_magnitude = 100, height_magnitude = 50)
  req <- add_create_shape_request(shape_type = "RECTANGLE",
                                  page_element_property = prop)
  result <- req$to_list()[[1]]
  expect_equal(result$createShape$shapeType, "RECTANGLE")
  expect_false(is.null(result$createShape$elementProperties))
})

test_that("add_create_table_request builds correct structure", {
  prop <- page_element_property("slide-1")
  req <- add_create_table_request(page_element_property = prop, rows = 3, columns = 2)
  result <- req$to_list()[[1]]
  expect_equal(result$createTable$rows, 3)
  expect_equal(result$createTable$columns, 2)
})

test_that("add_insert_text_request for shape", {
  req <- add_insert_text_request(object_id = "shape-1", text = "Hello")
  result <- req$to_list()[[1]]
  expect_equal(result$insertText$text, "Hello")
  expect_equal(result$insertText$objectId, "shape-1")
  expect_null(result$insertText$cellLocation)
})

test_that("add_insert_text_request for table cell", {
  req <- add_insert_text_request(
    object_id = "table-1", text = "Cell value",
    row_index = 0, column_index = 1
  )
  result <- req$to_list()[[1]]
  expect_equal(result$insertText$cellLocation$rowIndex, 0)
  expect_equal(result$insertText$cellLocation$columnIndex, 1)
})

test_that("add_insert_text_request errors when only row_index provided", {
  expect_error(
    add_insert_text_request(object_id = "t", text = "x", row_index = 0),
    "both be provided or both be"
  )
})

test_that("add_insert_text_request errors when only column_index provided", {
  expect_error(
    add_insert_text_request(object_id = "t", text = "x", column_index = 1),
    "both be provided or both be"
  )
})

test_that("add_insert_table_rows_request nests cellLocation correctly", {
  req <- add_insert_table_rows_request(
    table_object_id = "table-1",
    row_index = 0, column_index = 0,
    insert_below = TRUE, number = 2
  )
  result <- req$to_list()[[1]]
  expect_equal(result$insertTableRows$cellLocation$rowIndex, 0)
  expect_equal(result$insertTableRows$cellLocation$columnIndex, 0)
  expect_null(result$cellLocation)
})

test_that("add_insert_table_columns_request nests cellLocation correctly", {
  req <- add_insert_table_columns_request(
    table_object_id = "table-1",
    row_index = 0, column_index = 0,
    insert_right = TRUE, number = 1
  )
  result <- req$to_list()[[1]]
  expect_equal(result$insertTableColumns$cellLocation$rowIndex, 0)
  expect_null(result$cellLocation)
})

test_that("add_delete_table_row_request nests cellLocation correctly", {
  req <- add_delete_table_row_request(
    table_object_id = "table-1",
    row_index = 1, column_index = 0
  )
  result <- req$to_list()[[1]]
  expect_equal(result$deleteTableRow$cellLocation$rowIndex, 1)
  expect_null(result$cellLocation)
})

test_that("add_delete_table_column_request nests cellLocation correctly", {
  req <- add_delete_table_column_request(
    table_object_id = "table-1",
    row_index = 0, column_index = 2
  )
  result <- req$to_list()[[1]]
  expect_equal(result$deleteTableColumn$cellLocation$columnIndex, 2)
  expect_null(result$cellLocation)
})

test_that("add_insert_table_rows_request rejects number > 20", {
  expect_error(
    add_insert_table_rows_request(
      table_object_id = "t", row_index = 0, column_index = 0, number = 21
    ),
    "at most 20"
  )
})

test_that("add_replace_all_text_request builds correct structure", {
  req <- add_replace_all_text_request(
    replace_text = "New", text = "Old", match_case = FALSE
  )
  result <- req$to_list()[[1]]
  expect_equal(result$replaceAllText$replaceText, "New")
  expect_equal(result$replaceAllText$containsText$text, "Old")
  expect_false(result$replaceAllText$containsText$matchCase)
})

test_that("add_delete_object_request builds correct structure", {
  req <- add_delete_object_request(object_id = "obj-1")
  result <- req$to_list()[[1]]
  expect_equal(result$deleteObject$objectId, "obj-1")
})

test_that("add_update_slides_position_request uses as.list for IDs", {
  req <- add_update_slides_position_request(
    slide_object_ids = c("a", "b", "c"),
    insertion_index = 0
  )
  result <- req$to_list()[[1]]
  expect_equal(result$updateSlidesPosition$slideObjectIds, list("a", "b", "c"))
  expect_equal(result$updateSlidesPosition$insertionIndex, 0)
})

test_that("add_update_slides_position_request rejects empty vector", {
  expect_error(
    add_update_slides_position_request(
      slide_object_ids = character(0), insertion_index = 0
    ),
    "non-empty character vector"
  )
})

test_that("add_update_slides_position_request rejects NA in vector", {
  expect_error(
    add_update_slides_position_request(
      slide_object_ids = c("a", NA_character_), insertion_index = 0
    ),
    "non-empty character vector"
  )
})

test_that("add_delete_text_request builds ALL range by default", {
  req <- add_delete_text_request(object_id = "shape-1")
  result <- req$to_list()[[1]]
  expect_equal(result$deleteText$textRange$type, "ALL")
  expect_null(result$deleteText$textRange$startIndex)
})

test_that("add_delete_text_request builds FIXED_RANGE", {
  req <- add_delete_text_request(
    object_id = "shape-1",
    start_index = 0, end_index = 5,
    type = "FIXED_RANGE"
  )
  result <- req$to_list()[[1]]
  expect_equal(result$deleteText$textRange$type, "FIXED_RANGE")
  expect_equal(result$deleteText$textRange$startIndex, 0)
  expect_equal(result$deleteText$textRange$endIndex, 5)
})

test_that("add_delete_text_request errors when only row_index provided", {
  expect_error(
    add_delete_text_request(object_id = "x", row_index = 0),
    "both be provided or both be"
  )
})

test_that("add_delete_text_request errors when only column_index provided", {
  expect_error(
    add_delete_text_request(object_id = "x", column_index = 1),
    "both be provided or both be"
  )
})

test_that("requests can be chained", {
  req <- add_create_slide_page_request()
  req <- add_create_slide_page_request(req, predefined_layout = "TITLE")
  req <- add_delete_object_request(req, object_id = "obj-1")
  expect_length(req$to_list(), 3)
})

test_that("add_create_video_request builds correct structure with default YOUTUBE source", {
  prop <- page_element_property("slide-1", width_magnitude = 100, height_magnitude = 50)
  req <- add_create_video_request(
    id = "abc123",
    page_element_property = prop
  )
  result <- req$to_list()[[1]]
  expect_equal(result$createVideo$id, "abc123")
  expect_equal(result$createVideo$source, "YOUTUBE")
})

test_that("add_create_video_request accepts DRIVE source", {
  prop <- page_element_property("slide-1", width_magnitude = 100, height_magnitude = 50)
  req <- add_create_video_request(
    id = "drive-file-id",
    page_element_property = prop,
    source = "DRIVE"
  )
  result <- req$to_list()[[1]]
  expect_equal(result$createVideo$source, "DRIVE")
})

test_that("add_create_video_request rejects invalid source", {
  prop <- page_element_property("slide-1", width_magnitude = 100, height_magnitude = 50)
  expect_error(
    add_create_video_request(id = "x", page_element_property = prop, source = "VIMEO"),
    "not recognised"
  )
})

test_that("add_replace_all_shapes_with_image_request validates page_object_ids", {
  expect_error(
    add_replace_all_shapes_with_image_request(
      image_url = "https://example.com/img.png",
      text = "placeholder",
      page_object_ids = c("id", NA_character_)
    ),
    "non-empty character vector"
  )
  expect_error(
    add_replace_all_shapes_with_image_request(
      image_url = "https://example.com/img.png",
      text = "placeholder",
      page_object_ids = character(0)
    ),
    "non-empty character vector"
  )
})

test_that("add_replace_all_shapes_with_image_request accepts NULL page_object_ids", {
  req <- add_replace_all_shapes_with_image_request(
    image_url = "https://example.com/img.png",
    text = "placeholder",
    page_object_ids = NULL
  )
  result <- req$to_list()[[1]]
  expect_null(result$replaceAllShapesWithImage$pageObjectIds)
})

test_that("add_replace_all_shapes_with_image_request passes page_object_ids as list", {
  req <- add_replace_all_shapes_with_image_request(
    image_url = "https://example.com/img.png",
    text = "placeholder",
    page_object_ids = c("p1", "p2")
  )
  result <- req$to_list()[[1]]
  expect_equal(result$replaceAllShapesWithImage$pageObjectIds, list("p1", "p2"))
})

# ---- Input validation error cases --------------------------------------------

test_that("add_create_slide_page_request rejects invalid predefined_layout", {
  expect_error(
    add_create_slide_page_request(predefined_layout = "FULL_PAGE"),
    "not recognised"
  )
})

test_that("add_create_slide_page_request rejects fractional insertion_index", {
  expect_error(
    add_create_slide_page_request(insertion_index = 1.5),
    "non-negative whole number"
  )
})

test_that("add_create_slide_page_request rejects negative insertion_index", {
  expect_error(
    add_create_slide_page_request(insertion_index = -1),
    "non-negative whole number"
  )
})

test_that("add_create_shape_request rejects invalid shape_type", {
  prop <- page_element_property("slide-1", width_magnitude = 100, height_magnitude = 50)
  expect_error(
    add_create_shape_request(shape_type = "BANANA", page_element_property = prop),
    "not recognised"
  )
})

test_that("add_create_table_request rejects rows = 0", {
  prop <- page_element_property("slide-1")
  expect_error(
    add_create_table_request(page_element_property = prop, rows = 0, columns = 2),
    "positive whole number"
  )
})

test_that("add_create_table_request rejects fractional columns", {
  prop <- page_element_property("slide-1")
  expect_error(
    add_create_table_request(page_element_property = prop, rows = 2, columns = 1.5),
    "positive whole number"
  )
})

test_that("add_insert_table_rows_request rejects number = 0", {
  expect_error(
    add_insert_table_rows_request(
      table_object_id = "t", row_index = 0, column_index = 0, number = 0
    ),
    "positive whole number"
  )
})

test_that("add_insert_table_rows_request rejects negative row_index", {
  expect_error(
    add_insert_table_rows_request(
      table_object_id = "t", row_index = -1, column_index = 0, number = 1
    ),
    "non-negative whole number"
  )
})

test_that("add_replace_all_shapes_with_image_request rejects invalid replace_method", {
  expect_error(
    add_replace_all_shapes_with_image_request(
      image_url = "https://example.com/img.png",
      replace_method = "STRETCH",
      text = "placeholder"
    ),
    "not recognised"
  )
})

test_that("add_delete_text_request errors when FIXED_RANGE missing start_index", {
  expect_error(
    add_delete_text_request(object_id = "x", type = "FIXED_RANGE"),
    "start_index.*required"
  )
})

test_that("add_delete_text_request errors when FIXED_RANGE missing end_index", {
  expect_error(
    add_delete_text_request(
      object_id = "x", type = "FIXED_RANGE", start_index = 0
    ),
    "end_index.*required"
  )
})

test_that("add_delete_text_request errors when FROM_START_INDEX missing start_index", {
  expect_error(
    add_delete_text_request(object_id = "x", type = "FROM_START_INDEX"),
    "start_index.*required"
  )
})

test_that("add_delete_text_request warns when end_index provided for ALL", {
  expect_warning(
    add_delete_text_request(object_id = "x", type = "ALL", end_index = 5),
    "end_index.*ignored"
  )
})

test_that("add_delete_text_request FIXED_RANGE sets both indices", {
  req <- add_delete_text_request(
    object_id = "x", type = "FIXED_RANGE",
    start_index = 2, end_index = 7
  )
  result <- req$to_list()[[1]]
  expect_equal(result$deleteText$textRange$startIndex, 2)
  expect_equal(result$deleteText$textRange$endIndex, 7)
})

test_that("add_delete_text_request FROM_START_INDEX sets only start_index", {
  req <- add_delete_text_request(
    object_id = "x", type = "FROM_START_INDEX", start_index = 3
  )
  result <- req$to_list()[[1]]
  expect_equal(result$deleteText$textRange$startIndex, 3)
  expect_null(result$deleteText$textRange$endIndex)
})
