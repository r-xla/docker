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

RUN R -q -e "install.packages('remotes')"

# GITHUB_PAT is NOT part of the image
RUN --mount=type=secret,id=github_pat \
    export GITHUB_PAT="$(cat /run/secrets/github_pat 2>/dev/null || true)" && \
    R -q -e "remotes::install_github('r-xla/anvil')"

# Trigger PJRT plugin download
RUN R -q -e "anvil::nv_tensor(1, device = 'cpu')"

CMD ["bash"]
