#!/bin/bash

docker buildx build \
  --platform linux/amd64,linux/arm64 \
  -t ghcr.io/dcaneteacc/hello-environment:1.1 --push .