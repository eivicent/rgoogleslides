# rgoogleslides

<!-- badges: start -->
[![R-CMD-check](https://github.com/eivicent/rgoogleslides/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/eivicent/rgoogleslides/actions/workflows/R-CMD-check.yaml)
[![Codecov test coverage](https://codecov.io/gh/eivicent/rgoogleslides/graph/badge.svg)](https://app.codecov.io/gh/eivicent/rgoogleslides)
[![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

rgoogleslides is an R interface to the [Google Slides API](https://developers.google.com/slides/api). It lets you create and modify Google Slides presentations programmatically from R -- ideal for reproducible reporting workflows where analysis results need to land directly in slides.

## Installation

Install the development version from GitHub:

```r
# install.packages("pak")
pak::pak("eivicent/rgoogleslides")
```

## Authentication

rgoogleslides uses [gargle](https://gargle.r-lib.org/) for authentication, which means it shares the same credential infrastructure as googledrive and googlesheets4.

```r
library(rgoogleslides)

# Interactive OAuth -- opens browser on first use, caches the token
gs_auth()

# Or use a service account
gs_auth(path = "/path/to/service-account.json")
```

## Quick start

```r
library(rgoogleslides)

# Create a new presentation
presentation_id <- create_slides("Quarterly Report")

# Add a blank slide
requests <- add_create_slide_page_request(predefined_layout = "TITLE_AND_BODY")
commit_to_slides(presentation_id, requests)

# Insert text into a shape
requests <- add_insert_text_request(object_id = "<shape-id>", text = "Hello from R!")
commit_to_slides(presentation_id, requests)

# Insert a data table from a data frame
props <- get_slides_properties(presentation_id)
page_id <- props$slides$objectId[2]
prop <- page_element_property(page_id, width_magnitude = 600, height_magnitude = 300)
create_data_table(presentation_id, prop, head(iris))
```

## Features

- **Create presentations** and add slides with any layout
- **Insert text**, images, tables, shapes, and YouTube videos
- **Replace text and images** across all slides with a single call
- **Read slide content** -- extract tables, text boxes, and speaker notes
- **Batch operations** -- accumulate multiple requests and commit them at once
- **gargle-powered auth** -- OAuth, service accounts, and token sharing

## Contributing

Issues and pull requests are welcome at
<https://github.com/eivicent/rgoogleslides>.
