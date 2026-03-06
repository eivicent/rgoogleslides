# Add an update slides position request

Add an update slides position request

## Usage

``` r
add_update_slides_position_request(
  google_slides_request = NULL,
  slide_object_ids,
  insertion_index
)
```

## Arguments

- google_slides_request:

  A `GoogleSlidesRequest` object, or `NULL`.

- slide_object_ids:

  Character vector of slide IDs to move.

- insertion_index:

  Position to move the slides to.

## Value

A `GoogleSlidesRequest` object with the request appended.
