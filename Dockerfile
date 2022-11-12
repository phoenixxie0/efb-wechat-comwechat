FROM python:3.8.13-alpine3.14
MAINTAINER Phoenix <hkxseven007@gmail.com>

ENV LANG C.UTF-8
ENV TZ 'Asia/Shanghai'

RUN set -ex \
        && apk add --no-cache --virtual .build-deps sed build-base libffi-dev openssl-dev git \
        && apk add --no-cache tzdata ca-certificates ffmpeg libmagic openjpeg zlib-dev libwebp cairo \
        && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
        && echo "Asia/Shanghai" > /etc/timezone

RUN set -ex \
        && pip3 install lottie \
        && pip3 install cairosvg \
        && pip3 install git+https://github.com/ehForwarderBot/ehForwarderBot \
        && pip3 install git+https://github.com/ehForwarderBot/efb-telegram-master \
        && pip3 install git+https://github.com/0honus0/python-comwechatrobot-http \
        && pip3 install git+https://github.com/0honus0/efb-wechat-comwechat-slave \
        && sed -i 's/channel_emoji: str = "💻"/channel_emoji: str = "𝙒𝙚𝙘𝙝𝙖𝙩"/g' /usr/local/lib/python3.*/site-packages/efb_wechat_comwechat_slave/ComWechat.py \
        && pip3 install git+https://github.com/ehForwarderBot/efb-link_preview-middleware \
        && pip3 install git+https://github.com/ahxxm/efb-filter-middleware \
        && pip3 install python-telegram-bot[socks] \
        && apk del .build-deps \
        && rm -rf ~/.cache 
        
CMD ["ehforwarderbot","-v"]
