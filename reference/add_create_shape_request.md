# Add a create shape request

Add a create shape request

## Usage

``` r
add_create_shape_request(
  google_slides_request = NULL,
  shape_type,
  page_element_property,
  object_id = NULL
)
```

## Arguments

- google_slides_request:

  A `GoogleSlidesRequest` object, or `NULL`.

- shape_type:

  Shape type (e.g. `"RECTANGLE"`, `"STAR_5"`).

- page_element_property:

  A `PageElementProperty` object with width and height.

- object_id:

  Optional ID for the new shape.

## Value

A `GoogleSlidesRequest` object with the request appended.

## Examples

``` r
if (FALSE) { # gs_has_token()
prop <- page_element_property("p", 200, 300)
request <- add_create_shape_request(shape_type = "RECTANGLE",
                                    page_element_property = prop)
}
```
