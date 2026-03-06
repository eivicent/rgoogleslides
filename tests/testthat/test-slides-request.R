test_that("GoogleSlidesRequest starts empty", {
  req <- google_slide_request_container$new()
  expect_length(req$to_list(), 0)
})

test_that("add_request appends to list", {
  req <- google_slide_request_container$new()
  req$add_request(list(createSlide = list()))
  req$add_request(list(deleteObject = list(objectId = "x")))
  result <- req$to_list()
  expect_length(result, 2)
  expect_false(is.null(result[[1]]$createSlide))
  expect_false(is.null(result[[2]]$deleteObject))
})

test_that("is.google_slide_request works", {
  req <- google_slide_request_container$new()
  expect_true(is.google_slide_request(req))
  expect_false(is.google_slide_request(list()))
  expect_false(is.google_slide_request(NULL))
})

test_that("GoogleSlidesRequest print method runs without error", {
  req <- google_slide_request_container$new()
  req$add_request(list(createSlide = list()))
  req$add_request(list(deleteObject = list(objectId = "x")))
  expect_no_error(print(req))
  expect_invisible(req$print())
})

test_that("GoogleSlidesRequest print works for empty request", {
  req <- google_slide_request_container$new()
  expect_no_error(print(req))
})
