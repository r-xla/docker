# -------- CUDA-capable base image --------
FROM nvcr.io/nvidia/cuda:12.8.1-cudnn-devel-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive

# -------- system packages & R --------
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    build-essential \
    pkg-config \
    cmake \
    curl \
    ca-certificates \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libprotobuf-dev \
    protobuf-compiler \
    libicu-dev \
  && rm -rf /var/lib/apt/lists/*

# -------- install R using rig ----------------------------------
RUN curl -Ls https://github.com/r-lib/rig/releases/download/latest/rig-linux-latest.tar.gz | \
    tar xz -C /usr/local && \
    rig add 4.5.0 && \
    rig default 4.5.0

RUN Rscript -e "print(sessionInfo());"

# ---------- R defaults: PPM + binaries-only ----------
COPY .Rprofile /usr/local/lib/R/etc/Rprofile.site

# -------- install R packages---------------------------
RUN R -q -e "install.packages('remotes')"
# GITHUB_PAT is NOT part of the image
RUN --mount=type=secret,id=github_pat \
    export GITHUB_PAT="$(cat /run/secrets/github_pat 2>/dev/null || true)" && \
    R -q -e "remotes::install_github('r-xla/anvil')"

# Download PJRT plugins
# Can't use nv_tensor() here because it fails if no GPU is available
RUN R -q -e "pjrt:::plugin_path('cpu'); pjrt:::plugin_path('cuda')"

CMD ["bash"]
