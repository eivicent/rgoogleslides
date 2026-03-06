# Commit changes to slides

Send a batch of accumulated requests to the Google Slides API.

## Usage

``` r
commit_to_slides(id, google_slide_request)
```

## Arguments

- id:

  The presentation ID.

- google_slide_request:

  A `GoogleSlidesRequest` object created by the `add_*_request()`
  functions.

## Value

A list containing the API response with any reply data.

## Examples

``` r
if (FALSE) { # gs_has_token()
request <- add_create_slide_page_request()
commit_to_slides("<presentation-id>", request)
}
```
