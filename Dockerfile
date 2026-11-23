FROM alpine:3.20

RUN apk add --no-cache ca-certificates curl unzip \
    && curl -L -o /tmp/xray.zip https://github.com/XTLS/Xray-core/releases/download/v26.11.9/Xray-linux-64.zip \
    && mkdir -p /usr/local/xray \
    && unzip /tmp/xray.zip -d /usr/local/xray \
    && chmod +x /usr/local/xray/xray \
    && rm /tmp/xray.zip

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 8080
CMD ["/entrypoint.sh"]
