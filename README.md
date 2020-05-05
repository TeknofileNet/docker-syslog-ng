# docker-syslog-ng

docker-syslog-ng is an implementation of [syslog-ng](https://www.syslog-ng.com/) inside of a docker container. This container is based off of s6-overlay and uses much of the same structure as the folks at [linuxserver.io](https://github.com/linuxserver). This image, however, is developed on my own works and not their work.

This container, when started stores it's data and state in /config.

`/config/conf/syslog-ng.conf` contains the master syslog-ng configuration.
`/config/logs/` contains log data.

# Running the container

Environment Variables:
| Environment Variable Name |Description  |
|--|--|
|PUID | The UID of the user running in the container that will be mapped to id 0 inside of the container  |
|GUID | The GID of the user running in the container that will be mapped to gid 0 inside of the container |
|TZ| The timezone (i.e. `America/Denver`)|
|-|-|

Running the container:

```
#!/usr/bin/env bash

DCKR_PROXY=""
DCKR_SOURCE="wtfo/docker-syslog-ng:latest"
DCKR_NAME="tkf-syslog"
DCKR_TZ="America/Denver"
DCKR_NETWORK="tkf-services"

docker pull ${DCKR_SOURCE}
docker stop ${DCKR_NAME}
docker rm ${DCKR_NAME}

docker create \
        --name=${DCKR_NAME} \
        --network=${DCKR_NETWORK} \
        -e PUID="$(id -u)" \
        -e PGID="$(id -g)" \
        -e TZ="${DCKR_TZ}" \
        -p 514:514/tcp \
        -v /opt/docker/${DCKR_NAME}:/config \
        --restart unless-stopped \
        ${DCKR_SOURCE}

docker start ${DCKR_NAME}
```

## Upgrades
Upgrades should be as simple as downloading the new image via docker pull, then delete the and recreate the running container. All configuration and data should persist within /config, provided that you have mapped it to a volume.

## Support
If you need help, open up an [issue on GitHub](https://github.com/TeknofileNet/docker-syslog-ng).

