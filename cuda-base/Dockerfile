# -------- CUDA-capable base image --------
FROM nvidia/cuda:12.6.3-cudnn-devel-ubuntu20.04

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
RUN apt-get update -y \
  && apt-get install -y sudo software-properties-common dialog apt-utils tzdata libpng-dev locales pkg-config wget qpdf \
  && locale-gen en_US.UTF-8 \
  && update-locale LANG=en_US.UTF-8 \
  && rm -rf /var/lib/apt/lists/*

# -------- install nvshmem --------
RUN cd /tmp \
  && wget https://developer.download.nvidia.com/compute/nvshmem/3.2.5/local_installers/nvshmem-local-repo-ubuntu2004-3.2.5_3.2.5-1_amd64.deb \
  && dpkg -i nvshmem-local-repo-ubuntu2004-3.2.5_3.2.5-1_amd64.deb \
  && rm -f /tmp/*.deb \
  && cp /var/nvshmem-local-repo-ubuntu2004-3.2.5/nvshmem-*-keyring.gpg /usr/share/keyrings/ \
  && apt-get update \
  && apt-get -y --allow-change-held-packages install nvshmem-cuda-12=3.4.5-1 libnccl2 libnccl-dev libnvshmem3-cuda-12=3.4.5-1 libnvshmem3-static-cuda-12=3.4.5-1 libnvshmem3-dev-cuda-12=3.4.5-1 \
  && rm -rf /var/nvshmem-local-repo-ubuntu2004-3.2.5 \
  && rm -f /etc/apt/sources.list.d/*nvshmem* \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/* \
  && apt-get update && rm -rf /var/lib/apt/lists/*

# -------- install R using rig ----------------------------------
RUN curl -Ls https://github.com/r-lib/rig/releases/download/latest/rig-linux-latest.tar.gz | \
    tar xz -C /usr/local && \
    rig add 4.4.2 && \
    rig default 4.4.2

RUN Rscript -e "print(sessionInfo());"

# ---------- R defaults: PPM + binaries-only ----------
COPY .Rprofile /usr/local/lib/R/etc/Rprofile.site

CMD ["bash"]
