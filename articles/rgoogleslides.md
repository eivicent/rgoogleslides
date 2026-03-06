# Getting started with rgoogleslides

## Overview

rgoogleslides lets you create and modify Google Slides presentations
directly from R. It talks to the [Google Slides API
v1](https://developers.google.com/slides/api) and uses
[gargle](https://gargle.r-lib.org/) for authentication, which means you
can share credentials with googledrive and googlesheets4.

## Authentication

The first step is to authenticate. For interactive use,
[`gs_auth()`](https://eivicent.github.io/rgoogleslides/reference/gs_auth.md)
opens a browser window where you grant access to your Google account:

``` r
library(rgoogleslides)
gs_auth()
```

For automated / CI workflows, it is recommended to use a service
account:

``` r
gs_auth(path = "path/to/service-account.json")
```

## Creating a presentation

``` r
id <- create_slides("My Report")
id
#> [1] "1abc..."
```

## Adding slides

Build one or more requests with the `add_*_request()` family, then
commit them all at once:

``` r
requests <- add_create_slide_page_request(predefined_layout = "TITLE_AND_BODY")
requests <- add_create_slide_page_request(requests, predefined_layout = "BLANK")
commit_to_slides(id, requests)
```

## Inserting text

``` r
requests <- add_insert_text_request(object_id = "<shape-id>", text = "Hello!")
commit_to_slides(id, requests)
```

## Inserting a data table

[`create_data_table()`](https://eivicent.github.io/rgoogleslides/reference/create_data_table.md)
is a convenience function that creates a table and fills it with a data
frame in one call:

``` r
props <- get_slides_properties(id)
page_id <- props$slides$objectId[[2]]

prop <- page_element_property(page_id, width_magnitude = 600, height_magnitude = 300)
create_data_table(id, prop, head(mtcars))
```

## Reading slide content

``` r
page <- get_slide_page_properties(id, page_id)

page$get_tables()
page$get_text_boxes()
page$get_notes()
```

## Replacing text globally

``` r
requests <- add_replace_all_text_request(
  replace_text = "2026",
  text = "{{YEAR}}",
  match_case = TRUE
)
commit_to_slides(id, requests)
```

## Further reading

- [Google Slides API
  reference](https://developers.google.com/slides/api/reference/rest)
- [gargle: managing Google credentials](https://gargle.r-lib.org/)
