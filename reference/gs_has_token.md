# Is there a token on hand?

Reports whether rgoogleslides has stored a token, ready for use in
downstream requests.

## Usage

``` r
gs_has_token()
```

## Value

`TRUE` if a token is available, `FALSE` otherwise.

## See also

Other auth:
[`gs_auth()`](https://eivicent.github.io/rgoogleslides/reference/gs_auth.md),
[`gs_auth_configure()`](https://eivicent.github.io/rgoogleslides/reference/gs_auth_configure.md),
[`gs_deauth()`](https://eivicent.github.io/rgoogleslides/reference/gs_deauth.md),
[`gs_oauth_client()`](https://eivicent.github.io/rgoogleslides/reference/gs_oauth_client.md),
[`gs_token()`](https://eivicent.github.io/rgoogleslides/reference/gs_token.md)

## Examples

``` r
gs_has_token()
#> [1] FALSE
```
