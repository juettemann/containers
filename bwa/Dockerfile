FROM alpine:3.12 AS builder
RUN apk update
RUN apk upgrade
RUN apk add curl libarchive-tools gcc make libc-dev zlib-dev
RUN curl -OL https://downloads.sourceforge.net/project/bio-bwa/bwa-0.7.17.tar.bz2
RUN bsdtar xf bwa-0.7.17.tar.bz2
WORKDIR /bwa-0.7.17
RUN make

FROM alpine:3.12
COPY --from=builder /bwa-0.7.17/bwa /usr/local/bin
WORKDIR /mnt
ENTRYPOINT ["bwa"]
CMD []
