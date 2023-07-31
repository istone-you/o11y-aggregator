FROM alpine:latest

COPY config.yml /etc/yace/config.yml
COPY yace /yace

EXPOSE 5000

ENTRYPOINT ["/yace", "--config.file", "/etc/yace/config.yml"]

