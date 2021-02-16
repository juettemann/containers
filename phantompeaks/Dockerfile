FROM rocker/r-ver:4.0.2

RUN R -e "install.packages('snow', repos='http://cran.us.r-project.org')"
RUN R -e "install.packages('snowfall', repos='http://cran.us.r-project.org')"
RUN R -e "install.packages('bitops', repos='http://cran.us.r-project.org')"
RUN R -e "install.packages('caTools', repos='http://cran.us.r-project.org')"

# RUN R -e "source('http://bioconductor.org/biocLite.R')"
# RUN R -e "biocLite('Rsamtools',suppressUpdates=TRUE)"
RUN R -e "if (!requireNamespace('BiocManager', quietly = TRUE)) install.packages('BiocManager')"
RUN R -e "BiocManager::install(c('Rsamtools'))"
RUN R -e "install.packages('./spp_1.14.tar.gz')"

# HTS
# RUN apt update && apt install -y --no-install-recommends git make gcc zlib1g-dev libbz2-dev liblzma-dev libcurl4-openssl-dev
# RUN git clone https://github.com/samtools/htslib
# WORKDIR /htslib
# RUN make && make test

# Samtools
RUN apt update && apt install -y --no-install-recommends \
    git make wget gcc zlib1g-dev libncurses-dev libbz2-dev liblzma-dev libcurl4-openssl-dev
RUN wget https://github.com/samtools/samtools/releases/download/1.10/samtools-1.10.tar.bz2
RUN tar xf samtools-1.10.tar.bz2
WORKDIR samtools-1.10
RUN make && make test
# RUN apt update && apt install -y --no-install-recommends zlib1g-dev  liblzma libcurl4-openssl-dev make gcc 

RUN git clone https://github.com/kundajelab/phantompeakqualtools

	