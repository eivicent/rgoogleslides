# Add a create image request

Add a create image request

## Usage

``` r
add_create_image_request(
  google_slides_request = NULL,
  page_element_property,
  url,
  object_id = NULL
)
```

## Arguments

- google_slides_request:

  A `GoogleSlidesRequest` object, or `NULL`.

- page_element_property:

  A `PageElementProperty` object.

- url:

  An image URL, or a Google Drive file ID.

- object_id:

  Optional ID for the new image.

## Value

A `GoogleSlidesRequest` object with the request appended.

## Details

When `url` is a Google Drive file ID (not an `http://` or `https://`
URL), the function constructs a Drive download URL that embeds a
short-lived OAuth access token as a query parameter. This URL is sent to
the Slides API, which fetches the image server-side. The token is not
stored or cached by this package, but it will appear in network logs and
the Slides API request body. For sensitive environments prefer passing a
publicly accessible HTTPS URL.
