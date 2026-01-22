# Docker images for anvil

This repository builds daily docker images for https://github.com/r-xla/anvil.
Only amd64/x86-64 architecture is supported.

## Available Images


| Image | Description |
|-------|-------------|
| `anvil-cpu` | Anvil with CPU support based on rocker/r-ver |
| `anvil-cuda-base` | Base image with CUDA 12.8.1 and all {anvil} system dependencies |
| `anvil-cuda` | `anvil-base-cuda` with {anvil} installed |
| `anvil-bench-cpu` | `anvil-cpu` image + dependencies for benchmarking |

All images come with R installed.

## Pulling Images

```bash
docker pull sebffischer/<image-name>:latest
```

## Building Images

```bash
make <target>
```

Available targets: `cpu`, `cuda`, `cuda-base`, `bench-cpu`
