#!/usr/bin/env bash

ORIGINAL=${1?Specify original file}
MODIFIED=${2?Specify modified file}
JSON_OUTPUT=${MODIFIED}.json

docker run --rm -v "$(pwd):/v" ffmpeg-vmaf -i "/v/$ORIGINAL" -i "/v/$MODIFIED" -lavfi libvmaf="log_fmt=json:log_path=/v/$JSON_OUTPUT" -f null -
