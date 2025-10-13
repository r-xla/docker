FROM rocker/r-ver:4.5.1

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

# Configure R to use Posit Package Manager and proper UA via site profile
COPY .Rprofile /usr/local/lib/R/etc/Rprofile.site

# Install required R packages
RUN R -q -e "install.packages(c('remotes','bench','ggplot2','torch'))"

# Install CPU libtorch for the R torch package
RUN R -q -e "torch::install_torch()"

# Install anvil (and its GitHub remote dependencies)
RUN R -q -e "remotes::install_github('r-xla/anvil')"

# Trigger PJRT plugin download
RUN R -q -e "anvil::nv_tensor(1)"

CMD ["bash"]


