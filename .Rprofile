# Install Linux binaries from Posit Package Manager (PPM).
local({
  # Binaries are built per Ubuntu release and link against its system libraries
  # (e.g. ICU), so the repo must match the release of the image.
  os_release <- readLines("/etc/os-release")
  codename <- sub("^VERSION_CODENAME=", "", grep("^VERSION_CODENAME=", os_release, value = TRUE))
  options(
    # PPM serves binaries for this R version + distro based on the User-Agent.
    # libcurl (R's built-in downloader) reads this option directly; the external
    # "curl" method does NOT -- system2() splits download.file.extra on
    # whitespace and mangles --header "User-Agent: ..." quoting, which makes PPM
    # fall back to serving source packages.
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
      CRAN = sprintf("https://packagemanager.posit.co/cran/__linux__/%s/latest", codename)
    )
  )
})
