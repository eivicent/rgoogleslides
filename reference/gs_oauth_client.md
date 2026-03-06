# Retrieve the configured OAuth client

Retrieve the configured OAuth client

## Usage

``` r
gs_oauth_client()
```

## Value

A gargle OAuth client object, or `NULL` if not configured.

## See also

Other auth:
[`gs_auth()`](https://eivicent.github.io/rgoogleslides/reference/gs_auth.md),
[`gs_auth_configure()`](https://eivicent.github.io/rgoogleslides/reference/gs_auth_configure.md),
[`gs_deauth()`](https://eivicent.github.io/rgoogleslides/reference/gs_deauth.md),
[`gs_has_token()`](https://eivicent.github.io/rgoogleslides/reference/gs_has_token.md),
[`gs_token()`](https://eivicent.github.io/rgoogleslides/reference/gs_token.md)

## Examples

``` r
gs_oauth_client()
#> NULL
```
