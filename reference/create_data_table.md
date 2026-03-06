# Create and upload data into a table in slides

Creates a table on a slide and fills it with data from a data frame.
This makes two API calls: one to create the table and one to fill it.

## Usage

``` r
create_data_table(
  id = NULL,
  page_element_property = NULL,
  data = NULL,
  headers = TRUE
)
```

## Arguments

- id:

  Presentation ID.

- page_element_property:

  A `PageElementProperty` object.

- data:

  A data frame to insert into the table.

- headers:

  If `TRUE`, include column names as the first row.

## Value

A list containing the API response from the text insertion.

## Examples

``` r
if (FALSE) { # gs_has_token()
prop <- page_element_property("<slide-page-id>")
create_data_table("<presentation-id>", prop, iris[1:5, ])
}
```
