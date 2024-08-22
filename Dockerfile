# Builder
FROM alpine:latest as builder
LABEL Maintainer="lans.rf@gmail.com"

RUN apk add git cmake build-base gperf linux-headers zlib-dev openssl-dev
   
RUN mkdir -p /telegram-bot-api/build && \
    mkdir -p /telegram-bot-api/install && \
    git clone --recursive https://github.com/tdlib/telegram-bot-api.git /telegram-bot-api/src 

 RUN cd /telegram-bot-api/build && \
     cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/telegram-bot-api/install /telegram-bot-api/src && \
     cmake --build . --target install -j`nproc`

# Main image
FROM alpine:latest
LABEL Maintainer="lans.rf@gmail.com"

ENV API_ID=some_env_id \
    API_HASH=some_api_hash \
    HTTP_PORT=8081
    
RUN apk add zlib openssl gperf && \
    mkdir -p /telegram-bot-api/files /telegram-bot-api/temp
COPY --from=builder /telegram-bot-api/install/bin/telegram-bot-api /telegram-bot-api/
COPY entrypoint.sh /telegram-bot-api/entrypoint.sh
EXPOSE 8081

ENTRYPOINT [ "sh", "/telegram-bot-api/entrypoint.sh" ]
