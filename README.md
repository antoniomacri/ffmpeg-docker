# ffmpeg

This is a ffmpeg docker image with vmaf support.


## Building

Use the script `./build.sh` to build locally or run:
```shell
docker build . -t ffmpeg-vmaf --progress=plain 
```

## Running

Suppose you have re-encoded a video with lower quality in order to reduce disk occupation. Use the following command (or see `./run.sh`) to estimate the VMAF:
```shell
docker run --rm -v "$(pwd):/v" ffmpeg-vmaf -i "/v/original.mp4" -i "/v/reencoded.mp4" -lavfi libvmaf='log_fmt=json:log_path=/v/output.json' -f null -
```
