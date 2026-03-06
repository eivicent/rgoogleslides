# Add a delete table column request

Add a delete table column request

## Usage

``` r
add_delete_table_column_request(
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

  The table to delete a column from.

- row_index:

  The 0-based row index.

- column_index:

  The 0-based column index.

## Value

A `GoogleSlidesRequest` object with the request appended.
