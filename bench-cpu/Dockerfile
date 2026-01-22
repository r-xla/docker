FROM sebffischer/anvil-cpu:latest

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends libicu-dev \
    && rm -rf /var/lib/apt/lists/*

# Use pppm
COPY .Rprofile /usr/local/lib/R/etc/Rprofile.site


# Otherwise wrong libicui
RUN Rscript --vanilla -e 'options(repos = c(CRAN = "https://cloud.r-project.org")); install.packages("stringi")'

RUN R -q -e "install.packages(c('torch', 'data.table', 'batchtools', 'mirai', 'bench', 'here'))"

# Install CPU libtorch binaries for R torch
RUN R -q -e "torch::install_torch()"

CMD ["bash"]
