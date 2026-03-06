# Common Property: Page Element Property

Build a page element property for positioning and sizing elements on a
slide.

## Usage

``` r
page_element_property(
  page_object_id = NULL,
  width_magnitude = NULL,
  height_magnitude = NULL,
  scale_x = NULL,
  scale_y = NULL,
  shear_x = NULL,
  shear_y = NULL,
  translate_x = NULL,
  translate_y = NULL,
  width_unit = "PT",
  height_unit = "PT",
  transform_unit = "PT"
)
```

## Arguments

- page_object_id:

  The slide page ID.

- width_magnitude:

  Width of the element.

- height_magnitude:

  Height of the element.

- scale_x:

  Horizontal scale factor.

- scale_y:

  Vertical scale factor.

- shear_x:

  Horizontal shear factor.

- shear_y:

  Vertical shear factor.

- translate_x:

  Horizontal translation.

- translate_y:

  Vertical translation.

- width_unit:

  Unit for width. Default `"PT"`.

- height_unit:

  Unit for height. Default `"PT"`.

- transform_unit:

  Unit for transforms. Default `"PT"`.

## Value

A `PageElementProperty` R6 object.

## Examples

``` r
prop <- page_element_property("slide-id-1", 200, 300)
```
