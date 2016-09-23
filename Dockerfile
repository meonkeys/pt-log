FROM alpine:3.4

RUN \
  apk update && \
  apk upgrade && \
  apk add ca-certificates openssl && \
  wget https://github.com/papertrail/remote_syslog2/releases/download/v0.18/remote_syslog_linux_amd64.tar.gz && \
  echo "b2477981098bccb1f0b8b17910778c89b9688881  remote_syslog_linux_amd64.tar.gz" > SHA1SUM && \
  sha1sum -c SHA1SUM && \
  tar -xvzf remote_syslog_linux_amd64.tar.gz && \
  rm SHA1SUM remote_syslog_linux_amd64.tar.gz && \
  rm -rf /var/cache/apk/*

COPY watchlogs /

CMD [ "/watchlogs" ]
