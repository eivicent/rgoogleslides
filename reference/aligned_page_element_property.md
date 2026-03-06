# Convenience function to build a centred or full-page element property

The Google Slides API does not provide convenient ways to align
elements. This function calculates the necessary transforms for centring
or full-page placement.

## Usage

``` r
aligned_page_element_property(
  slide_page_id,
  slide_page_height = 5143500,
  slide_page_width = 9144000,
  image_height = NULL,
  image_width = NULL,
  align = "center"
)
```

## Arguments

- slide_page_id:

  The slide page ID.

- slide_page_height:

  Slide height in EMU. Default `5143500`.

- slide_page_width:

  Slide width in EMU. Default `9144000`.

- image_height:

  Image height in pt. Required for `align = "center"`.

- image_width:

  Image width in pt. Required for `align = "center"`.

- align:

  Alignment mode: `"center"` or `"full"`.

## Value

A `PageElementProperty` object.

## Details

- The image is scaled without distortion.

- Translation coordinates are defined by the top-left corner of the
  image.

- This function does not query the API for page size; the user must
  supply it.

## Examples

``` r
# Centre an image
prop <- aligned_page_element_property("p", image_height = 200, image_width = 300)

# Full-page placement
prop <- aligned_page_element_property("p", align = "full")
```
