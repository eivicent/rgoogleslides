#' Common Property: Page Element Property
#'
#' Build a page element property for positioning and sizing elements on a
#' slide.
#'
#' @param page_object_id The slide page ID.
#' @param width_magnitude Width of the element.
#' @param height_magnitude Height of the element.
#' @param scale_x Horizontal scale factor.
#' @param scale_y Vertical scale factor.
#' @param shear_x Horizontal shear factor.
#' @param shear_y Vertical shear factor.
#' @param translate_x Horizontal translation.
#' @param translate_y Vertical translation.
#' @param width_unit Unit for width. Default `"PT"`.
#' @param height_unit Unit for height. Default `"PT"`.
#' @param transform_unit Unit for transforms. Default `"PT"`.
#'
#' @return A `PageElementProperty` R6 object.
#' @export
#'
#' @examples
#' prop <- page_element_property("slide-id-1", 200, 300)
page_element_property <- function(page_object_id = NULL,
                                  width_magnitude = NULL,
                                  height_magnitude = NULL,
                                  scale_x = NULL, scale_y = NULL,
                                  shear_x = NULL, shear_y = NULL,
                                  translate_x = NULL, translate_y = NULL,
                                  width_unit = "PT", height_unit = "PT",
                                  transform_unit = "PT") {
  check_string(page_object_id)
  check_positive_number(width_magnitude, allow_null = TRUE)
  check_positive_number(height_magnitude, allow_null = TRUE)
  check_unit(width_unit)
  check_unit(height_unit)
  check_unit(transform_unit)

  pep <- page_element_property_container$new(page_object_id)
  pep$width_magnitude  <- width_magnitude
  pep$height_magnitude <- height_magnitude
  pep$scale_x     <- scale_x
  pep$scale_y     <- scale_y
  pep$shear_x     <- shear_x
  pep$shear_y     <- shear_y
  pep$translate_x <- translate_x
  pep$translate_y <- translate_y
  pep$width_unit     <- width_unit
  pep$height_unit    <- height_unit
  pep$transform_unit <- transform_unit

  pep
}

#' @noRd
#' @importFrom R6 R6Class
page_element_property_container <- R6Class("PageElementProperty",
  public = list(
    #' @field page_object_id Page object ID.
    page_object_id = NULL,
    #' @field width_magnitude Width magnitude.
    width_magnitude = NULL,
    #' @field height_magnitude Height magnitude.
    height_magnitude = NULL,
    #' @field scale_x Horizontal scale.
    scale_x = NULL,
    #' @field scale_y Vertical scale.
    scale_y = NULL,
    #' @field shear_x Horizontal shear.
    shear_x = NULL,
    #' @field shear_y Vertical shear.
    shear_y = NULL,
    #' @field translate_x Horizontal translation.
    translate_x = NULL,
    #' @field translate_y Vertical translation.
    translate_y = NULL,
    #' @field width_unit Width unit.
    width_unit = "PT",
    #' @field height_unit Height unit.
    height_unit = "PT",
    #' @field transform_unit Transform unit.
    transform_unit = "PT",

    #' @description Create a new PageElementProperty.
    #' @param page_object_id The page object ID.
    initialize = function(page_object_id) {
      self$page_object_id <- page_object_id
    },

    #' @description Convert to a list for the API.
    #' @return A named list suitable for JSON serialization.
    to_list = function() {
      page_element_list <- list(pageObjectId = self$page_object_id)

      if (is.numeric(self$width_magnitude) || is.numeric(self$height_magnitude)) {
        page_element_list[["size"]] <- list()
      }

      if (is.numeric(self$width_magnitude)) {
        page_element_list[["size"]][["width"]] <- list(
          magnitude = self$width_magnitude,
          unit = self$width_unit
        )
      }

      if (is.numeric(self$height_magnitude)) {
        page_element_list[["size"]][["height"]] <- list(
          magnitude = self$height_magnitude,
          unit = self$height_unit
        )
      }

      has_transform <- is.numeric(self$scale_x) || is.numeric(self$scale_y) ||
        is.numeric(self$shear_x) || is.numeric(self$shear_y) ||
        is.numeric(self$translate_x) || is.numeric(self$translate_y)

      if (has_transform) {
        page_element_list[["transform"]] <- list(
          unit       = self$transform_unit,
          scaleX     = self$scale_x,
          scaleY     = self$scale_y,
          shearX     = self$shear_x,
          shearY     = self$shear_y,
          translateX = self$translate_x,
          translateY = self$translate_y
        )
      }

      page_element_list
    },

    #' @description Print a human-readable summary.
    print = function(...) {
      cli::cli_text("<PageElementProperty>")
      cli::cli_text("  Page: {.val {self$page_object_id}}")
      if (!is.null(self$width_magnitude) || !is.null(self$height_magnitude)) {
        cli::cli_text(
          "  Size: {self$width_magnitude %||% '?'} x {self$height_magnitude %||% '?'} {self$width_unit}"
        )
      }
      has_transform <- !is.null(self$scale_x) || !is.null(self$scale_y) ||
        !is.null(self$translate_x) || !is.null(self$translate_y)
      if (has_transform) {
        cli::cli_text(
          "  Transform [{self$transform_unit}]: scale ({self$scale_x %||% 1}, {self$scale_y %||% 1}), translate ({self$translate_x %||% 0}, {self$translate_y %||% 0})"
        )
      }
      invisible(self)
    }
  )
)
