FROM alpine:latest as builder
LABEL Maintainer="lans.rf@gmail.com"

RUN apk add git cmake build-base gperf linux-headers zlib-dev openssl-dev
   
RUN mkdir -p /telegram-bot-api/build && \
    mkdir -p /telegram-bot-api/install && \
    git clone --recursive https://github.com/tdlib/telegram-bot-api.git /telegram-bot-api/src 

 RUN cd /telegram-bot-api/build && \
     cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/telegram-bot-api/install /telegram-bot-api/src && \
     cmake --build . --target install -j`nproc`

FROM alpine:latest
LABEL Maintainer="lans.rf@gmail.com"

RUN mkdir -p /telegram-bot-api/files /telegram-bot-api/temp

COPY --from=builder /telegram-bot-api/install/bin/telegram-bot-api /telegram-bot-api/

ENTRYPOINT [ "/telegram-bot-api/telegra-bot-api", \
             "--api-id", "$API_ID", \
             "--api-hash", "$API_HASH", \
             "--dir", "/telegram-bot-api/files", \
             "--temp-dir", "/telegram-bot-api/temp" ]
