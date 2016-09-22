# pt-log - local, secure log-to-Papertrail microservice

[![](https://imagelayers.io/badge/meonkeys/pt-log:latest.svg)](https://imagelayers.io/?images=meonkeys/pt-log:latest 'Get your own badge on imagelayers.io')

Logging to [Papertrail](https://papertrailapp.com/) usually requires a running [syslog](https://en.wikipedia.org/wiki/Syslog)-compatible server. pt-log provides a simpler interface to write a single message: one local file. Just start the container then append lines to the local file. Every line will be sent to Papertrail.

The `logger` command can also write directly to Papertrail's endpoints, but will not encrypt. pt-log encrypts messages before they are sent over the wire.

The (tiny) image is based on [Alpine 3.3](http://www.alpinelinux.org/).

Warning: this is intended for low-throughput dev usage. Multiple simultaneous writes to the logfile could result in lost log lines.

## Start the logger container

This starts the pt-log container and uses variables in the current shell to name the "system" (host) and "program" (logfile) in Papertrail. Docker will keep it running.

```bash
touch ~/.pt-log
docker run \
  --detach=true \
  --name pt-log \
  --env="EXT_USER=$(id -ng $USER)" \
  --env="EXT_HOST=$HOSTNAME" \
  --env="PT_DEST=logs.papertrailapp.com" \
  --env="PT_PORT=514" \
  --restart=always \
  --volume="$HOME/.pt-log:/pt-log/$(id -ng $USER)" \
  meonkeys/pt-log
```

## Log a message to Papertrail

```bash
echo "$(date) hey there - test" >> ~/.pt-log
```

## How to debug the container

```bash
touch ~/.pt-log
docker run \
  --rm \
  -it \
  --name pt-log \
  --env="EXT_USER=$(id -ng $USER)" \
  --env="EXT_HOST=$HOSTNAME" \
  --env="PT_DEST=logs.papertrailapp.com" \
  --env="PT_PORT=514" \
  --volume="$HOME/.pt-log:/$(id -ng $USER)" \
  meonkeys/pt-log \
  /bin/sh
```

# Copyright and License

Copyright (C)2016 Adam Monsen.

License: AGPL v3. See COPYING for details.
