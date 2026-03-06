# Add a delete table row request

Add a delete table row request

## Usage

``` r
add_delete_table_row_request(
  google_slides_request = NULL,
  table_object_id,
  row_index,
  column_index
)
```

## Arguments

- google_slides_request:

  A `GoogleSlidesRequest` object, or `NULL`.

- table_object_id:

  The table to delete a row from.

- row_index:

  The 0-based row index.

- column_index:

  The 0-based column index.

## Value

A `GoogleSlidesRequest` object with the request appended.
