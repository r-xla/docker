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

# Download the PJRT plugins. pjrt stores them in its installation directory in
# the system library, where every user of the image finds them. Also check that
# the CUDA components installed in the base image are still in place (loading
# the CUDA plugin needs a GPU, so it can't be tested here).
RUN R -q -e "pjrt::install_pjrt(cuda = TRUE); stopifnot(pjrt.cuda::cuda_installed())"

CMD ["bash"]
