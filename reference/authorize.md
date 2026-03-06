# Authorize R package to access Google Slides API

**\[deprecated\]**

`authorize()` was deprecated in rgoogleslides 1.0.0 in favour of
[`gs_auth()`](https://eivicent.github.io/rgoogleslides/reference/gs_auth.md),
which uses the gargle package for authentication and supports service
accounts, token caching, and token sharing with other Google API
packages.

## Usage

``` r
authorize(...)
```

## Arguments

- ...:

  Arguments passed on to
  [`gs_auth()`](https://eivicent.github.io/rgoogleslides/reference/gs_auth.md).

## Value

Called for its side effect of storing a token. Returns the token
invisibly.
