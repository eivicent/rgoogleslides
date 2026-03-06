test_that("page_element_property requires page_object_id", {
  expect_error(page_element_property(), "single string")
  expect_error(page_element_property(NULL), "single string")
  expect_error(page_element_property(123), "single string")
  expect_error(page_element_property(NA_character_), "single string")
})

test_that("page_element_property creates object with correct class", {
  prop <- page_element_property("slide-1")
  expect_true(is.page_element_property(prop))
  expect_s3_class(prop, "PageElementProperty")
})

test_that("to_list includes pageObjectId", {
  prop <- page_element_property("slide-1")
  result <- prop$to_list()
  expect_equal(result$pageObjectId, "slide-1")
})

test_that("to_list includes size when width/height set", {
  prop <- page_element_property("slide-1", width_magnitude = 100, height_magnitude = 200)
  result <- prop$to_list()
  expect_equal(result$size$width$magnitude, 100)
  expect_equal(result$size$width$unit, "PT")
  expect_equal(result$size$height$magnitude, 200)
  expect_equal(result$size$height$unit, "PT")
})

test_that("to_list includes size with only width", {
  prop <- page_element_property("slide-1", width_magnitude = 50)
  result <- prop$to_list()
  expect_equal(result$size$width$magnitude, 50)
  expect_null(result$size$height)
})

test_that("to_list includes transform when translate_x/y set (bug fix)", {
  prop <- page_element_property("slide-1", translate_x = 100, translate_y = 200)
  result <- prop$to_list()
  expect_false(is.null(result$transform))
  expect_equal(result$transform$translateX, 100)
  expect_equal(result$transform$translateY, 200)
})

test_that("to_list includes full transform", {
  prop <- page_element_property(
    "slide-1",
    scale_x = 1, scale_y = 1,
    shear_x = 0, shear_y = 0,
    translate_x = 50, translate_y = 60,
    transform_unit = "EMU"
  )
  result <- prop$to_list()
  expect_equal(result$transform$unit, "EMU")
  expect_equal(result$transform$scaleX, 1)
  expect_equal(result$transform$scaleY, 1)
  expect_equal(result$transform$shearX, 0)
  expect_equal(result$transform$shearY, 0)
  expect_equal(result$transform$translateX, 50)
  expect_equal(result$transform$translateY, 60)
})

test_that("to_list omits transform when no transform fields set", {
  prop <- page_element_property("slide-1", width_magnitude = 100)
  result <- prop$to_list()
  expect_null(result$transform)
})

test_that("page_element_property rejects non-positive width_magnitude", {
  expect_error(page_element_property("slide-1", width_magnitude = 0), "positive number")
  expect_error(page_element_property("slide-1", width_magnitude = -10), "positive number")
})

test_that("page_element_property rejects non-positive height_magnitude", {
  expect_error(page_element_property("slide-1", height_magnitude = 0), "positive number")
  expect_error(page_element_property("slide-1", height_magnitude = -5), "positive number")
})

test_that("page_element_property rejects NA magnitude", {
  expect_error(page_element_property("slide-1", width_magnitude = NA_real_), "positive number")
})

test_that("page_element_property rejects invalid unit values", {
  expect_error(page_element_property("slide-1", width_unit = "px"), "not recognised")
  expect_error(page_element_property("slide-1", height_unit = "cm"), "not recognised")
  expect_error(page_element_property("slide-1", transform_unit = "in"), "not recognised")
})

test_that("PageElementProperty print method runs without error", {
  prop <- page_element_property("slide-1", width_magnitude = 100, height_magnitude = 50,
                                scale_x = 1, scale_y = 1, translate_x = 0, translate_y = 0)
  expect_no_error(print(prop))
  expect_invisible(prop$print())
})
