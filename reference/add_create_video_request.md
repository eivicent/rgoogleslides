# Add a create video request

Add a create video request

## Usage

``` r
add_create_video_request(
  google_slides_request = NULL,
  id,
  page_element_property,
  source = "YOUTUBE",
  object_id = NULL
)
```

## Arguments

- google_slides_request:

  A `GoogleSlidesRequest` object, or `NULL`.

- id:

  Video ID. For `source = "YOUTUBE"` this is the YouTube video ID (e.g.
  `"7U3axjORYZ0"`). For `source = "DRIVE"` this is the Google Drive file
  ID.

- page_element_property:

  A `PageElementProperty` object.

- source:

  Video source: `"YOUTUBE"` (default) or `"DRIVE"`.

- object_id:

  Optional ID for the new video.

## Value

A `GoogleSlidesRequest` object with the request appended.

## Examples

``` r
if (FALSE) { # gs_has_token()
prop <- aligned_page_element_property("p", align = "full")
request <- add_create_video_request(id = "<youtube-id>",
                                    page_element_property = prop)
}
```
