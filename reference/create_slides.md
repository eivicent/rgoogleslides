# Create a new Google Slides presentation

Create a new Google Slides presentation

## Usage

``` r
create_slides(title = NULL, full_response = FALSE)
```

## Arguments

- title:

  Title of the presentation.

- full_response:

  If `TRUE`, return the full API response. If `FALSE` (default), return
  just the presentation ID.

## Value

If `full_response` is `FALSE`, a string with the presentation ID. If
`TRUE`, a list containing the full API response.

## Examples

``` r
if (FALSE) { # gs_has_token()
id <- create_slides("My Presentation")
}
```
