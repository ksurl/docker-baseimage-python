# Docker python:alpine base image

[![](https://img.shields.io/badge/Docker%20Hub--blue)](https://hub.docker.com/r/ksurl/baseimage-python-alpine) [![](https://img.shields.io/badge/GitHub%20Container%20Registry--yellow)](https://github.com/users/ksurl/packages/container/package/baseimage-python-alpine)

[![](https://img.shields.io/github/v/tag/ksurl/docker-baseimage-python-alpine?label=image%20version&logo=docker)](https://hub.docker.com/r/ksurl/baseimage-python-alpine) [![](https://img.shields.io/docker/image-size/ksurl/baseimage-python-alpine/latest?color=lightgrey&logo=Docker)]() [![](https://img.shields.io/github/actions/workflow/status/ksurl/docker-baseimage-python-alpine/build.yml?label=build&logo=Docker)](https://github.com/ksurl/docker-baseimage-python-alpine/actions/workflow/build.yml?query=workflow%3Abuild)

* Based on python:3.11-alpine3.17
* bash
* s6-overlay

# Usage

## Dockerfile
`FROM ghcr.io/ksurl/baseimage-python-alpine`
## Config scripts
update root/etc/cont-init.d/30-config with any additional settings you may need to prepare before starting any services.

e.g. checking for config file, setting permissions, application version checking, package installs
## Create service
1. Create folder in root/etc/services.d
2. create `run` file and replace `tail` with your own command:
```
#!/usr/bin/with-contenv bash

exec s6-setuidgid abc /usr/bin/tail -f /dev/null
```

### Optional
Create `finish` file in the same folder as `run` for clean shutdown and replace pkill with your own command:
```
#!/usr/bin/with-contenv bash

exec s6-setuidgid abc /usr/bin/pkill tail
```
## Parameters
| Parameter | Function | Default |
| :----: | --- | --- |
| `-e PUID` | Set uid | `911` |
| `-e PGID` | Set gid | `911` |
| `-e TZ` | Specify a timezone to use | `UTC` |
