FROM alpine:3.5

MAINTAINER Hoa Duong <duongxuanhoa@gmail.com>

RUN apk add --update --no-cache g++ make python tmux curl nodejs bash git \
 && git clone -b master --single-branch git://github.com/c9/core.git /opt/cloud9 \
 && curl -s -L https://raw.githubusercontent.com/c9/install/master/link.sh | bash \
 && /opt/cloud9/scripts/install-sdk.sh \
 && apk del g++ make \
 && rm -rf /var/cache/apk/* /opt/cloud9/.git /tmp/* \
 && npm cache clean

RUN mkdir /workspace

VOLUME /workspace

WORKDIR /workspace

EXPOSE 8000

ENV USERNAME username

ENV PASSWORD password

ENTRYPOINT ["sh", "-c", "/usr/bin/node /opt/cloud9/server.js -l 0.0.0.0 -p 8000 -w /workspace -a $USERNAME:$PASSWORD"]
