# Produce a configured token

For internal use or for other packages that wish to use the same
credentials as rgoogleslides. Returns a token pre-processed into a
suitable form for use with
[`httr::config()`](https://httr.r-lib.org/reference/config.html).

## Usage

``` r
gs_token()
```

## Value

An [`httr::config()`](https://httr.r-lib.org/reference/config.html)
object with the current credential, or `NULL` if auth is not active.

## See also

Other auth:
[`gs_auth()`](https://eivicent.github.io/rgoogleslides/reference/gs_auth.md),
[`gs_auth_configure()`](https://eivicent.github.io/rgoogleslides/reference/gs_auth_configure.md),
[`gs_deauth()`](https://eivicent.github.io/rgoogleslides/reference/gs_deauth.md),
[`gs_has_token()`](https://eivicent.github.io/rgoogleslides/reference/gs_has_token.md),
[`gs_oauth_client()`](https://eivicent.github.io/rgoogleslides/reference/gs_oauth_client.md)

## Examples

``` r
if (FALSE) { # gs_has_token()
gs_token()
}
```
