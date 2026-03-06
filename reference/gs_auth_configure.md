# Edit auth configuration

Edit auth configuration

## Usage

``` r
gs_auth_configure(client, path)
```

## Arguments

- client:

  A Google OAuth client, as produced by
  [`gargle::gargle_oauth_client()`](https://gargle.r-lib.org/reference/gargle_oauth_client_from_json.html).

- path:

  Path to a JSON file with client credentials.

## Value

None, called for side effects.

## See also

Other auth:
[`gs_auth()`](https://eivicent.github.io/rgoogleslides/reference/gs_auth.md),
[`gs_deauth()`](https://eivicent.github.io/rgoogleslides/reference/gs_deauth.md),
[`gs_has_token()`](https://eivicent.github.io/rgoogleslides/reference/gs_has_token.md),
[`gs_oauth_client()`](https://eivicent.github.io/rgoogleslides/reference/gs_oauth_client.md),
[`gs_token()`](https://eivicent.github.io/rgoogleslides/reference/gs_token.md)

## Examples

``` r
if (FALSE) { # interactive()
gs_auth_configure(path = "/path/to/oauth-client.json")
}
```
