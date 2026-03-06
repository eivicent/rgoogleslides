# ---- Shape types -------------------------------------------------------------

.valid_shape_types <- c(
  "TEXT_BOX", "RECTANGLE", "ROUND_RECTANGLE", "ELLIPSE", "ARC",
  "BENT_ARROW", "BENT_UP_ARROW", "BEVEL", "BLOCK_ARC", "BRACE_PAIR",
  "BRACKET_PAIR", "CAN", "CHEVRON", "CHORD", "CLOUD", "CORNER", "CUBE",
  "CURVED_DOWN_ARROW", "CURVED_LEFT_ARROW", "CURVED_RIGHT_ARROW",
  "CURVED_UP_ARROW", "DECAGON", "DIAGONAL_STRIPE", "DIAMOND", "DODECAGON",
  "DONUT", "DOUBLE_WAVE", "DOWN_ARROW", "DOWN_ARROW_CALLOUT", "FOLDED_CORNER",
  "FRAME", "HALF_FRAME", "HEART", "HEPTAGON", "HEXAGON", "HOME_PLATE",
  "HORIZONTAL_SCROLL", "IRREGULAR_SEAL_1", "IRREGULAR_SEAL_2", "LEFT_ARROW",
  "LEFT_ARROW_CALLOUT", "LEFT_BRACE", "LEFT_BRACKET", "LEFT_RIGHT_ARROW",
  "LEFT_RIGHT_ARROW_CALLOUT", "LEFT_RIGHT_UP_ARROW", "LEFT_UP_ARROW",
  "LIGHTNING_BOLT", "MATH_DIVIDE", "MATH_EQUAL", "MATH_MINUS",
  "MATH_MULTIPLY", "MATH_NOT_EQUAL", "MATH_PLUS", "MOON", "NO_SMOKING",
  "NOTCHED_RIGHT_ARROW", "OCTAGON", "PARALLELOGRAM", "PENTAGON", "PIE",
  "PLAQUE", "PLUS", "QUAD_ARROW", "QUAD_ARROW_CALLOUT", "RIBBON", "RIBBON_2",
  "RIGHT_ARROW", "RIGHT_ARROW_CALLOUT", "RIGHT_BRACE", "RIGHT_BRACKET",
  "RIGHT_TRIANGLE", "ROUND_1_RECTANGLE", "ROUND_2_DIAGONAL_RECTANGLE",
  "ROUND_2_SAME_RECTANGLE", "SMILEY_FACE", "SNIP_1_RECTANGLE",
  "SNIP_2_DIAGONAL_RECTANGLE", "SNIP_2_SAME_RECTANGLE", "SNIP_ROUND_RECTANGLE",
  "STAR_4", "STAR_5", "STAR_6", "STAR_7", "STAR_8", "STAR_10", "STAR_12",
  "STAR_16", "STAR_24", "STAR_32", "STRIPED_RIGHT_ARROW", "SUN", "TRAPEZOID",
  "TRIANGLE", "UP_ARROW", "UP_ARROW_CALLOUT", "UP_DOWN_ARROW", "UTURN_ARROW",
  "VERTICAL_SCROLL", "WAVE", "WEDGE_ELLIPSE_CALLOUT",
  "WEDGE_RECTANGLE_CALLOUT", "WEDGE_ROUND_RECTANGLE_CALLOUT",
  "FLOW_CHART_ALTERNATE_PROCESS", "FLOW_CHART_COLLATE",
  "FLOW_CHART_CONNECTOR", "FLOW_CHART_DECISION", "FLOW_CHART_DELAY",
  "FLOW_CHART_DISPLAY", "FLOW_CHART_DOCUMENT", "FLOW_CHART_EXTRACT",
  "FLOW_CHART_INPUT_OUTPUT", "FLOW_CHART_INTERNAL_STORAGE",
  "FLOW_CHART_MAGNETIC_DISK", "FLOW_CHART_MAGNETIC_DRUM",
  "FLOW_CHART_MAGNETIC_TAPE", "FLOW_CHART_MANUAL_INPUT",
  "FLOW_CHART_MANUAL_OPERATION", "FLOW_CHART_MERGE",
  "FLOW_CHART_MULTIDOCUMENT", "FLOW_CHART_OFFLINE_STORAGE",
  "FLOW_CHART_OFFPAGE_CONNECTOR", "FLOW_CHART_ONLINE_STORAGE",
  "FLOW_CHART_OR", "FLOW_CHART_PREDEFINED_PROCESS",
  "FLOW_CHART_PREPARATION", "FLOW_CHART_PROCESS", "FLOW_CHART_PUNCHED_CARD",
  "FLOW_CHART_PUNCHED_TAPE", "FLOW_CHART_SORT",
  "FLOW_CHART_SUMMING_JUNCTION", "FLOW_CHART_TERMINATOR",
  "ARROW_EAST", "ARROW_NORTH_EAST", "ARROW_NORTH",
  "SPEECH", "STARBURST", "TEARDROP",
  "ELLIPSE_RIBBON", "ELLIPSE_RIBBON_2", "CLOUD_CALLOUT", "CUSTOM"
)

#' List valid Google Slides shape types
#'
#' Returns a character vector of all shape type strings accepted by the Google
#' Slides API's `createShape` request. Pass any of these values as the
#' `shape_type` argument of [add_create_shape_request()].
#'
#' @return A character vector of valid shape type strings.
#' @export
#'
#' @examples
#' gs_shape_types()
gs_shape_types <- function() {
  .valid_shape_types
}

# ---- Input validation helpers ------------------------------------------------

#' @noRd
check_string <- function(x,
                         allow_null = FALSE,
                         arg = rlang::caller_arg(x),
                         call = rlang::caller_env()) {
  if (allow_null && is.null(x)) return(invisible(NULL))
  if (!rlang::is_string(x)) {
    cli::cli_abort(
      "{.arg {arg}} must be a single string, not {.obj_type_of {x}}.",
      call = call
    )
  }
  invisible(x)
}

#' @noRd
check_positive_number <- function(x,
                                   allow_null = FALSE,
                                   arg = rlang::caller_arg(x),
                                   call = rlang::caller_env()) {
  if (allow_null && is.null(x)) return(invisible(NULL))
  if (!is.numeric(x) || length(x) != 1L || !is.finite(x) || x <= 0) {
    cli::cli_abort(
      "{.arg {arg}} must be a single positive number, not {.obj_type_of {x}}.",
      call = call
    )
  }
  invisible(x)
}

#' @noRd
check_count <- function(x,
                         allow_null = FALSE,
                         arg = rlang::caller_arg(x),
                         call = rlang::caller_env()) {
  if (allow_null && is.null(x)) return(invisible(NULL))
  if (!is.numeric(x) || length(x) != 1L || !is.finite(x) ||
      x != floor(x) || x < 1) {
    cli::cli_abort(
      "{.arg {arg}} must be a positive whole number, not {.obj_type_of {x}}.",
      call = call
    )
  }
  invisible(x)
}

#' @noRd
check_index <- function(x,
                         allow_null = FALSE,
                         arg = rlang::caller_arg(x),
                         call = rlang::caller_env()) {
  if (allow_null && is.null(x)) return(invisible(NULL))
  if (!is.numeric(x) || length(x) != 1L || !is.finite(x) ||
      x != floor(x) || x < 0) {
    cli::cli_abort(
      "{.arg {arg}} must be a non-negative whole number, not {.obj_type_of {x}}.",
      call = call
    )
  }
  invisible(x)
}

#' @noRd
check_bool <- function(x,
                       arg = rlang::caller_arg(x),
                       call = rlang::caller_env()) {
  if (!rlang::is_bool(x)) {
    cli::cli_abort(
      "{.arg {arg}} must be `TRUE` or `FALSE`, not {.obj_type_of {x}}.",
      call = call
    )
  }
  invisible(x)
}

#' @noRd
check_character_vector <- function(x,
                                   allow_null = FALSE,
                                   arg = rlang::caller_arg(x),
                                   call = rlang::caller_env()) {
  if (allow_null && is.null(x)) return(invisible(NULL))
  if (!is.character(x) || length(x) == 0L || anyNA(x)) {
    cli::cli_abort(
      c(
        "{.arg {arg}} must be a non-empty character vector with no missing values.",
        "i" = "Got {.obj_type_of {x}} of length {length(x)}."
      ),
      call = call
    )
  }
  invisible(x)
}

#' @noRd
check_predefined_layout <- function(x,
                                     allow_null = FALSE,
                                     arg = rlang::caller_arg(x),
                                     call = rlang::caller_env()) {
  if (allow_null && is.null(x)) return(invisible(NULL))
  valid <- c(
    "BLANK", "CAPTION_ONLY", "TITLE", "TITLE_AND_BODY",
    "TITLE_AND_TWO_COLUMNS", "TITLE_ONLY", "SECTION_HEADER",
    "SECTION_TITLE_AND_DESCRIPTION", "ONE_COLUMN_TEXT",
    "MAIN_POINT", "BIG_NUMBER"
  )
  check_string(x, arg = arg, call = call)
  if (!x %in% valid) {
    cli::cli_abort(
      c(
        "{.arg {arg}} must be a valid predefined layout.",
        "x" = "{.val {x}} is not recognised.",
        "i" = "Valid values: {.val {valid}}."
      ),
      call = call
    )
  }
  invisible(x)
}

#' @noRd
check_range_type <- function(x,
                              arg = rlang::caller_arg(x),
                              call = rlang::caller_env()) {
  valid <- c("ALL", "FIXED_RANGE", "FROM_START_INDEX")
  check_string(x, arg = arg, call = call)
  if (!x %in% valid) {
    cli::cli_abort(
      c(
        "{.arg {arg}} must be a valid range type.",
        "x" = "{.val {x}} is not recognised.",
        "i" = "Valid values: {.val {valid}}."
      ),
      call = call
    )
  }
  invisible(x)
}

#' @noRd
check_replace_method <- function(x,
                                  arg = rlang::caller_arg(x),
                                  call = rlang::caller_env()) {
  valid <- c("CENTER_INSIDE", "CENTER_CROP")
  check_string(x, arg = arg, call = call)
  if (!x %in% valid) {
    cli::cli_abort(
      c(
        "{.arg {arg}} must be a valid replace method.",
        "x" = "{.val {x}} is not recognised.",
        "i" = "Valid values: {.val {valid}}."
      ),
      call = call
    )
  }
  invisible(x)
}

#' @noRd
check_unit <- function(x,
                        arg = rlang::caller_arg(x),
                        call = rlang::caller_env()) {
  valid <- c("PT", "EMU")
  check_string(x, arg = arg, call = call)
  if (!x %in% valid) {
    cli::cli_abort(
      c(
        "{.arg {arg}} must be a valid unit.",
        "x" = "{.val {x}} is not recognised.",
        "i" = "Valid values: {.val {valid}} ({.val PT} = points, {.val EMU} = English Metric Units)."
      ),
      call = call
    )
  }
  invisible(x)
}

#' @noRd
check_shape_type <- function(x,
                              arg = rlang::caller_arg(x),
                              call = rlang::caller_env()) {
  check_string(x, arg = arg, call = call)
  if (!x %in% .valid_shape_types) {
    cli::cli_abort(
      c(
        "{.arg {arg}} must be a valid shape type.",
        "x" = "{.val {x}} is not recognised.",
        "i" = "See {.fn gs_shape_types} for all valid values."
      ),
      call = call
    )
  }
  invisible(x)
}

#' @noRd
check_video_source <- function(x,
                                arg = rlang::caller_arg(x),
                                call = rlang::caller_env()) {
  valid <- c("YOUTUBE", "DRIVE")
  check_string(x, arg = arg, call = call)
  if (!x %in% valid) {
    cli::cli_abort(
      c(
        "{.arg {arg}} must be a valid video source.",
        "x" = "{.val {x}} is not recognised.",
        "i" = "Valid values: {.val {valid}}."
      ),
      call = call
    )
  }
  invisible(x)
}

#' Check if the object is a GoogleSlidesRequest
#' @param x Object to check.
#' @return `TRUE` if `x` is a `GoogleSlidesRequest`, `FALSE` otherwise.
#' @export
#'
#' @examples
#' req <- add_create_slide_page_request()
#' is.google_slide_request(req)
is.google_slide_request <- function(x) {
  inherits(x, "GoogleSlidesRequest")
}

#' Check if the object is a PageElementProperty
#' @param x Object to check.
#' @return `TRUE` if `x` is a `PageElementProperty`, `FALSE` otherwise.
#' @export
#'
#' @examples
#' prop <- page_element_property("slide-id-1", 200, 300)
#' is.page_element_property(prop)
is.page_element_property <- function(x) {
  inherits(x, "PageElementProperty")
}

#' @noRd
check_slide_request <- function(x,
                                arg = rlang::caller_arg(x),
                                call = rlang::caller_env()) {
  if (!is.google_slide_request(x)) {
    cli::cli_abort(
      "{.arg {arg}} must be a {.cls GoogleSlidesRequest} object.",
      call = call
    )
  }
  invisible(x)
}

#' @noRd
check_page_element_property <- function(x,
                                        arg = rlang::caller_arg(x),
                                        call = rlang::caller_env()) {
  if (!is.page_element_property(x)) {
    cli::cli_abort(
      "{.arg {arg}} must be a {.cls PageElementProperty} object.",
      call = call
    )
  }
  invisible(x)
}

# ---- URL helpers -------------------------------------------------------------

# Resolves a plain Google Drive file ID to a download URL that the Slides API
# can fetch server-side. If the value is already an http(s) URL it is returned
# unchanged. The access token is embedded as a query parameter; see the
# security note in add_create_image_request() for caveats.
.resolve_image_url <- function(url) {
  if (startsWith(url, "http://") || startsWith(url, "https://")) {
    url
  } else {
    paste0(
      "https://www.googleapis.com/drive/v3/files/", url,
      "?alt=media&access_token=", gs_access_token()
    )
  }
}

# ---- Data conversion helpers -------------------------------------------------

#' Convert dataframe for table insertion
#'
#' Converts a data frame into a long-format data frame with `value`, `row`,
#' and `column` columns suitable for inserting text into a Google Slides table.
#'
#' @param data Data frame to convert.
#' @param headers If `TRUE`, include column names as the first row (row 0).
#'
#' @return A data frame with columns `value` (character), `row` (numeric),
#'   and `column` (numeric).
#' @noRd
dataframe_convert <- function(data, headers = TRUE) {
  nr <- nrow(data)
  nc <- ncol(data)

  char_mat <- matrix(as.character(as.matrix(data)), nrow = nr, ncol = nc)
  data_values <- as.character(t(char_mat))

  if (headers) {
    all_row_ids <- c(0L, seq_len(nr))
    all_values  <- c(names(data), data_values)
  } else {
    all_row_ids <- seq_len(nr) - 1L
    all_values  <- data_values
  }

  data.frame(
    value  = all_values,
    row    = as.numeric(rep(all_row_ids, each = nc)),
    column = as.numeric(rep(seq_len(nc) - 1L, times = length(all_row_ids))),
    stringsAsFactors = FALSE
  )
}

#' Convenience function to build a centred or full-page element property
#'
#' The Google Slides API does not provide convenient ways to align elements.
#' This function calculates the necessary transforms for centring or
#' full-page placement.
#'
#' @details
#' - The image is scaled without distortion.
#' - Translation coordinates are defined by the top-left corner of the image.
#' - This function does not query the API for page size; the user must supply
#'   it.
#'
#' @param slide_page_id The slide page ID.
#' @param slide_page_height Slide height in EMU. Default `5143500`.
#' @param slide_page_width Slide width in EMU. Default `9144000`.
#' @param image_height Image height in pt. Required for `align = "center"`.
#' @param image_width Image width in pt. Required for `align = "center"`.
#' @param align Alignment mode: `"center"` or `"full"`.
#'
#' @return A `PageElementProperty` object.
#' @export
#'
#' @examples
#' # Centre an image
#' prop <- aligned_page_element_property("p", image_height = 200, image_width = 300)
#'
#' # Full-page placement
#' prop <- aligned_page_element_property("p", align = "full")
aligned_page_element_property <- function(slide_page_id,
                                          slide_page_height = 5143500,
                                          slide_page_width = 9144000,
                                          image_height = NULL,
                                          image_width = NULL,
                                          align = "center") {
  check_string(slide_page_id)
  check_positive_number(slide_page_height)
  check_positive_number(slide_page_width)

  if (!align %in% c("center", "full")) {
    cli::cli_abort("{.arg align} must be {.val center} or {.val full}.")
  }

  if (align == "center") {
    check_positive_number(image_height)
    check_positive_number(image_width)
    image_height_emu <- 12700 * image_height
    image_width_emu  <- 12700 * image_width
    translate_x <- as.integer(slide_page_width  / 2 - image_width_emu  / 2)
    translate_y <- as.integer(slide_page_height / 2 - image_height_emu / 2)
  } else {
    image_height <- slide_page_height / 12700
    image_width  <- slide_page_width  / 12700
    translate_x  <- 0
    translate_y  <- 0
  }

  page_element_property(
    slide_page_id,
    height_magnitude = image_height,
    width_magnitude  = image_width,
    scale_x = 1, scale_y = 1,
    translate_x = translate_x,
    translate_y = translate_y,
    transform_unit = "EMU"
  )
}
