# Set HTTP User-Agent so PPM serves Linux binaries for this R version + distro.
# libcurl (R's built-in downloader) reads this option directly; the external
# "curl" method does NOT -- system2() splits download.file.extra on whitespace
# and mangles --header "User-Agent: ..." quoting, which makes PPM fall back to
# serving source packages.
options(
  HTTPUserAgent = sprintf(
    "R/%s R (%s)",
    getRversion(),
    paste(
      getRversion(),
      R.version$platform,
      R.version$arch,
      R.version$os
    )
  ),
  download.file.method = "libcurl",
  repos = c(
    CRAN = "https://packagemanager.posit.co/cran/__linux__/noble/latest"
  )
)

.libPaths(sprintf("/root/R/x86_64-pc-linux-gnu-library/%s.%s", R.version$major, R.version$minor))
