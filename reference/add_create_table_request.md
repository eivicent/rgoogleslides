# Add a create table request

Add a create table request

## Usage

``` r
add_create_table_request(
  google_slides_request = NULL,
  page_element_property,
  rows,
  columns,
  object_id = NULL
)
```

## Arguments

- google_slides_request:

  A `GoogleSlidesRequest` object, or `NULL`.

- page_element_property:

  A `PageElementProperty` object.

- rows:

  Number of rows.

- columns:

  Number of columns.

- object_id:

  Optional ID for the new table.

## Value

A `GoogleSlidesRequest` object with the request appended.
