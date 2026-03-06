test_that("gs_has_token returns FALSE when no token", {
  expect_false(gs_has_token())
})

test_that("gs_deauth clears auth state", {
  gs_deauth()
  expect_false(gs_has_token())
})

test_that("gs_oauth_client returns NULL when no client configured", {
  skip_if(
    !is.null(gs_oauth_client()),
    "OAuth client is pre-loaded from inst/secret/ via RGOOGLESLIDES_KEY"
  )
  expect_null(gs_oauth_client())
})
