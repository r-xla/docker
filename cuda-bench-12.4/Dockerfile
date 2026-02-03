# Self-contained anvil-cuda-bench image using CUDA 12.4
# Combines cuda-base + cuda + cuda-bench layers with CUDA 12.4.1
FROM nvidia/cuda:12.4.1-cudnn-devel-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive

# -------- system packages & R (from cuda-base) --------
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

# -------- additional system packages --------
RUN apt-get update -y \
  && apt-get install -y sudo software-properties-common dialog apt-utils tzdata libpng-dev locales pkg-config wget qpdf \
  && locale-gen en_US.UTF-8 \
  && update-locale LANG=en_US.UTF-8 \
  && rm -rf /var/lib/apt/lists/*

# -------- install nvshmem --------
RUN cd /tmp \
  && wget https://developer.download.nvidia.com/compute/nvshmem/3.2.5/local_installers/nvshmem-local-repo-ubuntu2204-3.2.5_3.2.5-1_amd64.deb \
  && dpkg -i nvshmem-local-repo-ubuntu2204-3.2.5_3.2.5-1_amd64.deb \
  && rm -f /tmp/*.deb \
  && cp /var/nvshmem-local-repo-ubuntu2204-3.2.5/nvshmem-*-keyring.gpg /usr/share/keyrings/ \
  && apt-get update \
  && apt-get -y --allow-change-held-packages install nvshmem-cuda-12=3.4.5-1 libnccl2 libnccl-dev libnvshmem3-cuda-12=3.4.5-1 libnvshmem3-static-cuda-12=3.4.5-1 libnvshmem3-dev-cuda-12=3.4.5-1 \
  && rm -rf /var/nvshmem-local-repo-ubuntu2204-3.2.5 \
  && rm -f /etc/apt/sources.list.d/*nvshmem* \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/* \
  && apt-get update && rm -rf /var/lib/apt/lists/*

# -------- install R using rig --------
RUN curl -Ls https://github.com/r-lib/rig/releases/download/latest/rig-linux-latest.tar.gz | \
    tar xz -C /usr/local && \
    rig add 4.5 && \
    rig default 4.5

RUN Rscript -e "print(sessionInfo());"

# -------- R defaults: PPM + binaries-only --------
COPY .Rprofile /usr/local/lib/R/etc/Rprofile.site

# -------- install R packages (from cuda) --------
RUN R -q -e "install.packages('remotes', force = TRUE)"

# Cache bust to always reinstall anvil
ARG CACHEBUST=1

ARG GITHUB_PAT=""
RUN GITHUB_PAT="${GITHUB_PAT}" \
    R -q -e "remotes::install_github('r-xla/anvil', force = TRUE)"

# Download PJRT plugins
# Can't use nv_tensor() here because it fails if no GPU is available
RUN R -q -e "pjrt:::plugin_path('cpu'); pjrt:::plugin_path('cuda')"

# -------- bench extras (from cuda-bench) --------
RUN apt-get update \
    && apt-get install -y --no-install-recommends python3 python3-dev python3-pip python3-venv \
    && rm -rf /var/lib/apt/lists/*

# Install PyTorch with CUDA 12.4 support
# --break-system-packages is needed because Ubuntu 24.04+ marks system Python as
# externally managed (PEP 668). Safe here since this is a container.
RUN pip3 install --no-cache-dir --break-system-packages \
    torch --index-url https://download.pytorch.org/whl/cu124

# Otherwise wrong libicui
RUN Rscript --vanilla -e 'options(repos = c(CRAN = "https://cloud.r-project.org")); install.packages("stringi", force = TRUE)'

RUN R -q -e "install.packages(c('torch', 'data.table', 'batchtools', 'mirai', 'bench', 'here', 'reticulate'), force = TRUE)"

RUN R -q -e "torch::install_torch()"

CMD ["bash"]
