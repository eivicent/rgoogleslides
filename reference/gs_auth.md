# Authorize rgoogleslides

Authorize rgoogleslides to access the Google Slides API on your behalf.
This function is a wrapper around
[`gargle::token_fetch()`](https://gargle.r-lib.org/reference/token_fetch.html).

## Usage

``` r
gs_auth(
  email = gargle::gargle_oauth_email(),
  path = NULL,
  scopes = c("https://www.googleapis.com/auth/presentations",
    "https://www.googleapis.com/auth/drive.readonly"),
  cache = gargle::gargle_oauth_cache(),
  use_oob = gargle::gargle_oob_default(),
  token = NULL
)
```

## Arguments

- email:

  Optional. If specified, `email` can take several different forms:

  - `"jane@gmail.com"`, an actual email address. If found in the cache,
    the associated token is loaded. Otherwise, the OAuth flow is
    initiated using this email as a hint.

  - `"*@example.com"`, a domain-only pattern. Any cached token matching
    this pattern is loaded.

  - `TRUE` means that a cached token is loaded if exactly one match is
    found.

  - `FALSE` or `NA` mean to ignore the cache and always initiate a new
    OAuth flow.

- path:

  Path to a service account JSON file.

- scopes:

  A character vector of scopes for the access request.

- cache:

  Specifies the OAuth token cache. Set `FALSE` to disable.

- use_oob:

  Whether to use out-of-band authentication.

- token:

  A token to use directly, an object of class
  [httr::Token2.0](https://httr.r-lib.org/reference/Token-class.html),
  or a pre-configured request as returned by
  [`gs_token()`](https://eivicent.github.io/rgoogleslides/reference/gs_token.md).

## Value

Called for its side effect of storing a token for later use. Returns the
token invisibly.

## Details

Most users, most of the time, do not need to call `gs_auth()` explicitly
– it is triggered automatically by the first action that requires
authorization. Even when called, the default arguments often suffice.

## See also

Other auth:
[`gs_auth_configure()`](https://eivicent.github.io/rgoogleslides/reference/gs_auth_configure.md),
[`gs_deauth()`](https://eivicent.github.io/rgoogleslides/reference/gs_deauth.md),
[`gs_has_token()`](https://eivicent.github.io/rgoogleslides/reference/gs_has_token.md),
[`gs_oauth_client()`](https://eivicent.github.io/rgoogleslides/reference/gs_oauth_client.md),
[`gs_token()`](https://eivicent.github.io/rgoogleslides/reference/gs_token.md)

## Examples

``` r
if (FALSE) { # interactive()
# trigger interactive OAuth flow
gs_auth()

# use a specific email
gs_auth(email = "jane@example.com")

# use a service account
gs_auth(path = "path/to/service-account.json")
}
```
