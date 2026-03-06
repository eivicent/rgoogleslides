# Inserting images into slides

``` r
library(rgoogleslides)
```

## Overview

The Google Slides API can only embed images that are reachable via an
`https://` URL — there is no way to upload raw binary data directly to a
slide. This means local files need a two-step detour:

1.  Upload the file somewhere Google’s servers can fetch it.
2.  Pass that URL (or Google Drive file ID) to
    [`add_create_image_request()`](https://eivicent.github.io/rgoogleslides/reference/add_create_image_request.md).

The sections below cover each source in order of complexity.

## From a public URL

If the image is already hosted on a publicly accessible web server, pass
the URL directly:

``` r
props  <- get_slides_properties("<presentation-id>")
page_id <- props$slides[[1]]$objectId

prop <- page_element_property(
  page_id,
  height_magnitude = 200,
  width_magnitude  = 300,
  scale_x = 1, scale_y = 1,
  translate_x = 100, translate_y = 100,
  transform_unit = "PT"
)

req <- add_create_image_request(
  page_element_property = prop,
  url = "https://example.com/logo.png"
)
commit_to_slides("<presentation-id>", req)
```

## From Google Drive

If the image is already in your Google Drive, pass its file ID (the long
alphanumeric string in the Drive URL) instead of an `https://` URL.
rgoogleslides detects that the value is not a URL and constructs an
authenticated download link automatically:

``` r
req <- add_create_image_request(
  page_element_property = prop,
  url = "1BxiMVs0XRA5nFMdKvBdBZjgmUUqptlbs74OgVE2upms"  # Drive file ID
)
commit_to_slides("<presentation-id>", req)
```

> **Note:** The access token is embedded as a query parameter in the URL
> sent to the Slides API. It will appear in API request bodies and
> network logs. For sensitive environments prefer a publicly accessible
> `https://` URL.

## From a local file

Local files must be uploaded to Google Drive first. The
[googledrive](https://googledrive.tidyverse.org/) package handles this
and shares credentials with rgoogleslides via gargle, so no extra
sign-in is required.

``` r
# install.packages("googledrive")
library(googledrive)

# 1. Upload to Drive
tmp <- drive_upload("path/to/my-plot.png", type = "image/png")
file_id <- as.character(as_id(tmp))

# 2. Add to the slide and commit
req <- add_create_image_request(
  page_element_property = prop,
  url = file_id
)
commit_to_slides("<presentation-id>", req)

# 3. Remove from Drive
drive_rm(tmp)
```

The three steps must be kept in this order: Drive cleanup should happen
**after**
[`commit_to_slides()`](https://eivicent.github.io/rgoogleslides/reference/commit_to_slides.md),
because the Slides API fetches the image server-side at commit time.

## Positioning images

[`page_element_property()`](https://eivicent.github.io/rgoogleslides/reference/page_element_property.md)
gives you full control over position and size using translate (top-left
corner) and scale values. The unit can be `"PT"` (points) or `"EMU"`
(English Metric Units, used internally by the API).

For the two most common cases — centred or full-page — use the
convenience wrapper
[`aligned_page_element_property()`](https://eivicent.github.io/rgoogleslides/reference/aligned_page_element_property.md):

``` r
page_id <- props$slides[[2]]$objectId

# Centre a 300 × 200 pt image on the slide
prop_centre <- aligned_page_element_property(
  page_id,
  image_width  = 300,
  image_height = 200,
  align = "center"
)

# Stretch to fill the entire slide
prop_full <- aligned_page_element_property(
  page_id,
  align = "full"
)
```

The default slide dimensions assumed by
[`aligned_page_element_property()`](https://eivicent.github.io/rgoogleslides/reference/aligned_page_element_property.md)
are 9 144 000 × 5 143 500 EMU (standard 16:9 widescreen). If your
presentation uses a different size, pass `slide_page_width` and
`slide_page_height` explicitly.

## Replacing placeholder shapes with an image

A common template workflow is to insert a named shape as a placeholder
in your slide design, then swap it out with an image at render time.
[`add_replace_all_shapes_with_image_request()`](https://eivicent.github.io/rgoogleslides/reference/add_replace_all_shapes_with_image_request.md)
finds every shape whose text matches a given string and replaces it:

``` r
req <- add_replace_all_shapes_with_image_request(
  image_url      = "https://example.com/chart.png",
  text           = "{{CHART}}",
  match_case     = TRUE,
  replace_method = "CENTER_INSIDE"  # or "CENTER_CROP"
)
commit_to_slides("<presentation-id>", req)
```

`replace_method` controls how the image is fitted into the shape’s
bounding box:

| Value             | Behaviour                                                     |
|-------------------|---------------------------------------------------------------|
| `"CENTER_INSIDE"` | Scale down until the whole image fits; may leave empty space. |
| `"CENTER_CROP"`   | Scale up until the box is filled; may crop edges.             |

You can restrict the replacement to specific pages by passing a
character vector of page IDs to `page_object_ids`.

## Batching image requests

Like all `add_*_request()` functions, image requests can be chained and
committed in a single API call:

``` r
req <- add_create_slide_page_request(predefined_layout = "BLANK")
req <- add_create_image_request(
  req,
  page_element_property = prop_full,
  url = "https://example.com/background.png"
)
req <- add_create_image_request(
  req,
  page_element_property = prop_centre,
  url = "https://example.com/logo.png"
)
commit_to_slides("<presentation-id>", req)
```

## Further reading

- [`add_create_image_request()`](https://eivicent.github.io/rgoogleslides/reference/add_create_image_request.md)
- [`add_replace_all_shapes_with_image_request()`](https://eivicent.github.io/rgoogleslides/reference/add_replace_all_shapes_with_image_request.md)
- [`aligned_page_element_property()`](https://eivicent.github.io/rgoogleslides/reference/aligned_page_element_property.md)
- [Google Slides API —
  CreateImageRequest](https://developers.google.com/slides/api/reference/rest/v1/presentations/request#CreateImageRequest)
- [googledrive package](https://googledrive.tidyverse.org/)
