.onLoad <- function(libname, pkgname) {
  utils::assignInMyNamespace(
    ".auth",
    gargle::init_AuthState(package = "rgoogleslides", auth_active = TRUE)
  )

  if (gargle::secret_has_key("RGOOGLESLIDES_KEY")) {
    tryCatch(
      {
        client <- gargle::gargle_oauth_client_from_json(
          gargle::secret_decrypt_json(
            system.file("secret", "rgoogleslides-oauth-client.json",
              package = "rgoogleslides"
            ),
            "RGOOGLESLIDES_KEY"
          )
        )
        .auth$set_client(client)
      },
      error = function(e) {
        rlang::warn(
          c(
            "Failed to load the built-in OAuth client for rgoogleslides.",
            "i" = "The RGOOGLESLIDES_KEY environment variable may be incorrect or the credential file may be corrupted.",
            "i" = "Use gs_auth_configure() to supply your own OAuth client."
          ),
          parent = e
        )
      }
    )
  }

  invisible()
}
