# Add an insert table columns request

Add an insert table columns request

## Usage

``` r
add_insert_table_columns_request(
  google_slides_request = NULL,
  table_object_id,
  row_index,
  column_index,
  insert_right = TRUE,
  number
)
```

## Arguments

- google_slides_request:

  A `GoogleSlidesRequest` object, or `NULL`.

- table_object_id:

  The table to insert columns into.

- row_index:

  The 0-based row index.

- column_index:

  The 0-based column index.

- insert_right:

  If `TRUE`, insert to the right of the reference cell.

- number:

  Number of columns to insert (max 20).

## Value

A `GoogleSlidesRequest` object with the request appended.
