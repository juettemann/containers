FROM alpine:3.13 AS builder
RUN apk update && \
    apk upgrade

RUN apk add git ca-certificates
RUN git clone --depth 1 https://github.com/lh3/bwa.git
RUN apk add make gcc libc-dev zlib-dev
    #apk add curl libarchive-tools gcc g++ make libc-dev zlib-dev git ca-certificates
WORKDIR /bwa
RUN make

FROM alpine:3.13
COPY --from=builder /bwa/bwa /usr/local/bin
WORKDIR /mnt
ENTRYPOINT ["bwa"]
CMD []
