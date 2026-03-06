# Add an insert table rows request

Add an insert table rows request

## Usage

``` r
add_insert_table_rows_request(
  google_slides_request = NULL,
  table_object_id,
  row_index,
  column_index,
  insert_below = TRUE,
  number
)
```

## Arguments

- google_slides_request:

  A `GoogleSlidesRequest` object, or `NULL`.

- table_object_id:

  The table to insert rows into.

- row_index:

  The 0-based row index.

- column_index:

  The 0-based column index.

- insert_below:

  If `TRUE`, insert below the reference cell.

- number:

  Number of rows to insert (max 20).

## Value

A `GoogleSlidesRequest` object with the request appended.
