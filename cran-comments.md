## R CMD check results

0 errors | 0 warnings | 1 note

* checking for future file timestamps ... NOTE
  unable to verify current time
  → Network/machine issue on the local check machine; not a package problem.

## Test environments

* Local: macOS aarch64 (Apple Silicon), R 4.4.2
* win-builder: R-release, R-devel (run via `devtools::check_win_release()` and
  `devtools::check_win_devel()` before submission)

## Resubmission (1.0.1)

This package was previously archived from CRAN on 2025-06-13 due to
unresolved NOTEs. This resubmission addresses all issues and includes a
major modernisation and a subsequent bug-fix release:

**Infrastructure (vs archived 0.3.x)**

* Added `Authors@R` field (previously used deprecated `Author`/`Maintainer`)
* Removed `LazyData: TRUE` (no `data/` directory)
* Fixed Rd cross-references with proper package anchors
* Rewrote authentication to use the gargle package
* Replaced assertthat with cli for error messages
* Added testthat 3 test suite

**Bug fixes (1.0.1)**

* Fixed `add_delete_text_request()` cross-argument range logic
* Fixed `add_insert_text_request()` and `add_delete_text_request()` for
  partial row/column index supply
* Fixed `gs_auth_configure()` no-argument and type-validation errors
* Various other API request builder fixes (see NEWS.md for full list)