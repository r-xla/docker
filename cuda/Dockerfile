# -------- Build on cuda-base image --------
FROM sebffischer/anvil-cuda-base:latest

# -------- install R packages---------------------------
RUN R -q -e "install.packages('remotes', force = TRUE)"

# Cache bust to always reinstall anvil
ARG CACHEBUST=1

# GITHUB_PAT is NOT part of the image
RUN --mount=type=secret,id=github_pat \
    export GITHUB_PAT="$(cat /run/secrets/github_pat 2>/dev/null || true)" && \
    R -q -e "remotes::install_github('r-xla/anvil', force = TRUE)"

# Download PJRT plugins
# Can't use nv_tensor() here because it fails if no GPU is available
RUN R -q -e "pjrt:::plugin_path('cpu'); pjrt:::plugin_path('cuda')"

CMD ["bash"]
