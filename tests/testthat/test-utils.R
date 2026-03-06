test_that("check_string accepts valid strings", {
  expect_invisible(check_string("hello"))
})

test_that("check_string rejects non-strings", {
  expect_error(check_string(123), "must be a single string")
  expect_error(check_string(c("a", "b")), "must be a single string")
  expect_error(check_string(NULL), "must be a single string")
  expect_error(check_string(NA_character_), "must be a single string")
})

test_that("check_string allow_null works", {
  expect_invisible(check_string(NULL, allow_null = TRUE))
  expect_error(check_string(123, allow_null = TRUE), "must be a single string")
})

test_that("check_bool accepts TRUE/FALSE", {
  expect_invisible(check_bool(TRUE))
  expect_invisible(check_bool(FALSE))
})

test_that("check_bool rejects non-booleans", {
  expect_error(check_bool(1), "must be.*TRUE.*FALSE")
  expect_error(check_bool("yes"), "must be.*TRUE.*FALSE")
  expect_error(check_bool(NA), "must be.*TRUE.*FALSE")
})

test_that("is.google_slide_request identifies correct objects", {
  req <- google_slide_request_container$new()
  expect_true(is.google_slide_request(req))
  expect_false(is.google_slide_request(list()))
  expect_false(is.google_slide_request("not a request"))
  expect_false(is.google_slide_request(NULL))
})

test_that("is.page_element_property identifies correct objects", {
  prop <- page_element_property("slide-1")
  expect_true(is.page_element_property(prop))
  expect_false(is.page_element_property(list()))
  expect_false(is.page_element_property(NULL))
})

test_that("check_slide_request errors on non-request", {
  expect_error(check_slide_request(list()), "GoogleSlidesRequest")
})

test_that("check_page_element_property errors on non-property", {
  expect_error(check_page_element_property(list()), "PageElementProperty")
})

test_that("check_positive_number accepts positive values", {
  expect_invisible(check_positive_number(1))
  expect_invisible(check_positive_number(0.001))
  expect_invisible(check_positive_number(1e6))
})

test_that("check_positive_number rejects zero, negative, non-finite, non-numeric", {
  expect_error(check_positive_number(0), "positive number")
  expect_error(check_positive_number(-1), "positive number")
  expect_error(check_positive_number(Inf), "positive number")
  expect_error(check_positive_number(NaN), "positive number")
  expect_error(check_positive_number(NA_real_), "positive number")
  expect_error(check_positive_number("1"), "positive number")
})

test_that("check_positive_number allow_null works", {
  expect_invisible(check_positive_number(NULL, allow_null = TRUE))
  expect_error(check_positive_number(0, allow_null = TRUE), "positive number")
})

test_that("check_count accepts positive whole numbers", {
  expect_invisible(check_count(1))
  expect_invisible(check_count(20))
  expect_invisible(check_count(1L))
})

test_that("check_count rejects zero, negative, fractions, non-finite, non-numeric", {
  expect_error(check_count(0), "positive whole number")
  expect_error(check_count(-1), "positive whole number")
  expect_error(check_count(1.5), "positive whole number")
  expect_error(check_count(Inf), "positive whole number")
  expect_error(check_count(NA_real_), "positive whole number")
  expect_error(check_count("1"), "positive whole number")
})

test_that("check_count allow_null works", {
  expect_invisible(check_count(NULL, allow_null = TRUE))
  expect_error(check_count(0, allow_null = TRUE), "positive whole number")
})

test_that("check_index accepts non-negative whole numbers", {
  expect_invisible(check_index(0))
  expect_invisible(check_index(1))
  expect_invisible(check_index(100L))
})

test_that("check_index rejects negative, fractions, non-finite, non-numeric", {
  expect_error(check_index(-1), "non-negative whole number")
  expect_error(check_index(0.5), "non-negative whole number")
  expect_error(check_index(Inf), "non-negative whole number")
  expect_error(check_index(NA_real_), "non-negative whole number")
  expect_error(check_index("0"), "non-negative whole number")
})

test_that("check_index allow_null works", {
  expect_invisible(check_index(NULL, allow_null = TRUE))
  expect_error(check_index(-1, allow_null = TRUE), "non-negative whole number")
})

test_that("check_character_vector accepts non-empty character vectors", {
  expect_invisible(check_character_vector(c("a", "b")))
  expect_invisible(check_character_vector("single"))
})

test_that("check_character_vector rejects empty, non-character, or NA-containing vectors", {
  expect_error(check_character_vector(character(0)), "non-empty character vector")
  expect_error(check_character_vector(c("a", NA_character_)), "non-empty character vector")
  expect_error(check_character_vector(1:3), "non-empty character vector")
  expect_error(check_character_vector(NULL), "non-empty character vector")
})

test_that("check_character_vector allow_null works", {
  expect_invisible(check_character_vector(NULL, allow_null = TRUE))
  expect_error(check_character_vector(character(0), allow_null = TRUE), "non-empty character vector")
})

test_that("check_shape_type accepts valid shape types", {
  expect_invisible(check_shape_type("RECTANGLE"))
  expect_invisible(check_shape_type("STAR_5"))
  expect_invisible(check_shape_type("FLOW_CHART_DECISION"))
})

test_that("check_shape_type rejects invalid values", {
  expect_error(check_shape_type("BANANA"), "not recognised")
  expect_error(check_shape_type("rectangle"), "not recognised")
  expect_error(check_shape_type(123), "must be a single string")
})

test_that("check_predefined_layout accepts valid layouts", {
  expect_invisible(check_predefined_layout("BLANK"))
  expect_invisible(check_predefined_layout("TITLE_AND_BODY"))
  expect_invisible(check_predefined_layout("BIG_NUMBER"))
})

test_that("check_predefined_layout rejects invalid values", {
  expect_error(check_predefined_layout("FULL_PAGE"), "not recognised")
  expect_error(check_predefined_layout(1), "must be a single string")
})

test_that("check_predefined_layout allow_null works", {
  expect_invisible(check_predefined_layout(NULL, allow_null = TRUE))
})

test_that("check_range_type accepts valid types", {
  expect_invisible(check_range_type("ALL"))
  expect_invisible(check_range_type("FIXED_RANGE"))
  expect_invisible(check_range_type("FROM_START_INDEX"))
})

test_that("check_range_type rejects invalid values", {
  expect_error(check_range_type("PARTIAL"), "not recognised")
  expect_error(check_range_type(1), "must be a single string")
})

test_that("check_replace_method accepts valid methods", {
  expect_invisible(check_replace_method("CENTER_INSIDE"))
  expect_invisible(check_replace_method("CENTER_CROP"))
})

test_that("check_replace_method rejects invalid values", {
  expect_error(check_replace_method("STRETCH"), "not recognised")
  expect_error(check_replace_method(1), "must be a single string")
})

test_that("check_unit accepts PT and EMU", {
  expect_invisible(check_unit("PT"))
  expect_invisible(check_unit("EMU"))
})

test_that("check_unit rejects invalid values", {
  expect_error(check_unit("px"), "not recognised")
  expect_error(check_unit("pt"), "not recognised")
  expect_error(check_unit(1), "must be a single string")
})

test_that("check_video_source accepts YOUTUBE and DRIVE", {
  expect_invisible(check_video_source("YOUTUBE"))
  expect_invisible(check_video_source("DRIVE"))
})

test_that("check_video_source rejects invalid values", {
  expect_error(check_video_source("VIMEO"), "not recognised")
  expect_error(check_video_source(1), "must be a single string")
})

test_that("dataframe_convert with headers produces correct row/column indices", {
  df <- data.frame(a = c(1, 2), b = c(3, 4))
  result <- dataframe_convert(df, headers = TRUE)

  expect_equal(nrow(result), 6)
  expect_equal(result$value[1], "a")
  expect_equal(result$value[2], "b")
  expect_equal(result$row[1], 0)
  expect_equal(result$column[1], 0)
  expect_equal(result$column[2], 1)
  # data row 1 starts at API row 1
  expect_equal(result$row[3], 1)
  expect_equal(result$value[3], "1")
})

test_that("dataframe_convert without headers produces 0-based row indices", {
  df <- data.frame(a = c(1, 2), b = c(3, 4))
  result <- dataframe_convert(df, headers = FALSE)

  expect_equal(nrow(result), 4)
  expect_equal(result$value[1], "1")
  expect_equal(result$row[1], 0)
  expect_equal(result$row[3], 1)
})

test_that("dataframe_convert preserves row-major order", {
  df <- data.frame(x = c("a", "b"), y = c("c", "d"), stringsAsFactors = FALSE)
  result <- dataframe_convert(df, headers = FALSE)
  expect_equal(result$value, c("a", "c", "b", "d"))
  expect_equal(result$row,    c(0, 0, 1, 1))
  expect_equal(result$column, c(0, 1, 0, 1))
})

test_that("dataframe_convert coerces values to character", {
  df <- data.frame(n = c(1.5, 2.5))
  result <- dataframe_convert(df, headers = FALSE)
  expect_type(result$value, "character")
})

test_that("aligned_page_element_property center mode", {
  prop <- aligned_page_element_property("p", image_height = 100, image_width = 200)
  expect_true(is.page_element_property(prop))
  result <- prop$to_list()
  expect_equal(result$pageObjectId, "p")
  expect_false(is.null(result$transform))
  expect_equal(result$transform$scaleX, 1)
})

test_that("aligned_page_element_property full mode", {
  prop <- aligned_page_element_property("p", align = "full")
  result <- prop$to_list()
  expect_equal(result$transform$translateX, 0)
  expect_equal(result$transform$translateY, 0)
})

test_that("aligned_page_element_property rejects invalid align", {
  expect_error(
    aligned_page_element_property("p", align = "left"),
    "center.*full"
  )
})
