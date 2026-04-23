# Docker images for anvl

This repository builds daily docker images for https://github.com/r-xla/anvl.
Only amd64/x86-64 architecture is supported.

## Prebuilt Images

These images are built daily and pushed to [Docker Hub](https://hub.docker.com/u/sebffischer) and [GitHub Container Registry](https://github.com/orgs/r-xla/packages).

| Image | Description |
|-------|-------------|
| `anvl-cpu` | anvl with CPU support based on rocker/r-ver |
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
