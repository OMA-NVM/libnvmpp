#!/bin/bash
docker build --build-arg UID=$(id -u) --build-arg UNAME=$(id -u -n) --build-arg GID=$(id -g) -t uk_build_cont .
docker run --privileged -v ${PWD}/.:/uk -it uk_build_cont bash
