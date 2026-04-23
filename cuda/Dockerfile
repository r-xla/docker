# -------- Build on cuda-base image --------
FROM sebffischer/anvl-cuda-base:latest

# -------- install R packages---------------------------
RUN R -q -e "install.packages('remotes', force = TRUE)"

# Cache bust to always reinstall anvl
ARG CACHEBUST=1
ARG ANVL_REF=""

# GITHUB_PAT is NOT part of the image
# USE_BUNDLED_LIBUV: fs >= 2.1.0 no longer auto-falls back to its bundled libuv
# when system libuv-dev is absent, so force the bundled build.
RUN --mount=type=secret,id=github_pat \
    export GITHUB_PAT="$(cat /run/secrets/github_pat 2>/dev/null || true)" && \
    ANVL_REF="${ANVL_REF:-HEAD}" \
    USE_BUNDLED_LIBUV=1 \
    R -q -e "remotes::install_github('r-xla/anvl', ref = Sys.getenv('ANVL_REF'), force = TRUE)"

# Download PJRT plugins
# Can't use nv_array() here because it fails if no GPU is available
RUN R -q -e "options(timeout = 600); pjrt:::plugin_path('cpu'); pjrt:::plugin_path('cuda')"

CMD ["bash"]
