FROM alpine
RUN apk add --update iptables bash

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

CMD /entrypoint.sh

