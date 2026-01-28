# Docker images for anvil

This repository builds daily docker images for https://github.com/r-xla/anvil.
Only amd64/x86-64 architecture is supported.

## Prebuilt Images

These images are built daily and pushed to Docker Hub.

| Image | Description |
|-------|-------------|
| `anvil-cpu` | Anvil with CPU support based on rocker/r-ver |
| `anvil-cuda-base` | Base image with CUDA 12.8.1 and all {anvil} system dependencies |
| `anvil-cuda` | `anvil-cuda-base` with {anvil} installed |

All images come with R installed.

```bash
docker pull sebffischer/<image-name>:latest
```

## Additional Dockerfiles

These Dockerfiles are available for local builds but are not automatically built in CI.

| Image | Description |
|-------|-------------|
| `anvil-cpu-bench` | `anvil-cpu` + dependencies for benchmarking |
| `anvil-cuda-bench` | `anvil-cuda` + dependencies for benchmarking |

## Building Images Locally

```bash
make <target>
```

Available targets: `cpu`, `cuda-base`, `cuda`, `cpu-bench`, `cuda-bench`
