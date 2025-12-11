#!/bin/bash

docker buildx build \
  --platform linux/amd64,linux/arm64 \
  -t ghcr.io/dcaneteacc/hello-web:1.3 --push .