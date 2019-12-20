FROM alpine:3.11

MAINTAINER Hoa Duong <duongxuanhoa@gmail.com>

RUN apk add --update --no-cache g++ make python tmux curl bash openssh-client git py-pip python-dev --repository http://dl-cdn.alpinelinux.org/alpine/v3.7/main/ nodejs=8.9.3-r1 \
 && rm -rf /var/cache/apk/*

RUN git clone -b master --single-branch https://github.com/c9/core.git /root/.c9 && cd /root/.c9 \
 && mkdir -p ./node/bin ./bin ./node_modules \		
 && ln -sf "`which tmux`" ./bin/tmux \		
 && ln -s "`which node`" ./node/bin/node \		
 && ln -s "`which npm`" ./node/bin/npm \
 && npm i pty.js \
 && npm i sqlite3@3.1.8 sequelize@2.0.0-beta.0 \
 && npm i https://github.com/c9/nak/tarball/c9 \
 && echo 1 > ./installed \
 && NO_PULL=1 ./scripts/install-sdk.sh \
 && git reset --hard && rm -rf /root/.c9/.git /var/cache/apk/* /tmp/* /var/tmp/* \
 && npm cache clean --force

RUN pip install -U pip \
 && pip install -U virtualenv \
 && virtualenv --python=python2 $HOME/.c9/python2 \
 && source $HOME/.c9/python2/bin/activate \
 && mkdir /tmp/codeintel \
 && pip download codeintel==2.0.0 -d /tmp/codeintel \
 && cd /tmp/codeintel \
 && tar xf CodeIntel-2.0.0.tar.gz \
 && tar czf CodeIntel-2.0.0.tar.gz CodeIntel-2.0.0 \
 && pip install -U --no-index --find-links=/tmp/codeintel codeintel \
 && rm -rf /tmp/codeintel/*.gz /tmp/codeintel/*.whl

RUN mkdir /workspace
VOLUME /workspace
WORKDIR /workspace

ENV USERNAME ""
ENV PASSWORD ""

EXPOSE 8000

ENTRYPOINT ["sh", "-c", "/usr/bin/node /root/.c9/server.js -l 0.0.0.0 -p 8000 -w /workspace -a $USERNAME:$PASSWORD"]