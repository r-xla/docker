FROM sebffischer/anvil-cpu:latest

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends libicu-dev python3 python3-pip python3-venv \
    && rm -rf /var/lib/apt/lists/*

# Install PyTorch with CPU support
# --break-system-packages is needed because Ubuntu 24.04+ marks system Python as
# externally managed (PEP 668). Safe here since this is a container.
RUN pip3 install --no-cache-dir --break-system-packages \
    torch --index-url https://download.pytorch.org/whl/cpu

# Use pppm
COPY .Rprofile /usr/local/lib/R/etc/Rprofile.site


# Otherwise wrong libicui
RUN Rscript --vanilla -e 'options(repos = c(CRAN = "https://cloud.r-project.org")); install.packages("stringi", force = TRUE)'

RUN R -q -e "install.packages(c('torch', 'data.table', 'batchtools', 'mirai', 'bench', 'here'), force = TRUE)"

# Install CPU libtorch binaries for R torch
RUN R -q -e "torch::install_torch()"

CMD ["bash"]
