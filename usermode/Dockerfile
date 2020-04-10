FROM alpine:3.11

MAINTAINER Hoa Duong <duongxuanhoa@gmail.com>

RUN apk add --update --no-cache g++ make python tmux curl bash git --repository http://dl-cdn.alpinelinux.org/alpine/v3.7/main/ nodejs=8.9.3-r1 \
 && git clone -b master --single-branch https://github.com/c9/core.git /root/.c9 && cd /root/.c9 \
 && mkdir -p ./node/bin ./bin ./node_modules \		
 && ln -sf "`which tmux`" ./bin/tmux \		
 && ln -s "`which node`" ./node/bin/node \		
 && ln -s "`which npm`" ./node/bin/npm \
 && npm i pty.js \
 && npm i sqlite3@3.1.8 sequelize@2.0.0-beta.0 \
 && npm i https://github.com/c9/nak/tarball/c9 \
 && echo 1 > ./installed \
 && NO_PULL=1 ./scripts/install-sdk.sh \
 && apk del g++ make \
 && git reset --hard && rm -rf /root/.c9/.git /var/cache/apk/* /tmp/* /var/tmp/* \
 && npm cache clean --force
 
 
FROM alpine:3.11
ENV USERNAME ""
ENV PASSWORD ""
ENV USER "c9"
ENV USERID "5000"
ENV GROUP "c9"
ENV GROUPID "5000"
ENV SHELL /bin/bash

RUN addgroup -g $GROUPID $USER \
 && adduser -G $USER $GROUP -u $USERID -s /bin/sh -D $USER;
RUN chmod g+rw /home
RUN apk add --update --no-cache python tmux curl bash git --repository http://dl-cdn.alpinelinux.org/alpine/v3.7/main/ nodejs=8.9.3-r1 \
 && rm -rf /var/cache/apk/* /tmp/* /var/tmp/*
ENV HOME /home/$USER
WORKDIR /home/$USER
COPY --from=0 --chown=c9:c9 /root/.c9 /home/c9/.c9
 
RUN mkdir /workspace
VOLUME /workspace
WORKDIR /workspace
RUN chown -R $USER:$GROUP /workspace

EXPOSE 8000

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]
