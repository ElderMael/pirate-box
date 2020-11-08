#!/usr/bin/env bash

echo "Building Pirate Box Arm Image"

docker run \
  --rm --privileged \
  -v /dev:/dev \
  -v "${PWD}":/build \
  packer-builder-arm:latest \
  build boards/raspberry-pi/raspberryos.pkr.hcl
