FROM alpine:3.12 AS production
COPY --from=juettemann/perl:5.26.0 /opt/perl/ /opt/perl/
COPY ./test_farm.pl /
RUN apk add git
RUN    git clone --branch release/101 --depth 1 https://github.com/Ensembl/ensembl.git  \
    && git clone --branch release/101 --depth 1 https://github.com/Ensembl/ensembl-funcgen.git  
RUN apk del git
ENV PATH "/opt/perl/bin:$PATH"  
ENV PERL5LIB "$PERL5LIB:/ensembl-funcgen/modules:/ensembl/modules"
ENTRYPOINT [ "perl", "/test_farm.pl" ]
CMD ["--db", "--dnadb", "--directories /root,/homes/h,/gpfs/nobackup/ensembl/juettema/e103_regfeats"]
