# Add a create slide request

Add a create slide request

## Usage

``` r
add_create_slide_page_request(
  google_slides_request = NULL,
  insertion_index = NULL,
  layout_id = NULL,
  predefined_layout = NULL,
  object_id = NULL
)
```

## Arguments

- google_slides_request:

  A `GoogleSlidesRequest` object, or `NULL` to create a new one.

- insertion_index:

  Numeric index where the slide should be inserted.

- layout_id:

  Layout ID to use for the new slide.

- predefined_layout:

  Predefined layout name. One of `"BLANK"`, `"CAPTION_ONLY"`, `"TITLE"`,
  `"TITLE_AND_BODY"`, `"TITLE_AND_TWO_COLUMNS"`, `"TITLE_ONLY"`,
  `"SECTION_HEADER"`, `"SECTION_TITLE_AND_DESCRIPTION"`,
  `"ONE_COLUMN_TEXT"`, `"MAIN_POINT"`, `"BIG_NUMBER"`. Defaults to
  `"BLANK"`.

- object_id:

  Optional ID for the new slide.

## Value

A `GoogleSlidesRequest` object with the request appended.

## Examples

``` r
if (FALSE) { # gs_has_token()
requests <- add_create_slide_page_request()
commit_to_slides("<slide-id>", requests)
}
```
