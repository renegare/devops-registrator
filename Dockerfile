FROM gliderlabs/registrator:v7

RUN apk-install -t curl

ADD entry.sh /tmp/entry.sh
RUN chmod +x /tmp/entry.sh

ENTRYPOINT ["/tmp/entry.sh"]
