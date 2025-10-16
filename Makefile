# Build variables (override with: make cpu IMAGE_NAME=myimg CPU_TAG=mytag)
IMAGE_NAME ?= anvil-cpu
CPU_TAG ?= latest
IMAGE_TAG := $(IMAGE_NAME):$(CPU_TAG)
DOCKERFILE ?= cpu/Dockerfile
PLATFORM ?= linux/amd64
PROGRESS ?= plain
GITHUB_PAT_FILE ?= $(HOME)/.github_pat

.PHONY: cpu
cpu:
	@echo "Building $(IMAGE_TAG) for $(PLATFORM) using $(DOCKERFILE)"
	@SECRET_FLAG=""; if [ -f "$(GITHUB_PAT_FILE)" ]; then \
		echo "Using GitHub PAT from $(GITHUB_PAT_FILE)"; \
		SECRET_FLAG="--secret id=github_pat,src=$(GITHUB_PAT_FILE)"; \
	else \
		echo "No GitHub PAT file found at $(GITHUB_PAT_FILE); proceeding without it"; \
	fi; \
	DOCKER_BUILDKIT=1 docker build $$SECRET_FLAG \
		--platform $(PLATFORM) \
		--progress=$(PROGRESS) \
		-f $(DOCKERFILE) -t $(IMAGE_TAG) .
