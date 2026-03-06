# Get a single page of a Google Slides presentation

Get a single page of a Google Slides presentation

## Usage

``` r
get_slide_page_properties(id, page_object_id, response = c("simple", "raw"))
```

## Arguments

- id:

  Presentation ID.

- page_object_id:

  The page object ID.

- response:

  Type of response: `"simple"` returns a parsed object with helper
  methods, `"raw"` returns the raw API response list.

## Value

If `response` is `"simple"`, a `SlidePage` R6 object with methods
`get_tables()`, `get_text_boxes()`, and `get_notes()`. If `"raw"`, a
list containing the raw API response.

## Examples

``` r
if (FALSE) { # gs_has_token()
page <- get_slide_page_properties("<presentation-id>", "<page-id>")
}
```
