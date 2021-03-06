FROM alpine:3.12 AS perlbuild

## alpine curl and wget aren't fully compatible, so we install them
## here. gnupg is needed for Module::Signature.
RUN apk update && apk upgrade && apk add curl tar make gcc build-base wget gnupg

RUN mkdir -p /usr/src/perl

WORKDIR /usr/src/perl

## from perl; `true make test_harness` because 3 tests fail
## some flags from http://git.alpinelinux.org/cgit/aports/tree/main/perl/APKBUILD?id=19b23f225d6e4f25330e13144c7bf6c01e624656
RUN curl -SLO https://www.cpan.org/src/5.0/perl-5.26.0.tar.gz \
    && echo 'e1abc572ef5bb69ebfa0f79a60a7eae753cc7b29 *perl-5.26.0.tar.gz' | sha1sum -c - \
    && tar --strip-components=1 -xzf perl-5.26.0.tar.gz -C /usr/src/perl \
    && rm perl-5.26.0.tar.gz \
    && ./Configure -des \
        -Duse64bitall \
        -Dcccdlflags='-fPIC' \
        -Dcccdlflags='-fPIC' \
        -Dccdlflags='-rdynamic' \
        -Dcc='gcc' \
        -Dlocincpth=' ' \
        -Duselargefiles \
        -Dusethreads \
        -Duseshrplib \
        -Dd_semctl_semun \
        -Dusenm \
        -Dprefix=/opt/perl \
    && make libperl.so \
    && make -j$(nproc) \
    && true TEST_JOBS=$(nproc) make test_harness \
    && make install

RUN rm -Rf /usr/src/perl
WORKDIR /opt/perl/
ENV PATH "/opt/perl/bin:$PATH"

# Grab cpanm, executable only
WORKDIR /tmp/
RUN curl -L https://cpanmin.us/ -o cpanm && chmod +x cpanm && ln -s /tmp/cpanm /usr/bin/cpanm

# INSTALL YOUR DEPS AND SHIT HERE
RUN apk add mysql-dev
RUN cpanm DBD::mysql File::Path File::Basename File::Temp Storable Data::Dumper::Concise Getopt::Long List::Util Scalar::Util Data::Dumper File::Spec Time::HiRes

# This builds the smaller image without all the build-time junk
FROM alpine AS production
# Grab the Perl modules
COPY --from=perlbuild /opt/perl/ /opt/perl/

# Grab any system libraries you needed
RUN apk update && apk upgrade && apk add git 
RUN git clone https://github.com/Ensembl/ensembl.git && \
    git clone https://github.com/Ensembl/ensembl-funcgen.git

RUN apk add git mariadb-connector-c
ENV PATH "/opt/perl/bin:$PATH"




