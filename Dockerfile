FROM python:3.10-alpine
MAINTAINER Phoenix <hkxseven007@gmail.com>

ENV LANG C.UTF-8
ENV TZ 'Asia/Shanghai'

RUN set -ex \
        && apk add --no-cache --virtual .build-deps sed build-base libffi-dev openssl-dev git \
        && apk add --no-cache tzdata ca-certificates ffmpeg libmagic openjpeg zlib-dev libwebp cairo zbar \
        && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
        && echo "Asia/Shanghai" > /etc/timezone \
        && pip3 install lottie pyqrcode rich pyzbar \
        && pip3 install cairosvg \
        ## && pip3 install urllib3==1.26.15 \
        && pip3 install git+https://github.com/ehForwarderBot/ehForwarderBot \
        && pip3 install git+https://github.com/ehForwarderBot/efb-telegram-master \
        && pip3 install git+https://github.com/0honus0/python-comwechatrobot-http \
        ##&& pip3 install git+https://github.com/0honus0/efb-wechat-comwechat-slave.git@7bc64ef9d954b3e8ae289f16fd52213742a29acf \
        && pip3 install git+https://github.com/0honus0/efb-wechat-comwechat-slave.git \
        && sed -i 's/💻/𝙒𝙚𝙘𝙝𝙖𝙩/g' /usr/local/lib/python3.*/site-packages/efb_wechat_comwechat_slave/ComWechat.py \
        && sed -i '9i # new code' /usr/local/lib/python3.10/site-packages/pyzbar/zbar_library.py \
        && sed -i '10i original_find_library = find_library' /usr/local/lib/python3.10/site-packages/pyzbar/zbar_library.py \
        && sed -i '11i ' /usr/local/lib/python3.10/site-packages/pyzbar/zbar_library.py \
        && sed -i '12i # Create replacement function that returns your library path' /usr/local/lib/python3.10/site-packages/pyzbar/zbar_library.py \
        && sed -i '13i def find_library(name):' /usr/local/lib/python3.10/site-packages/pyzbar/zbar_library.py \
        && sed -i '14i \ \ \ \ if name == '"'"'zbar'"'"':' /usr/local/lib/python3.10/site-packages/pyzbar/zbar_library.py \
        && sed -i '15i \ \ \ \ \ \ \ \ return '"'"'/usr/lib/libzbar.so.0'"'"'' /usr/local/lib/python3.10/site-packages/pyzbar/zbar_library.py \
        && sed -i '16i \ \ \ \ return original_find_library(name)  # Fall back to original for other libs' /usr/local/lib/python3.10/site-packages/pyzbar/zbar_library.py \
        ## && pip3 install git+https://github.com/ehForwarderBot/efb-link_preview-middleware \
        && pip3 install git+https://github.com/phoenixxie0/efb-filter-middleware \
        && pip3 install git+https://github.com/QQ-War/efb_message_merge \
        && pip3 install git+https://github.com/QQ-War/efb-keyword-reply.git \
        && pip3 install python-telegram-bot[socks] \
        ## && pip3 install pydantic==1.10.13 \
        && apk del .build-deps \
        && rm -rf ~/.cache 
        
CMD ["ehforwarderbot"]
