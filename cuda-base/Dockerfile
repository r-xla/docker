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

# -------- additional system packages --------
RUN apt-get update -y && apt-get install -y \
    sudo \
    software-properties-common \
    dialog \
    apt-utils \
    tzdata \
    libpng-dev \
    locales \
    wget \
  && locale-gen en_US.UTF-8 \
  && update-locale LANG=en_US.UTF-8 \
  && rm -rf /var/lib/apt/lists/*

# -------- install nvshmem --------
RUN cd /tmp \
  && wget https://developer.download.nvidia.com/compute/nvshmem/3.2.5/local_installers/nvshmem-local-repo-ubuntu2404-3.2.5_3.2.5-1_amd64.deb \
  && dpkg -i nvshmem-local-repo-ubuntu2404-3.2.5_3.2.5-1_amd64.deb \
  && cp /var/nvshmem-local-repo-ubuntu2404-3.2.5/nvshmem-*-keyring.gpg /usr/share/keyrings/ \
  && apt-get update \
  && apt-get -y --allow-change-held-packages install nvshmem-cuda-12 libnccl2 libnccl-dev \
  && rm -rf /var/lib/apt/lists/* /tmp/*.deb

# -------- install R using rig ----------------------------------
RUN curl -Ls https://github.com/r-lib/rig/releases/download/latest/rig-linux-latest.tar.gz | \
    tar xz -C /usr/local && \
    rig add 4.5.0 && \
    rig default 4.5.0

RUN Rscript -e "print(sessionInfo());"

# ---------- R defaults: PPM + binaries-only ----------
COPY .Rprofile /usr/local/lib/R/etc/Rprofile.site

CMD ["bash"]
