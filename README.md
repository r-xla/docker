# Docker images for anvl

This repository builds daily docker images for https://github.com/r-xla/anvl.
Only amd64/x86-64 architecture is supported.

## Prebuilt Images

These images are built daily and pushed to [Docker Hub](https://hub.docker.com/u/sebffischer) and [GitHub Container Registry](https://github.com/orgs/r-xla/packages).

| Image | Description |
|-------|-------------|
| `anvl-cpu` | Anvl with CPU support based on rocker/r-ver |
| `anvl-cuda-base` | Base image with CUDA 12.8.1 and all {anvl} system dependencies |
| `anvl-cuda` | `anvl-cuda-base` with {anvl} installed |

All images come with R installed.

Each image is available with two tags:

| Tag | Description |
|-----|-------------|
| `:latest` | Built from the anvl `main` branch (rebuilt daily and on push) |
| `:release` | Built from the latest anvl release (rebuilt when a new release is published) |

```bash
# From Docker Hub
docker pull sebffischer/<image-name>:latest
docker pull sebffischer/<image-name>:release
# From GitHub Container Registry
docker pull ghcr.io/r-xla/<image-name>:latest
docker pull ghcr.io/r-xla/<image-name>:release
```

## Running the CUDA Image

The CUDA images require the [NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html) to be installed on the host, which exposes the host's GPUs to the container. Follow the upstream installation instructions for your Linux distribution and configure the Docker runtime before running the image.

On WSL2, install the NVIDIA GPU driver on the **Windows host** only (do not install a Linux NVIDIA driver inside WSL2), then install the NVIDIA Container Toolkit inside the WSL2 distro as above. See NVIDIA's [CUDA on WSL user guide](https://docs.nvidia.com/cuda/wsl-user-guide/index.html) for details. Docker Desktop users can instead enable WSL integration in its settings, which ships the toolkit.

Once installed, start the container with `--gpus all` to make all GPUs available:

```bash
docker run --rm -it --gpus all sebffischer/anvil-cuda:latest R
```

## Additional Dockerfiles

These Dockerfiles are available for local builds but are not automatically built in CI.

| Image | Description |
|-------|-------------|
| `anvl-cpu-bench` | `anvl-cpu` + dependencies for benchmarking |
| `anvl-cuda-bench` | `anvl-cuda` + dependencies for benchmarking |

## Building Images Locally

```bash
make <target>
```

Available targets: `cpu`, `cuda-base`, `cuda`, `cpu-bench`, `cuda-bench`
