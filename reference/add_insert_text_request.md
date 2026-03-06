# Add an insert text request

Add an insert text request

## Usage

``` r
add_insert_text_request(
  google_slides_request = NULL,
  object_id,
  row_index = NULL,
  column_index = NULL,
  text,
  insertion_index = NULL
)
```

## Arguments

- google_slides_request:

  A `GoogleSlidesRequest` object, or `NULL`.

- object_id:

  ID of the shape or table to insert text into.

- row_index:

  Row index (for tables only). Must be provided together with
  `column_index`.

- column_index:

  Column index (for tables only). Must be provided together with
  `row_index`.

- text:

  Text to insert.

- insertion_index:

  Starting position for the text.

## Value

A `GoogleSlidesRequest` object with the request appended.
