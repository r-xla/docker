# Docker images for anvil

This repository builds daily docker images for https://github.com/r-xla/anvil.
Only amd64 architecture is supported.

## Available Images

| Image | Description |
|-------|-------------|
| `anvil-cpu` | Anvil with CPU support based on rocker/r-ver |
| `anvil-cuda` | Anvil with CUDA and CPU support for GPU acceleration |
| `anvil-cuda-base` | Base image with CUDA 12.8.1, cuDNN, R, and NVSHMEM (no anvil) |
| `anvil-bench-cpu` | CPU benchmarking image with torch and bench package |

## Pulling Images

```bash
docker pull sebffischer/<image-name>:latest
```

## Building Images

```bash
make <target>
```

Available targets: `cpu`, `cuda`, `cuda-base`, `bench-cpu`
