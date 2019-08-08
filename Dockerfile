FROM alpine:3.9

ARG VERSION='v1.12.3'

RUN mkdir -m 777 /mytrojan
RUN apk add --no-cache --virtual .trojan-rundeps \
       libstdc++ \
       boost-system \
       boost-program_options \
       mariadb-connector-c

ADD trojan /mytrojan/trojan
ADD config.json /mytrojan/config.json
ADD server-cert.pem /mytrojan/server-cert.pem
ADD server-key.pem /mytrojan/server-key.pem
RUN chmod +x /mytrojan/trojan
    
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT  /entrypoint.sh 

EXPOSE 8080
