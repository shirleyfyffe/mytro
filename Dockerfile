FROM alpine:3.9

ARG VERSION='v1.12.3'

ENV PORT 8080

RUN mkdir -m 777 /mytrojan
COPY server-cert.pem /mytrojan/
COPY server-key.pem /mytrojan/
COPY config1.txt /mytrojan/
COPY config2.txt /mytrojan/
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
    && mv trojan /mytrojan) \
    && rm -rf trojan \
    && apk del .build-deps \
    && apk add --no-cache --virtual .trojan-rundeps \
        libstdc++ \
        boost-system \
        boost-program_options \
        mariadb-connector-c

ADD entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh 

CMD /entrypoint.sh 
