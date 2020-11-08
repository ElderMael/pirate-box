#!/usr/bin/env bash

echo "Building Pirate Box Arm Image"

docker run \
  --rm --privileged \
  -v /dev:/dev \
  -v "${PWD}":/build \
  mkaczanowski/packer-builder-arm \
  build boards/raspberry-pi/raspbian.hcl
