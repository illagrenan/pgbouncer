# pgbouncer Docker Image :elephant:+:whale:=:heart_eyes:  #

[![Docker Stars](https://img.shields.io/docker/automated/illagrenan/pgbouncer.svg?style=flat-square)](https://hub.docker.com/r/illagrenan/pgbouncer/)
[![Docker Stars](https://img.shields.io/docker/build/illagrenan/pgbouncer.svg?style=flat-square)](https://hub.docker.com/r/illagrenan/pgbouncer/)

**pgbouncer** is a popular, small connection pooler for Postgresql. This is yet another docker image with pgbouncer, based on alpine.

## Run this Image ##


```bash
docker run -d \ 
       --name=pgbouncer \
       -e DB_HOST=postgresql.example.com \
       -e DB_USER=admin \
       -e DB_PASSWORD=mypassword \
       illagrenan/pgbouncer:latest
```

## Links ##

* pgbouncer homepage: https://pgbouncer.github.io/
* Docker Hub: https://hub.docker.com/r/illagrenan/pgbouncer/
* Original repo: https://github.com/brainsam/pgbouncer
