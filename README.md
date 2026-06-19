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

Build a single image with `make <target>`:

```bash
make cpu          # builds anvl-cpu:latest
make cuda-base    # builds anvl-cuda-base:latest
make cuda         # builds anvl-cuda:latest (build cuda-base first)
```

Available targets: `cpu`, `cuda-base`, `cuda`, `cpu-bench`, `cuda-bench`, `cuda-bench-12.4`.

The build is parameterised through `make` variables that you can override on the
command line:

| Variable | Default | Purpose |
|----------|---------|---------|
| `TAG` | `latest` | Image tag. |
| `PLATFORM` | `linux/amd64` | Passed to `docker build --platform`. Only amd64 is supported. |
| `<TARGET>_IMAGE_NAME` | e.g. `anvl-cpu` | Image name (repository) for that target. |
| `GITHUB_PAT_FILE` | `$(HOME)/.github_pat` | File holding a GitHub PAT. If present it is mounted as a BuildKit secret (`id=github_pat`) and used by `remotes::install_github()` to avoid GitHub API rate limits. The token is **not** baked into the image. |
| `PROGRESS` | `plain` | Passed to `docker build --progress`. |

The per-target image-name variables are `CPU_IMAGE_NAME`, `CUDA_BASE_IMAGE_NAME`,
`CUDA_IMAGE_NAME`, `CPU_BENCH_IMAGE_NAME`, `CUDA_BENCH_IMAGE_NAME`, and
`CUDA_BENCH_12_4_IMAGE_NAME`.

For example, to build the CPU image with a custom tag, or already named for the
GitHub Container Registry:

```bash
# anvl-cpu:dev
make cpu TAG=dev

# ghcr.io/r-xla/anvl-cpu:latest
make cpu CPU_IMAGE_NAME=ghcr.io/r-xla/anvl-cpu TAG=latest
```

## Pushing to the GitHub Container Registry

CI builds and pushes these images automatically (see `.github/workflows/`), so a
manual push is only needed for one-off or locally built images.

1. Create a GitHub [personal access token](https://github.com/settings/tokens)
   with the `write:packages` scope and log in to `ghcr.io`:

   ```bash
   echo "$GITHUB_PAT" | docker login ghcr.io -u <your-github-username> --password-stdin
   ```

2. Make sure the image is named under the `ghcr.io/r-xla/<image-name>` namespace.
   Either build it directly with that name:

   ```bash
   make cpu CPU_IMAGE_NAME=ghcr.io/r-xla/anvl-cpu TAG=latest
   ```

   or re-tag an image you already built:

   ```bash
   docker tag anvl-cpu:latest ghcr.io/r-xla/anvl-cpu:latest
   ```

3. Push it:

   ```bash
   docker push ghcr.io/r-xla/anvl-cpu:latest
   ```

The image then appears under the [r-xla packages](https://github.com/orgs/r-xla/packages).
A newly created package is private by default; change its visibility in the
package settings on GitHub to make it public.
