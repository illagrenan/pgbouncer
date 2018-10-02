# Build this image: docker build -f .\Dockerfile -t illagrenan/pgbouncer .
FROM alpine:latest AS build_stage

ARG PYTHONUNBUFFERED=1
ARG PGBOUNCER_VERSION=pgbouncer_1_9_0

WORKDIR /
RUN apk add --purge --no-cache --update \
      git \
      python \
      py-pip \
      build-base \
      automake \
      libtool \
      m4 \
      autoconf \
      libevent-dev \
      openssl-dev \
      c-ares-dev

RUN pip install --isolated --no-input --compile --exists-action=a --disable-pip-version-check --no-cache-dir --upgrade \
    docutils \
    && ln -s /usr/bin/rst2man.py /bin/rst2man \
    && rst2man --version

RUN git clone https://github.com/pgbouncer/pgbouncer.git \
    && cd ./pgbouncer/ \
    && git submodule init \
    && git submodule update \
    && git fetch \
    && git fetch --tags \
    && git checkout ${PGBOUNCER_VERSION}
WORKDIR /pgbouncer
RUN mkdir /pgbouncer-bin

RUN ./autogen.sh
RUN	./configure --prefix=/pgbouncer-bin --with-libevent=/usr/lib
RUN make
RUN make install
RUN ls -R /pgbouncer-bin

FROM alpine:latest

RUN apk add --purge --no-cache --update \
      libevent \
      openssl \
      c-ares

WORKDIR /
COPY --from=build_stage /pgbouncer-bin /pgbouncer
ADD entrypoint.sh ./

ENTRYPOINT ["./entrypoint.sh"]
