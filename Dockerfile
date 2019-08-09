FROM alpine:3.9

ARG VERSION='v1.12.3'

RUN mkdir -m 777 /mytrojan
COPY config.json /mytrojan/
COPY server.crt /mytrojan/
COPY server.key /mytrojan/
RUN chgrp -R 0 /mytrojan \
 && chmod -R g+rwX /mytrojan 

RUN apk add --no-cache --virtual .build-deps \
        build-base \
        cmake \
        boost-dev \
        openssl-dev \
        mariadb-connector-c-dev \
        git \
    && git clone --branch=${VERSION} https://github.com/trojan-gfw/trojan.git \
    && (cd trojan && cmake . && make -j $(nproc) && strip -s trojan \
    && mv trojan /usr/local/bin) \
    && rm -rf trojan \
    && apk del .build-deps \
    && apk add --no-cache --virtual .trojan-rundeps \
        libstdc++ \
        boost-system \
        boost-program_options \
        mariadb-connector-c

WORKDIR /mytrojan
CMD ["trojan", "config.json"]
EXPOSE 8080
