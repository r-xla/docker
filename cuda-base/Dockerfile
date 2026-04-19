# -------- CUDA-capable base image --------
# CUDA toolkit libraries are provided by the cuda12.8 R package at runtime.
# We only need the base image with driver libs (same as pjrt CI).
FROM nvidia/cuda:12.8.1-base-ubuntu24.04

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
    sudo \
    software-properties-common \
    dialog \
    apt-utils \
    tzdata \
    libpng-dev \
    locales \
    wget \
    qpdf \
  && locale-gen en_US.UTF-8 \
  && update-locale LANG=en_US.UTF-8 \
  && rm -rf /var/lib/apt/lists/*

# -------- install R using rig ----------------------------------
RUN curl -Ls https://github.com/r-lib/rig/releases/download/latest/rig-linux-latest.tar.gz | \
    tar xz -C /usr/local && \
    rig add 4.4.2 && \
    rig default 4.4.2

RUN Rscript -e "print(sessionInfo());"

# ---------- R defaults: PPM + binaries-only ----------
# rig installs R under /opt/R/<version>, so Rprofile.site must land in
# $(R RHOME)/etc -- not /usr/local/lib/R/etc.
COPY .Rprofile /tmp/Rprofile.site
RUN cp /tmp/Rprofile.site "$(R RHOME)/etc/Rprofile.site" && rm /tmp/Rprofile.site

# -------- install cuda12.8 R package --------
RUN R -q -e "install.packages('cuda12.8', repos = 'https://mlverse.r-universe.dev')"

CMD ["bash"]
