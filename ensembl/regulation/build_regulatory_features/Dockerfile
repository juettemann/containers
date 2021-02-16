
FROM alpine:3.12 AS production
COPY --from=juettemann/perl:5.26.0 /opt/perl/ /opt/perl/

RUN apk add git
RUN    git clone --branch release/101 --depth 1 https://github.com/Ensembl/ensembl.git  \
    && git clone --branch release/101 --depth 1 https://github.com/Ensembl/ensembl-funcgen.git  \
    && git clone --branch version/2.4 --depth 1 https://github.com/Ensembl/ensembl-hive.git
RUN apk del git
ENV PATH "/opt/perl/bin:$PATH"  
ENV PERL5LIB "$PERL5LIB:/ensembl-funcgen/modules:/ensembl/modules:/ensembl-hive/modules"
ENTRYPOINT [ "perl", "/ensembl-funcgen/scripts/regulatory_build/new_build_regulatory_features.pl" ]
CMD [""]