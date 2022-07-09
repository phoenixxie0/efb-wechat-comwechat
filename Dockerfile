FROM python:3.8.13-alpine3.14
MAINTAINER Phoenix <hkxseven007@gmail.com>

ENV LANG C.UTF-8
ENV TZ 'Asia/Shanghai'

RUN set -ex \
        && apk add --no-cache --virtual .build-deps sed build-base libffi-dev openssl-dev git \
        && apk add --no-cache tzdata ca-certificates ffmpeg libmagic openjpeg zlib-dev libwebp \
        && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
        && echo "Asia/Shanghai" > /etc/timezone

RUN set -ex \
        && pip3 install --upgrade setuptools \
        && pip3 install git+https://github.com/ehForwarderBot/ehForwarderBot \
        && pip3 install git+https://github.com/ehForwarderBot/efb-telegram-master \
        && pip3 install git+https://github.com/0honus0/python-CuteCat-iHttp.git@1.1.9.12 \
        && pip3 install git+https://github.com/0honus0/efb-wechat-cutecat-slave.git@1.1.9.12 \
        && pip3 install git+https://github.com/ehForwarderBot/efb-link_preview-middleware \
        && pip3 install python-telegram-bot[socks] \
        && apk del .build-deps \
        && rm -rf ~/.cache 
        
CMD ["ehforwarderbot -v"]
