# Docker images for anvil

This repository builds daily docker images for https://github.com/r-xla/anvil for both CPU and CUDA.
Only amd64 architecture is supported.

## Images

| Image | Description |
|-------|-------------|
| `sebffischer/anvil-cpu` | CPU-only anvil image |
| `sebffischer/anvil-cuda-base` | CUDA base image |
| `sebffischer/anvil-cuda` | CUDA anvil image |
| `sebffischer/anvil-cpu-bench` | CPU image with benchmarking packages (torch, data.table, batchtools, mirai, bench, here) |
| `sebffischer/anvil-cuda-bench` | CUDA image with benchmarking packages (torch, data.table, batchtools, mirai, bench, here) |

## Pulling the Docker Image

```bash
docker pull sebffischer/anvil-cpu:latest
docker pull sebffischer/anvil-cuda:latest
docker pull sebffischer/anvil-cpu-bench:latest
docker pull sebffischer/anvil-cuda-bench:latest
```

## Building the Docker Image

```bash
make cpu
make cuda
make cuda-base
make cpu-bench
make cuda-bench
```
