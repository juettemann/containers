FROM ubuntu:20.04 as builder

ENV PATH "/root/perl5/perlbrew/bin:$PATH"
ENV PERL5LIB "$PERL5LIB:/ensembl-funcgen/modules:/ensembl/modules:/ensembl-hive/modules"    
WORKDIR /

RUN mkdir -p  /root/perl5/perlbrew/dists/ \
    && apt-get update && apt-get upgrade -y \
    && apt-get install -y build-essential perlbrew libmysqlclient-dev git\
    && mkdir -p  /root/perl5/perlbrew/dists/ \
    && perlbrew install --notest perl-5.26.0 \
    && perlbrew switch perl-5.26.0 \
    # && perlbrew install-cpanm \
    # && cpanm DBI DBD::mysql \
    # && git clone --branch release/101 --depth 1 https://github.com/Ensembl/ensembl.git  \
    # && git clone --branch release/101 --depth 1 https://github.com/Ensembl/ensembl-funcgen.git  \
    # && git clone --branch version/2.4 --depth 1 https://github.com/Ensembl/ensembl-hive.git
ENTRYPOINT [ "perl", "/ensembl-funcgen/scripts/regulatory_build/new_build_regulatory_features.pl" ]
CMD [""]
