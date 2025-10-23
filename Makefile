# Build variables (override with: make cpu TAG=mytag)
CPU_IMAGE_NAME ?= anvil-cpu
CUDA_IMAGE_NAME ?= anvil-cuda
TAG ?= latest
PLATFORM ?= linux/amd64
PROGRESS ?= plain
GITHUB_PAT_FILE ?= $(HOME)/.github_pat

# Internal function to build docker images
define build_image
	@echo "Building $(2):$(TAG) for $(PLATFORM) using $(1)/Dockerfile"
	@SECRET_FLAG=""; if [ -f "$(GITHUB_PAT_FILE)" ]; then \
		echo "Using GitHub PAT from $(GITHUB_PAT_FILE)"; \
		SECRET_FLAG="--secret id=github_pat,src=$(GITHUB_PAT_FILE)"; \
	else \
		echo "No GitHub PAT file found at $(GITHUB_PAT_FILE); proceeding without it"; \
	fi; \
	DOCKER_BUILDKIT=1 docker build $$SECRET_FLAG \
		--platform $(PLATFORM) \
		--progress=$(PROGRESS) \
		-f $(1)/Dockerfile -t $(2):$(TAG) .
endef

.PHONY: cpu
cpu:
	$(call build_image,cpu,$(CPU_IMAGE_NAME))

.PHONY: cuda
cuda:
	$(call build_image,cuda,$(CUDA_IMAGE_NAME))
