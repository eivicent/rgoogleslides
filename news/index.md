# Changelog

## rgoogleslides 1.0.1

### Bug fixes

- Fixed
  [`add_delete_text_request()`](https://eivicent.github.io/rgoogleslides/reference/add_delete_text_request.md)
  cross-argument logic: `"FIXED_RANGE"` now requires both `start_index`
  and `end_index`; `"FROM_START_INDEX"` requires `start_index`; passing
  `end_index` with `"ALL"` now warns instead of silently sending a
  malformed request.

- Fixed
  [`add_insert_text_request()`](https://eivicent.github.io/rgoogleslides/reference/add_insert_text_request.md)
  and
  [`add_delete_text_request()`](https://eivicent.github.io/rgoogleslides/reference/add_delete_text_request.md):
  supplying only one of `row_index` / `column_index` now errors
  immediately instead of silently ignoring both and inserting text in
  the wrong element.

- Fixed
  [`gs_auth_configure()`](https://eivicent.github.io/rgoogleslides/reference/gs_auth_configure.md)
  to error when called with no arguments, and to validate that a
  directly supplied `client` is a `gargle_oauth_client` object.

- [`page_element_property()`](https://eivicent.github.io/rgoogleslides/reference/page_element_property.md)
  now validates `page_object_id` as a non-empty, non-`NA` string instead
  of only checking for `NULL`.

- [`create_data_table()`](https://eivicent.github.io/rgoogleslides/reference/create_data_table.md)
  now errors with a clear message when the table-creation API call does
  not return an object ID, rather than propagating a confusing
  downstream error.

- `get_notes()` now returns an empty data frame when the API response
  does not include a `notesPage` (e.g., slides retrieved without the
  `slideProperties` field), instead of iterating over `NULL` silently.

- `gs_build_url()` now validates that all required URL placeholders
  (`presentationId`, `pageObjectId`) are supplied before constructing
  the URL, producing a clear error instead of sending a literal
  `{presentationId}` to the API.

- Package startup no longer silently swallows errors when loading the
  built-in OAuth client; a
  [`rlang::warn()`](https://rlang.r-lib.org/reference/abort.html) is now
  emitted so misconfigured environments surface the problem early.

### New features

- Added
  [`gs_shape_types()`](https://eivicent.github.io/rgoogleslides/reference/gs_shape_types.md)
  to list all valid shape type strings accepted by the Google Slides
  API, making it easy to discover available options for
  [`add_create_shape_request()`](https://eivicent.github.io/rgoogleslides/reference/add_create_shape_request.md).

- [`add_create_video_request()`](https://eivicent.github.io/rgoogleslides/reference/add_create_video_request.md)
  gains a `source` argument (`"YOUTUBE"` or `"DRIVE"`). The default
  remains `"YOUTUBE"` for backward compatibility.

- `GoogleSlidesRequest` and `PageElementProperty` R6 objects now have
  [`print()`](https://rdrr.io/r/base/print.html) methods that show a
  readable summary in the console.

### Improvements

- [`add_create_shape_request()`](https://eivicent.github.io/rgoogleslides/reference/add_create_shape_request.md)
  now validates `shape_type` against the full Google Slides API
  `ShapeType` enum, giving an informative error pointing to
  [`gs_shape_types()`](https://eivicent.github.io/rgoogleslides/reference/gs_shape_types.md)
  on invalid input.

- [`add_create_slide_page_request()`](https://eivicent.github.io/rgoogleslides/reference/add_create_slide_page_request.md)
  now validates `predefined_layout` against the API’s `PredefinedLayout`
  enum.

- [`add_delete_text_request()`](https://eivicent.github.io/rgoogleslides/reference/add_delete_text_request.md)
  now validates `type` against `"ALL"`, `"FIXED_RANGE"`, and
  `"FROM_START_INDEX"`.

- [`add_replace_all_shapes_with_image_request()`](https://eivicent.github.io/rgoogleslides/reference/add_replace_all_shapes_with_image_request.md)
  now validates `replace_method` against `"CENTER_INSIDE"` and
  `"CENTER_CROP"`, and validates `page_object_ids` as a non-empty
  character vector with no `NA` values.

- [`add_update_slides_position_request()`](https://eivicent.github.io/rgoogleslides/reference/add_update_slides_position_request.md)
  now uses the same `check_character_vector()` validation as
  [`add_replace_all_shapes_with_image_request()`](https://eivicent.github.io/rgoogleslides/reference/add_replace_all_shapes_with_image_request.md),
  which also catches `NA` elements in the vector (previously only
  checked type and length).

- [`page_element_property()`](https://eivicent.github.io/rgoogleslides/reference/page_element_property.md)
  now validates `width_unit`, `height_unit`, and `transform_unit`
  against `"PT"` and `"EMU"`, and validates `width_magnitude` and
  `height_magnitude` as positive numbers.

- Index arguments (`row_index`, `column_index`, `insertion_index`,
  `start_index`, `end_index`) across all request builders are now
  validated as non-negative whole numbers. Count arguments (`rows`,
  `columns`, `number`) are validated as positive whole numbers.

- [`create_slides()`](https://eivicent.github.io/rgoogleslides/reference/create_slides.md)
  now validates the `title` argument as a string (or `NULL`).

- Failed API requests now include the HTTP method and URL in the error
  message, making it easier to identify which call failed in complex
  workflows.

- Internal `dataframe_convert()` rewritten with vectorised operations,
  avoiding the previous per-cell data frame allocation loop.

- Internal Drive URL construction extracted to a shared
  `.resolve_image_url()` helper used by both
  [`add_create_image_request()`](https://eivicent.github.io/rgoogleslides/reference/add_create_image_request.md)
  and
  [`add_replace_all_shapes_with_image_request()`](https://eivicent.github.io/rgoogleslides/reference/add_replace_all_shapes_with_image_request.md).

- [`is.google_slide_request()`](https://eivicent.github.io/rgoogleslides/reference/is.google_slide_request.md)
  and
  [`is.page_element_property()`](https://eivicent.github.io/rgoogleslides/reference/is.page_element_property.md)
  now use [`inherits()`](https://rdrr.io/r/base/class.html) for class
  checking.

- [`gs_deauth()`](https://eivicent.github.io/rgoogleslides/reference/gs_deauth.md)
  now consistently returns `invisible(NULL)`.

- Removed internal dead-code function `check_validity()` and unused
  `check_number()` validator.

- Fixed GitHub repository URL throughout package metadata (`eivicent`).

## rgoogleslides 1.0.0

### Breaking changes

- Authentication has been completely rewritten to use the gargle
  package, aligning with the tidyverse Google ecosystem (googledrive,
  googlesheets4). `authorize()` is deprecated in favour of
  [`gs_auth()`](https://eivicent.github.io/rgoogleslides/reference/gs_auth.md)
  (#new).

- The assertthat dependency has been replaced with cli for user-facing
  error messages with richer formatting and context.

### Bug fixes

- Fixed `translate_X` typo in `page_element_property` that silently
  broke element positioning when only translate coordinates were set.

- Fixed `cellLocation` placement in
  [`add_insert_table_rows_request()`](https://eivicent.github.io/rgoogleslides/reference/add_insert_table_rows_request.md),
  [`add_insert_table_columns_request()`](https://eivicent.github.io/rgoogleslides/reference/add_insert_table_columns_request.md),
  [`add_delete_table_row_request()`](https://eivicent.github.io/rgoogleslides/reference/add_delete_table_row_request.md),
  and
  [`add_delete_table_column_request()`](https://eivicent.github.io/rgoogleslides/reference/add_delete_table_column_request.md)
  – the cell location was incorrectly placed at the top level instead of
  inside the operation object.

- Fixed duplicate `objectId` in
  [`add_create_slide_page_request()`](https://eivicent.github.io/rgoogleslides/reference/add_create_slide_page_request.md)
  that placed the ID both inside `createSlide` and at the top level.

- Fixed `slideObjectIds` wrapping in
  [`add_update_slides_position_request()`](https://eivicent.github.io/rgoogleslides/reference/add_update_slides_position_request.md)
  that wrapped the vector in an extra list layer.

- Fixed wrong package name in examples
  ([`library(googleslides)`](https://rdrr.io/r/base/library.html) -\>
  [`library(rgoogleslides)`](https://github.com/eivicent/rgoogleslides)).

### Improvements

- HTTP requests now use gargle’s `request_retry()` for automatic rate
  limiting and retry logic.

- Improved performance of `get_tables()`, `get_text_boxes()`, and
  `get_notes()` by replacing grow-by-rbind pattern with list
  accumulation.

- All exported functions now have `@return` documentation and guarded
  examples per current CRAN requirements.

- Added testthat 3 test suite with unit tests for request builders, page
  element properties, and utility functions.

- Added GitHub Actions CI for R CMD check across platforms.

## rgoogleslides 0.3.2

CRAN release: 2020-03-10

- Get Slide Notes request functionality added
- Allow passing for additional scopes to token

## rgoogleslides 0.3.1

CRAN release: 2018-09-03

- Addition of a token parameter to the Authorize method
- Added a `NEWS.md` file to track changes to the package.

## rgoogleslides 0.3.0

- Simplifying response when trying to retrieve information regarding a
  slide via its slide page properties
- Insert table row request function
- Insert table column request function
- Delete table row request function
- Delete table column request function
- Add video request function
- Update documentation for the all the functions accordingly
- Update documentation for all functions by adding examples
