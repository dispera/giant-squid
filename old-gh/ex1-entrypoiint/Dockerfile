# Let's suppose I don't trust the security of the build of  uphold/docker-litecoin-core image,
# but I would instead leverage their dockerfile, adapt, and build the image myself from the
# litecoin.org binaries.
# The verification of those source checksums was already added.

# Pinning the exact version
# FROM debian:stable-slim@sha256:14a2ae54e3086a3699b7b03fdad3106428a18508ce1a51ff39402a988ccd5894
FROM ubuntu:latest

RUN useradd -r litecoin \
  && apt-get update -y \
  && apt-get install -y curl gnupg \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && set -ex \
  && for key in \
  B42F6819007F00F88E364FD4036A9C25BF357DD4 \
  FE3348877809386C \
  ; do \
  gpg --no-tty --keyserver pgp.mit.edu --recv-keys "$key" || \
  gpg --no-tty --keyserver keyserver.pgp.com --recv-keys "$key" || \
  gpg --no-tty --keyserver ha.pool.sks-keyservers.net --recv-keys "$key" || \
  gpg --no-tty --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys "$key" ; \
  done

ENV GOSU_VERSION=1.10

RUN curl -o /usr/local/bin/gosu -fSL https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-$(dpkg --print-architecture) \
  && curl -o /usr/local/bin/gosu.asc -fSL https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-$(dpkg --print-architecture).asc \
  && gpg --verify /usr/local/bin/gosu.asc \
  && rm /usr/local/bin/gosu.asc \
  && chmod +x /usr/local/bin/gosu

ENV LITECOIN_VERSION=0.18.1
ENV LITECOIN_DATA=/home/litecoin/.litecoin

RUN curl -SLO https://download.litecoin.org/litecoin-${LITECOIN_VERSION}/linux/litecoin-${LITECOIN_VERSION}-x86_64-linux-gnu.tar.gz \
  && curl -SLO https://download.litecoin.org/litecoin-${LITECOIN_VERSION}/linux/litecoin-${LITECOIN_VERSION}-linux-signatures.asc \
  && gpg --verify litecoin-${LITECOIN_VERSION}-linux-signatures.asc \
  && grep $(sha256sum litecoin-${LITECOIN_VERSION}-x86_64-linux-gnu.tar.gz | awk '{ print $1 }') litecoin-${LITECOIN_VERSION}-linux-signatures.asc \
  && tar --strip=2 -xzf *.tar.gz -C /usr/local/bin \
  && rm *.tar.gz

COPY docker-entrypoint.sh /entrypoint.sh

VOLUME ["/home/litecoin/.litecoin"]

EXPOSE 9332 9333 19332 19333 19444

# USER litecoin:litecoin

ENTRYPOINT ["/entrypoint.sh"]

CMD ["litecoind"]