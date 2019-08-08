FROM alpine:3.9

ARG VERSION='v1.12.3'

RUN mkdir -m 777 /mytrojan
RUN apk add --no-cache --virtual .trojan-rundeps \
       libstdc++ \
       boost-system \
       boost-program_options \
       mariadb-connector-c

COPY trojan /mytrojan/
COPY config.json /mytrojan/
COPY server-cert.pem /mytrojan/
COPY server-key.pem /mytrojan/

RUN chmod +x /mytrojan/trojan \
 && chgrp -R 0 /mytrojan \
 && chmod -R g+rwX /mytrojan 
    
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# ENTRYPOINT  /entrypoint.sh 

EXPOSE 8080
