# Clear Google Slides credentials

Put rgoogleslides into a de-authorized state. After calling
`gs_deauth()`, any request that requires authorization will fail.

## Usage

``` r
gs_deauth()
```

## Value

None, called for side effects.

## See also

Other auth:
[`gs_auth()`](https://eivicent.github.io/rgoogleslides/reference/gs_auth.md),
[`gs_auth_configure()`](https://eivicent.github.io/rgoogleslides/reference/gs_auth_configure.md),
[`gs_has_token()`](https://eivicent.github.io/rgoogleslides/reference/gs_has_token.md),
[`gs_oauth_client()`](https://eivicent.github.io/rgoogleslides/reference/gs_oauth_client.md),
[`gs_token()`](https://eivicent.github.io/rgoogleslides/reference/gs_token.md)

## Examples

``` r
gs_deauth()
```
