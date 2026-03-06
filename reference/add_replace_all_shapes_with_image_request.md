# Add a replace all shapes with image request

Add a replace all shapes with image request

## Usage

``` r
add_replace_all_shapes_with_image_request(
  google_slides_request = NULL,
  image_url,
  replace_method = "CENTER_INSIDE",
  page_object_ids = NULL,
  text,
  match_case = TRUE
)
```

## Arguments

- google_slides_request:

  A `GoogleSlidesRequest` object, or `NULL`.

- image_url:

  Image URL or Google Drive file ID.

- replace_method:

  `"CENTER_INSIDE"` or `"CENTER_CROP"`.

- page_object_ids:

  Character vector of page IDs to restrict to. If `NULL`, the
  replacement applies to all pages.

- text:

  Text to match in the shapes to replace.

- match_case:

  Whether to match case.

## Value

A `GoogleSlidesRequest` object with the request appended.

## Details

When `image_url` is a Google Drive file ID (not an `http://` or
`https://` URL), the function constructs a Drive download URL that
embeds a short-lived OAuth access token as a query parameter. See
[`add_create_image_request()`](https://eivicent.github.io/rgoogleslides/reference/add_create_image_request.md)
for the full security note.

## Examples

``` r
if (FALSE) { # gs_has_token()
request <- add_replace_all_shapes_with_image_request(
  image_url = "https://example.com/image.png",
  text = "placeholder"
)
}
```
