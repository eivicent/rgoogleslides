# Package index

## Authentication

Manage Google Slides API credentials.

- [`gs_auth()`](https://eivicent.github.io/rgoogleslides/reference/gs_auth.md)
  : Authorize rgoogleslides
- [`gs_deauth()`](https://eivicent.github.io/rgoogleslides/reference/gs_deauth.md)
  : Clear Google Slides credentials
- [`gs_token()`](https://eivicent.github.io/rgoogleslides/reference/gs_token.md)
  : Produce a configured token
- [`gs_has_token()`](https://eivicent.github.io/rgoogleslides/reference/gs_has_token.md)
  : Is there a token on hand?
- [`gs_auth_configure()`](https://eivicent.github.io/rgoogleslides/reference/gs_auth_configure.md)
  : Edit auth configuration
- [`gs_oauth_client()`](https://eivicent.github.io/rgoogleslides/reference/gs_oauth_client.md)
  : Retrieve the configured OAuth client
- [`authorize()`](https://eivicent.github.io/rgoogleslides/reference/authorize.md)
  **\[deprecated\]** : Authorize R package to access Google Slides API

## Presentations

Create and query presentations.

- [`create_slides()`](https://eivicent.github.io/rgoogleslides/reference/create_slides.md)
  : Create a new Google Slides presentation
- [`get_slides_properties()`](https://eivicent.github.io/rgoogleslides/reference/get_slides_properties.md)
  : Get Google Slides properties
- [`get_slide_page_properties()`](https://eivicent.github.io/rgoogleslides/reference/get_slide_page_properties.md)
  : Get a single page of a Google Slides presentation
- [`commit_to_slides()`](https://eivicent.github.io/rgoogleslides/reference/commit_to_slides.md)
  : Commit changes to slides

## Request builders

Build individual API requests to commit as a batch.

- [`add_create_image_request()`](https://eivicent.github.io/rgoogleslides/reference/add_create_image_request.md)
  : Add a create image request
- [`add_create_shape_request()`](https://eivicent.github.io/rgoogleslides/reference/add_create_shape_request.md)
  : Add a create shape request
- [`add_create_slide_page_request()`](https://eivicent.github.io/rgoogleslides/reference/add_create_slide_page_request.md)
  : Add a create slide request
- [`add_create_table_request()`](https://eivicent.github.io/rgoogleslides/reference/add_create_table_request.md)
  : Add a create table request
- [`add_create_video_request()`](https://eivicent.github.io/rgoogleslides/reference/add_create_video_request.md)
  : Add a create video request
- [`add_delete_object_request()`](https://eivicent.github.io/rgoogleslides/reference/add_delete_object_request.md)
  : Add a delete object request
- [`add_delete_table_column_request()`](https://eivicent.github.io/rgoogleslides/reference/add_delete_table_column_request.md)
  : Add a delete table column request
- [`add_delete_table_row_request()`](https://eivicent.github.io/rgoogleslides/reference/add_delete_table_row_request.md)
  : Add a delete table row request
- [`add_delete_text_request()`](https://eivicent.github.io/rgoogleslides/reference/add_delete_text_request.md)
  : Add a delete text request
- [`add_insert_table_columns_request()`](https://eivicent.github.io/rgoogleslides/reference/add_insert_table_columns_request.md)
  : Add an insert table columns request
- [`add_insert_table_rows_request()`](https://eivicent.github.io/rgoogleslides/reference/add_insert_table_rows_request.md)
  : Add an insert table rows request
- [`add_insert_text_request()`](https://eivicent.github.io/rgoogleslides/reference/add_insert_text_request.md)
  : Add an insert text request
- [`add_replace_all_shapes_with_image_request()`](https://eivicent.github.io/rgoogleslides/reference/add_replace_all_shapes_with_image_request.md)
  : Add a replace all shapes with image request
- [`add_replace_all_text_request()`](https://eivicent.github.io/rgoogleslides/reference/add_replace_all_text_request.md)
  : Add a replace all text request
- [`add_update_slides_position_request()`](https://eivicent.github.io/rgoogleslides/reference/add_update_slides_position_request.md)
  : Add an update slides position request

## Page element properties

Position and size elements on slides.

- [`page_element_property()`](https://eivicent.github.io/rgoogleslides/reference/page_element_property.md)
  : Common Property: Page Element Property
- [`aligned_page_element_property()`](https://eivicent.github.io/rgoogleslides/reference/aligned_page_element_property.md)
  : Convenience function to build a centred or full-page element
  property

## Helpers

Discover valid API values and inspect objects.

- [`gs_shape_types()`](https://eivicent.github.io/rgoogleslides/reference/gs_shape_types.md)
  : List valid Google Slides shape types
- [`is.google_slide_request()`](https://eivicent.github.io/rgoogleslides/reference/is.google_slide_request.md)
  : Check if the object is a GoogleSlidesRequest
- [`is.page_element_property()`](https://eivicent.github.io/rgoogleslides/reference/is.page_element_property.md)
  : Check if the object is a PageElementProperty

## Convenience

Higher-level helpers.

- [`create_data_table()`](https://eivicent.github.io/rgoogleslides/reference/create_data_table.md)
  : Create and upload data into a table in slides
