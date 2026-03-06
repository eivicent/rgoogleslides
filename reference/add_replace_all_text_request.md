# Add a replace all text request

Add a replace all text request

## Usage

``` r
add_replace_all_text_request(
  google_slides_request = NULL,
  replace_text,
  text,
  match_case = TRUE
)
```

## Arguments

- google_slides_request:

  A `GoogleSlidesRequest` object, or `NULL`.

- replace_text:

  Replacement text.

- text:

  Text to search for.

- match_case:

  Whether to match case.

## Value

A `GoogleSlidesRequest` object with the request appended.
