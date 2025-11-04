# Docker images for anvil

This repository builds daily docker images for https://github.com/r-xla/anvil for both CPU and CUDA.
Only amd64 architecture is supported.

## Pulling the Docker Image

```bash
docker pull sebffischer/anvil-cpu:latest
# or
docker pull sebffischer/anvil-cuda:latest
```

## Building the Docker Image

Build the CPU Docker image:

```bash
make cpu
# or
make cuda
```
