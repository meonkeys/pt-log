FROM alpine:3.4

RUN \
  apk update && \
  apk add ca-certificates openssl && \
  wget https://github.com/papertrail/remote_syslog2/releases/download/v0.17/remote_syslog_linux_amd64.tar.gz && \
  echo "82f9863a2223fab901cac09bec1be1c08de8d16a  remote_syslog_linux_amd64.tar.gz" > SHA1SUM && \
  sha1sum -c SHA1SUM && \
  tar -xvzf remote_syslog_linux_amd64.tar.gz && \
  rm SHA1SUM remote_syslog_linux_amd64.tar.gz && \
  rm -rf /var/cache/apk/*

COPY watchlogs /

CMD [ "/watchlogs" ]
