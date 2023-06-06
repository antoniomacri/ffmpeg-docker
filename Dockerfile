FROM alpine:3.18

ARG BUILD_DATE
ARG VCS_REF

CMD         ["--help"]
ENTRYPOINT  ["ffmpeg"]
WORKDIR     /tmp/ffmpeg

ENV SOFTWARE_VERSION="5.1"
ENV SOFTWARE_VERSION_URL="http://ffmpeg.org/releases/ffmpeg-${SOFTWARE_VERSION}.tar.bz2"
ENV BIN="/usr/bin"

RUN cd \
 && apk update \
 && apk upgrade \
 && apk add --no-cache --virtual .build-dependencies \
  build-base \
  bzip2 \
  coreutils \
  gnutls \
  nasm \
  tar \
  git \
  xxd \
  py3-pip \
  python3-dev \
  libvpx-dev \
  libwebp-dev \
  libssh2 \
  opus-dev \
  rtmpdump-dev \
  x264-dev \
  x265-dev \
  yasm-dev \
  freetype-dev \
  gnutls-dev \
  lame-dev \
  libass-dev \
  libogg-dev \
  libtheora-dev \
  libvorbis-dev \
  frei0r-plugins-dev \
  ladspa-dev \
  aom-dev \
  lilv-dev \
  # libavc1394 \
  # libavc1394-dev \
  # libiec61883 \
  # libiec61883-dev
  libbluray-dev \
  libbs2b-dev \
  libcaca-dev \
  # libcodec2-dev \
  libdc1394-dev \
  libdrm-dev \
  # flite \
  # libgme-dev
  gsm-dev \
  openjpeg-dev \
  libopenmpt-dev \
  pulseaudio-dev \
  librsvg-dev \
  rubberband-dev \
  snappy-dev \
  soxr-dev \
  libssh-dev \
  speex-dev \
  vidstab-dev \
  wavpack-dev \
  xvidcore-dev \
  zeromq-dev \
  libxml2-dev \
  openal-soft-dev \
  opencl-dev \
  mesa-dev \
  # omxplayer
  libcdio-paranoia-dev

RUN DIR=$(mktemp -d) \
 && cd ${DIR} \
 && git clone https://github.com/Netflix/vmaf.git \
 && cd vmaf \
 && git checkout v2.3.1 \
 && pip3 install meson Cython numpy ninja \
 && make \
 && make install \
 && rm -rf ${DIR}

RUN DIR=$(mktemp -d) \
 && cd ${DIR} \
 && wget "${SOFTWARE_VERSION_URL}" \
 && tar xjvf "ffmpeg-${SOFTWARE_VERSION}.tar.bz2" \
 && cd ffmpeg* \
 && PATH="$BIN:$PATH" \
 && ./configure --help \
 && ./configure --bindir="$BIN" \
  # Licensing options:
  --enable-gpl \
  --enable-nonfree \
  --enable-version3 \
  # Configuration options:
  --enable-shared \
  # Program options:
  --disable-ffplay \
  # Documentation options:
  --disable-doc \
  # Component options:
  --enable-postproc \
  # Individual component options:
  --disable-filter=resample \
  # External library support:
  # --enable-avisynth \
  # --enable-chromaprint \
  --enable-frei0r \
  --enable-gnutls \
  --enable-ladspa \
  --enable-libaom \
  --enable-libass \
  --enable-libbluray \
  --enable-libbs2b \
  --enable-libcaca \
  --enable-libcdio \
  # --enable-libcodec2 \
  --enable-libdc1394 \
  # --enable-libflite \
  --enable-libfontconfig \
  --enable-libfreetype \
  --enable-libfribidi \
  # --enable-libgme \
  --enable-libgsm \
  # --enable-libiec61883 \
  --enable-libjack \
  --enable-libmp3lame \
  --enable-libopenjpeg \
  --enable-libopenmpt \
  --enable-libopus \
  --enable-libpulse \
  --enable-librsvg \
  --enable-librubberband \
  --enable-librtmp \
  # --enable-libshine \
  --enable-libsnappy \
  --enable-libsoxr \
  --enable-libspeex \
  --enable-libssh \
  --enable-libtheora \
  # --enable-libtwolame \
  --enable-libvidstab \
  --enable-libvmaf \
  --enable-libvorbis \
  --enable-libvpx \
  --enable-libwebp \
  --enable-libx264 \
  --enable-libx265 \
  --enable-libxvid \
  --enable-libxml2 \
  --enable-libzmq \
  # --enable-libzvbi \
  --enable-lv2 \
  # --enable-libmysofa \
  --enable-openal \
  --enable-opencl \
  --enable-opengl \
  # --enable-sdl2 \
  # The following libraries provide various hardware acceleration features:
  --enable-libdrm \
  # --enable-omx \
  # Developer options (useful when working on FFmpeg itself):
  --disable-debug \
  --disable-stripping \
 && make -j4 \
 && make install \
 && make distclean \
 && rm -rf ${DIR}

RUN cd \
 && apk del --purge .build-dependencies \
 && rm -rf /var/cache/apk/*

RUN cd \
 && apk update \
 && apk upgrade \
 && apk add \
  freetype \
  librtmp \
  lame-libs \
  libass \
  libtheora \
  libvpx \
  x264-libs \
  x265-libs \
  aom-libs \
  lilv \
  libbluray \
  libbs2b \
  libcaca \
  libdc1394 \
  libdrm \
  gsm \
  openjpeg \
  libopenmpt \
  libpulse \
  jack \
  librsvg \
  rubberband-libs \
  snappy \
  soxr \
  libssh \
  speex \
  vidstab \
  # wavpack-dev \
  xvidcore \
  zeromq \
  # libxml2-dev \
  openal-soft-libs \
  opencl \
  mesa-gl \
  libcdio-paranoia
