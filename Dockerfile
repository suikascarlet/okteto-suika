FROM library/alpine:latest

ENV VER=2.11.1

RUN apk add --no-cache --virtual .build-deps ca-certificates curl gzip \
    && mkdir -m 777 /gostbin \
    && cd /gostbin \
    && curl -L -H "Cache-Control: no-cache" -o gost.gz https://github.com/ginuerzh/gost/releases/download/v$VER/gost-linux-amd64-$VER.gz \
    && gzip -d gost.gz \
    && chmod +x /gostbin/gost \
    && chgrp -R 0 /gostbin \
    && chmod -R g+rwX /gostbin

COPY entry.sh /
RUN chmod a+x /entry.sh

EXPOSE 3128/tcp

ENTRYPOINT ["/entry.sh"]
