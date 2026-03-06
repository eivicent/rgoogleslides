# Add a delete text request

Add a delete text request

## Usage

``` r
add_delete_text_request(
  google_slides_request = NULL,
  object_id,
  row_index = NULL,
  column_index = NULL,
  start_index = NULL,
  end_index = NULL,
  type = "ALL"
)
```

## Arguments

- google_slides_request:

  A `GoogleSlidesRequest` object, or `NULL`.

- object_id:

  ID of the shape or table containing the text.

- row_index:

  Row index (for tables only). Must be provided together with
  `column_index`.

- column_index:

  Column index (for tables only). Must be provided together with
  `row_index`.

- start_index:

  Start index (required for `"FIXED_RANGE"` and `"FROM_START_INDEX"`).

- end_index:

  End index (required for `"FIXED_RANGE"`).

- type:

  Range type: `"ALL"`, `"FIXED_RANGE"`, or `"FROM_START_INDEX"`.

## Value

A `GoogleSlidesRequest` object with the request appended.
