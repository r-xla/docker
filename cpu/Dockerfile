FROM rocker/r-ver:latest

ENV DEBIAN_FRONTEND=noninteractive

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

# Use pppm
COPY .Rprofile /usr/local/lib/R/etc/Rprofile.site

RUN R -q -e "install.packages('remotes', force = TRUE)"

# Cache bust to always reinstall anvl
ARG CACHEBUST=1
ARG ANVL_REF=""

# GITHUB_PAT is NOT part of the image
RUN --mount=type=secret,id=github_pat \
    export GITHUB_PAT="$(cat /run/secrets/github_pat 2>/dev/null || true)" && \
    ANVL_REF="${ANVL_REF:-HEAD}" \
    R -q -e "remotes::install_github('r-xla/anvl', ref = Sys.getenv('ANVL_REF'), force = TRUE)"

# Trigger PJRT plugin download. PJRT_INSTALL=1 allows the download in this
# non-interactive build (pjrt otherwise only downloads when asked interactively).
RUN PJRT_INSTALL=1 R -q -e "anvl::nv_array(1, device = 'cpu')"

CMD ["bash"]
