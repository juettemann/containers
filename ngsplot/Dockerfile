FROM ubuntu:20.04 AS builder
#FROM r-base:4.0.3

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -qqy update --fix-missing && \
    apt-get -qqy full-upgrade && \
    apt-get -qqy install --no-install-recommends \
    build-essential \
    python-is-python2 \
    git \
    libxml2-dev \
    r-base \
    r-bioc-rhtslib \
    r-cran-rcurl \
    r-bioc-genomeinfodb \
    r-bioc-genomeinfodbdata  \
    r-bioc-genomicranges  \
    r-bioc-summarizedexperiment \
    r-bioc-rsamtools \
    r-bioc-genomicalignments \
    r-bioc-shortread && \
    apt-get autoremove --purge -y && apt-get autoclean -y && \
    rm -rf /var/cache/apt/* /var/lib/apt/lists/* /var/tmp/* /tmp/* /usr/share/man/?? /usr/share/man/??_*

RUN git clone --depth 1 https://github.com/shenlab-sinai/ngsplot.git

RUN R -e "install.packages('doMC',dependencies=TRUE, repos='http://cran.rstudio.com/')" && \
 R -e "install.packages('caTools',dependencies=TRUE, repos='http://cran.rstudio.com/')" && \
 R -e "install.packages('BiocManager')" && \
 R -e "BiocManager::install()" && \
 R -e "BiocManager::install('BSgenome')" && \
 R -e "BiocManager::install('Rsamtools')" && \
 R -e "BiocManager::install('ShortRead')"


FROM ubuntu:20.04

RUN mkdir -p /usr/lib/R \
             /usr/local/lib/R/site-library \
             /usr/local/bin//ngsplot
COPY --from=builder /usr/bin/R                     /usr/bin/R
COPY --from=builder /usr/bin/Rscript               /usr/bin/Rscript
COPY --from=builder /usr/lib/R                     /usr/lib/R
COPY --from=builder /usr/local/lib/R/site-library  /usr/local/lib/R/site-library
COPY --from=builder /etc/R/ldpaths                 /etc/R/ldpaths

COPY --from=builder /ngsplot/ /usr/local/bin/ngsplot

ENV PATH=/usr/local/bin/ngsplot/bin:${PATH}
ENV NGSPLOT=/usr/local/bin/ngsplot

RUN apt-get -qqy update --fix-missing && \
    apt-get -qqy full-upgrade && \
    apt-get -qqy install --no-install-recommends \
    r-base libr3-0 libblas3 libreadline8 libicu66 libgomp1 && \
    apt-get autoremove --purge -y && apt-get autoclean -y && \
    rm -rf /var/cache/apt/* /var/lib/apt/lists/* /var/tmp/* /tmp/* /usr/share/man/?? /usr/share/man/??_*

WORKDIR /mnt

