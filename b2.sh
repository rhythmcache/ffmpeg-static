#!/bin/bash

set -e
export TOOLCHAIN_ROOT=""
ARCH="$1"

FFMPEG_VERSION="ffmpeg-7.1.1"


ZLIB_VERSION="zlib-1.3.1"
BROTLI_VERSION="1.1.0"
BZIP2_VERSION="bzip2-1.0.8"
OPENSSL_VERSION="openssl-3.5.1"
X264_VERSION="x264-master"
X265_VERSION="x265_4.1"
LIBVPX_VERSION="libvpx-1.15.0"
AAC_VERSION="fdk-aac-2.0.3"
LAME_VERSION="lame-3.100"
OPUS_VERSION="opus-1.5.2"
VORBIS_VERSION="libvorbis-1.3.7"
OGG_VERSION="libogg-1.3.6"
AOM_VERSION="libaom-3.12.1"
DAV1D_VERSION="dav1d-master"
LIBASS_VERSION="libass-0.17.4"
FREETYPE_VERSION=""
LIBPNG_VERSION="libpng-1.6.50"
FONTCONFIG_VERSION="fontconfig-2.16.0"
FRIBIDI_VERSION="fribidi-1.0.16"
BLURAY_VERSION="libbluray-master"
THEORA_VERSION="libtheora-1.2.0"
SPEEX_VERSION="speex-1.2.1"
OPENJPEG_VERSION=""
HARFBUZZ_VERSION=""
LIBEXPAT_VERSION="expat-2.7.1"
BUDFREAD_VERSION="libudfread-master"
OPENMPT_VERSION="libopenmpt-0.8.2"
LIBGSM_VERSION="gsm-1.0.22"
TIFF_VERSION="tiff-4.7.0"
LIBILIBC_VERSION="libilbc-3.0.4"
XVID_VERSION="xvidcore-1.3.7"
SCHROEDINGER_VERSION="schroedinger-1.0.11"
LIBSSH_VERSION="libssh-0.11.0"
XZ_VERSION="xz-5.8.1"
ZSTD_VERSION="zstd-1.5.7"
LIBBS2B_VERSION="libbs2b-3.1.0"
SVTAV1_VERSION="SVT-AV1-v3.1.0"
FFTW_VERSION="fftw-3.3.10"

FFMPEG_URL="https://ffmpeg.org/releases/${FFMPEG_VERSION}.tar.xz"


ZLIB_URL="https://zlib.net/${ZLIB_VERSION}.tar.gz"
BROTLI_URL="https://github.com/google/brotli/archive/refs/tags/v${BROTLI_VERSION}.tar.gz"
XZ_URL="https://github.com/tukaani-project/xz/releases/download/v5.8.1/${XZ_VERSION}.tar.gz"
ZSTD_URL="https://github.com/facebook/zstd/releases/download/v1.5.7/${ZSTD_VERSION}.tar.gz"
BZIP2_URL="https://github.com/libarchive/bzip2/archive/refs/tags/${BZIP2_VERSION}.tar.gz"
OPENSSL_URL="https://github.com/openssl/openssl/releases/download/${OPENSSL_VERSION}/${OPENSSL_VERSION}.tar.gz"
X264_URL="https://code.videolan.org/videolan/x264/-/archive/master/${X264_VERSION}.tar.gz"
X265_URL="http://ftp.videolan.org/pub/videolan/x265/${X265_VERSION}.tar.gz"
LIBVPX_URL="https://github.com/webmproject/libvpx/archive/v1.15.0/${LIBVPX_VERSION}.tar.gz"
AAC_URL="https://downloads.sourceforge.net/opencore-amr/${AAC_VERSION}.tar.gz"
LAME_URL="https://sourceforge.net/projects/lame/files/lame/3.100/${LAME_VERSION}.tar.gz/download"
OPUS_URL="https://github.com/xiph/opus/releases/download/v1.5.2/${OPUS_VERSION}.tar.gz"
VORBIS_URL="https://downloads.xiph.org/releases/vorbis/${VORBIS_VERSION}.tar.xz"
OGG_URL="https://downloads.xiph.org/releases/ogg/${OGG_VERSION}.tar.gz"
AOM_URL="https://storage.googleapis.com/aom-releases/${AOM_VERSION}.tar.gz"
DAV1D_URL="https://code.videolan.org/videolan/dav1d/-/archive/master/${DAV1D-VERSION}.tar.gz"
LIBASS_URL="https://github.com/libass/libass/releases/download/0.17.4/${LIBASS_VERSION}.tar.gz"
# We have to git clone depth 1 Freetype
FREETYPE_URL="https://github.com/freetype/freetype"
LIBPNG_URL="https://download.sourceforge.net/libpng/${LIBPNG_VERSION}.tar.gz"
FONTCONFIG_URL="https://www.freedesktop.org/software/fontconfig/release/${FONTCONFIG_VERSION}.tar.xz"
FRIBIDI_URL="https://github.com/fribidi/fribidi/releases/download/v1.0.16/${FRIBIDI_VERSION}.tar.xz"
BLURAY_URL="https://code.videolan.org/videolan/libbluray/-/archive/master/${BLURAY_VERSION}.tar.gz"
THEORA_URL="http://downloads.xiph.org/releases/theora/${THEORA_VERSION}.tar.gz"
SPEEX_URL="http://downloads.xiph.org/releases/speex/${SPEEX_VERSION}.tar.gz"
# We have to git clone this also
OPENJPEG_URL="https://github.com/uclouvain/openjpeg"
# We have to git clone this also
LIBXML2_URL="https://github.com/GNOME/libxml2.git"
# We have to git clone this also
HARFBUZZ_URL="https://github.com/harfbuzz/harfbuzz.git"
LIBEXPAT_URL="https://github.com/libexpat/libexpat/releases/download/R_2_7_1/${LIBEXPAT_VERSION}.tar.gz"
BUDFREAD_URL="https://code.videolan.org/videolan/libudfread/-/archive/master/${BUDFREAD_VERSION}.tar.gz"
# We have to git clone libwebp
WEBP_URL="https://chromium.googlesource.com/webm/libwebp"
# We have to git clone this too
VMAF_URL="https://github.com/Netflix/vmaf"
# We have to git clone this too
VIDSTAB_URL="https://github.com/georgmartius/vid.stab"
# We have to git clone this too
ZIMG_URL="https://github.com/sekrit-twc/zimg"
# We have to git clone this too
FREI0R_URL="https://github.com/dyne/frei0r"
# We have to git clone this too
OPENMPT_URL="https://lib.openmpt.org/files/libopenmpt/src/${OPENMPT_VERSION}+release.autotools.tar.gz"
# We have to git clone this too
RUBBERBAND_URL="https://github.com/breakfastquay/rubberband"
# We have to git clone this too
SOXR_URL="https://github.com/chirlu/soxr"
# We have to git clone this too
LIBMYSOFA_URL="https://github.com/hoene/libmysofa"
SVTAV1_URL="https://gitlab.com/AOMediaCodec/SVT-AV1/-/archive/v3.1.0/${SVTAV1_VERSION}.tar.gz"
SRT_URL="https://github.com/Haivision/srt"
LIBRIST_URL="https://code.videolan.org/rist/librist"
LIBZMQ_URL="https://github.com/zeromq/libzmq"
LIBPLACEBO_URL=""
LIBGSM_URL="https://www.quut.com/gsm/${LIBGSM_VERSION}.tar.gz"
TIFF_URL="https://download.osgeo.org/libtiff/${TIFF_VERSION}.tar.gz"
LIBILIBC_URL="https://github.com/TimothyGu/libilbc/releases/download/v3.0.4/${LIBILIBC_VERSION}rc2.tar.gz"
XVID_URL="https://downloads.xvid.com/downloads/${XVID_VERSION}.tar.gz"
LIBSSH_URL="https://www.libssh.org/files/0.11/${LIBSSH_VERSION}.tar.xz"

LIBBS2B_URL="https://sourceforge.net/projects/bs2b/files/libbs2b/3.1.0/${LIBBS2B_VERSION}.tar.gz/download"
FFTW_URL="https://www.fftw.org/${FFTW_VERSION}.tar.gz"

SCHROEDINGER_URL="https://github.com/codec-world/libschroedinger/releases/download/${SCHROEDINGER_VERSION}/${SCHROEDINGER_VERSION}.tar.gz"



if [ -z "$ARCH" ]; then
  echo "Usage: $0 <aarch64|armv7|x86|x86_64|riscv64>"
  exit 1
fi
# Architecture setup
case "$ARCH" in
  aarch64)
    HOST=aarch64-linux-musl
    RUST_TARGET=aarch64-unknown-linux-musl
    ;;
  armv7)
    HOST=armv7l-linux-musleabihf
    RUST_TARGET=armv7-unknown-linux-musleabihf
    ;;
  x86)
    HOST=i686-linux-musl
    RUST_TARGET=i686-unknown-linux-musl
    ;;
  x86_64)
    HOST=x86_64-linux-musl
    RUST_TARGET=x86_64-unknown-linux-musl
    ;;
  riscv64)
    HOST=riscv64-linux-musl
    RUST_TARGET=riscv64gc-unknown-linux-musl
    ;;
  *)
    echo "Unsupported architecture: $ARCH"
    exit 1
    ;;
esac

export CC="${HOST}-gcc"
export CXX="${HOST}-g++"
export AR="${HOST}-ar"
export RANLIB="${HOST}-ranlib"
export STRIP="${HOST}-strip"
export NM="${HOST}-nm"
export STRINGS="${HOST}-strings"

resolve_absolute_path() {
    local tool_name="$1"
    local abs_path=$(which "$tool_name" 2>/dev/null)
    if [ -z "$abs_path" ]; then
        echo "ERROR: Tool '$tool_name' not found in PATH" >&2
        exit 1
    fi
    echo "$abs_path"
}
CC_ABS=$(resolve_absolute_path "$CC")
CXX_ABS=$(resolve_absolute_path "$CXX")
AR_ABS=$(resolve_absolute_path "$AR")
RANLIB_ABS=$(resolve_absolute_path "$RANLIB")
STRIP_ABS=$(resolve_absolute_path "$STRIP")
NM_ABS=$(resolve_absolute_path "$NM")
SIZE_CFLAGS="-Os -ffunction-sections -fdata-sections"
SIZE_CXXFLAGS="-Os -ffunction-sections -fdata-sections" 
SIZE_LDFLAGS="-Wl,--gc-sections -Wl,--strip-all"
export LTO_FLAGS=""
export CFLAGS="-static $SIZE_CFLAGS -DNDEBUG"
export CXXFLAGS="-static $SIZE_CXXFLAGS -DNDEBUG" 
export LDFLAGS="-static $SIZE_LDFLAGS -Wl,--allow-multiple-definition"
export SYSROOT=$(${CC_ABS} --print-sysroot)
ROOT_DIR="$(pwd)"
BUILD_DIR="$ROOT_DIR/build/$ARCH"
PREFIX="$BUILD_DIR/prefix"
mkdir -p "$BUILD_DIR" "$PREFIX"
export PKG_CONFIG_PATH="$PREFIX/lib/pkgconfig:$PKG_CONFIG_PATH"
export PKG_CONFIG_ALLOW_CROSS=1
export CARGO_BUILD_TARGET=${RUST_TARGET}
export CARGO_DEFAULT_TARGET="${RUST_TARGET}"

CARGO_TARGET_VAR=$(echo "$RUST_TARGET" | tr '[:lower:]' '[:upper:]' | tr '-' '_')

export CARGO_TARGET_${CARGO_TARGET_VAR}_LINKER=${CC_ABS}
export CARGO_TARGET_${CARGO_TARGET_VAR}_AR=${AR_ABS}



# Download function 

download_sources() {
    cd "$BUILD_DIR"

    [ ! -f zlib.tar.gz ]        && curl -L "$ZLIB_URL" -o zlib.tar.gz
    [ ! -f brotli.tar.gz ]      && curl -L "$BROTLI_URL" -o brotli.tar.gz
    [ ! -f xz.tar.gz ]          && curl -L "$XZ_URL" -o xz.tar.gz
    [ ! -f zstd.tar.gz ]        && curl -L "$ZSTD_URL" -o zstd.tar.gz
    [ ! -f bzip2.tar.gz ]       && curl -L "$BZIP2_URL" -o bzip2.tar.gz
    [ ! -f openssl.tar.gz ]     && curl -L "$OPENSSL_URL" -o openssl.tar.gz
    [ ! -f x264.tar.gz ]        && curl -L "$X264_URL" -o x264.tar.gz
    [ ! -f x265.tar.gz ]        && curl -L "$X265_URL" -o x265.tar.gz
    [ ! -f libvpx.tar.gz ]      && curl -L "$LIBVPX_URL" -o libvpx.tar.gz
    [ ! -f aac.tar.gz ]         && curl -L "$AAC_URL" -o aac.tar.gz
    [ ! -f libgsm.tar.xz ]      && curl -L "$LIBGSM_URL" -o libgsm.tar.xz
    [ ! -f lame.tar.gz ]        && curl -L "$LAME_URL" -o lame.tar.gz
    [ ! -f opus.tar.gz ]        && curl -L "$OPUS_URL" -o opus.tar.gz
    [ ! -f vorbis.tar.xz ]      && curl -L "$VORBIS_URL" -o vorbis.tar.xz
    [ ! -f ogg.tar.gz ]         && curl -L "$OGG_URL" -o ogg.tar.gz
    [ ! -f dav1d.tar.gz ]       && curl -L "$DAV1D_URL" -o dav1d.tar.gz
    [ ! -f libass.tar.gz ]      && curl -L "$LIBASS_URL" -o libass.tar.
    [ ! -f libpng.tar.gz ]      && curl -L "$LIBPNG_URL" -o libpng.tar.gz
    [ ! -f fontconfig.tar.xz ]  && curl -L "$FONTCONFIG_URL" -o fontconfig.tar.xz
    [ ! -f fribidi.tar.xz ]     && curl -L "$FRIBIDI_URL" -o fribidi.tar.xz
    [ ! -f bluray.tar.gz ]      && curl -L "$BLURAY_URL" -o bluray.tar.gz
    [ ! -f theora.tar.gz ]      && curl -L "$THEORA_URL" -o theora.tar.gz
    [ ! -f speex.tar.gz ]       && curl -L "$SPEEX_URL" -o speex.tar.gz
    [ ! -f libexpat.tar.gz ]    && curl -L "$LIBEXPAT_URL" -o libexpat.tar.gz
    [ ! -f budfread.tar.gz ]    && curl -L "$BUDFREAD_URL" -o budfread.tar.gz
    [ ! -f openmpt.tar.gz ]     && curl -L "$OPENMPT_URL" -o openmpt.tar.gz
    [ ! -f tiff.tar.gz ]        && curl -L "$TIFF_URL" -o tiff.tar.gz
    [ ! -f libilibc.tar.gz ]    && curl -L "$LIBILIBC_URL" -o libilibc.tar.gz
    [ ! -f xvid.tar.xz ]      && curl -L "$XVID_URL" -o xvid.tar.xz
    [ ! -f ffmpeg.tar.xz ]      && curl -L "$FFMPEG_URL" -o ffmpeg.tar.xz
    # deprecated [ ! -f schroedinger.tar.gz ] && curl -L "$SCHROEDINGER_URL" -o schroedinger.tar.gz
    [ ! -f libssh.tar.gz ] && curl -L "$LIBSSH_URL" -o libssh.tar.gz
    [ ! -f libbs2b.tar.gz ] && curl -L "$LIBBS2B_URL" -o libbs2b.tar.gz
    [ ! -f svtav1.tar.gz ] && curl -L "$SVTAV1_URL" -o svtav1.tar.gz
    [ ! -f fftw.tar.gz ] && curl -L "$FFTW_URL" -o fftw.tar.gz

    [ ! -d freetype ]  && git clone --depth 1 "$FREETYPE_URL" freetype
    [ ! -d openjpeg ]  && git clone --depth 1 "$OPENJPEG_URL" openjpeg
    [ ! -d libxml2 ]   && git clone --depth 1 "$LIBXML2_URL" 
    [ ! -d harfbuzz ]  && git clone --depth 1 "$HARFBUZZ_URL"
    [ ! -d libwebp ]  && git clone --depth 1 "$WEBP_URL"
    [ ! -d vmaf ]  && git clone --depth 1 "$VMAF_URL"
    [ ! -d vidstab ] && git clone --depth 1 "$VIDSTAB_URL" vidstab
    [ ! -d zimg ] && git clone --recursive "$ZIMG_URL"
    [ ! -d frei0r ] && git clone --depth 1 "$FREI0R_URL"
    [ ! -d rubberband ] && git clone --depth 1  "$RUBBERBAND_URL"
    [ ! -d soxr ] && git clone --depth 1  "$SOXR_URL"
    [ ! -d libmysofa ] && git clone --depth 1  "$LIBMYSOFA_URL"
    [ ! -d srt ] && git clone --depth 1 "$SRT_URL"
    [ ! -d librist ] && git clone --depth 1 "$LIBRIST_URL"
    [ ! -d libzmq ] && git clone --depth 1 "$LIBZMQ_URL"
    [ ! -d libplacebo ] && git clone --recursive https://github.com/haasn/libplacebo
    [ ! -d rav1e ] && git clone --depth 1 https://github.com/xiph/rav1e
    [ ! -d vo-amrwbenc ] && git clone --depth 1 https://github.com/mstorsjo/vo-amrwbenc
    [ ! -d opencore-amr ] && git clone --depth 1 https://github.com/BelledonneCommunications/opencore-amr
    [ ! -d twolame ] && git clone --depth 1 https://github.com/njh/twolame
    [ ! -d libcodec2 ] && git clone --depth 1 https://github.com/MonadicLabs/libcodec2
    [ ! -d aribb24 ] && git clone --depth 1 https://github.com/nkoriyama/aribb24
    [ ! -d uavs3d ] && git clone --depth 1 https://github.com/uavs3/uavs3d
    [ ! -d kvazaar ] && git clone --recursive https://github.com/ultravideo/kvazaar
   #deprecated [ ! -d orc ] && git clone --depth 1 https://github.com/GStreamer/orc
    [ ! -d xavs ] && svn checkout https://svn.code.sf.net/p/xavs/code/ xavs
    [ ! -d xavs2 ] && git clone --depth 1 https://github.com/pkuvcl/xavs2
    [ ! -d davs2 ] && git clone --depth 1 https://github.com/pkuvcl/davs2
    [ ! -d rtmpdump ] && git clone --depth 1 https://github.com/mstorsjo/rtmpdump
    [ ! -d vvdec ] && git clone --depth 1 https://github.com/fraunhoferhhi/vvdec
    [ ! -d vvenc ] && git clone --depth 1 https://github.com/fraunhoferhhi/vvenc
    [ ! -d vapoursynth ] && git clone --depth 1 https://github.com/vapoursynth/vapoursynth
    [ ! -d libffi ] && git clone --depth 1 https://github.com/libffi/libffi
    [ ! -d glib ] && git clone --depth 1 https://github.com/GNOME/glib
    [ ! -d lensfun ] && git clone --depth 1 https://github.com/lensfun/lensfun
    [ ! -d flite ] && git clone --depth 1 https://github.com/festvox/flite
    [ ! -d libv4l ] && git clone --depth 1 https://git.linuxtv.org/v4l-utils.git libv4l
    [ ! -d libgme ] && git clone --depth 1 https://github.com/libgme/game-music-emu libgme
    [ ! -d aom ] && git clone --depth 1 https://aomedia.googlesource.com/aom
    [ ! -d opencl ] && git clone --depth 1 https://github.com/KhronosGroup/OpenCL-Headers opencl
    [ ! -d pocl ] && git clone --depth 1 https://github.com/pocl/pocl
    [ ! -d highway ] && git clone --depth 1 https://github.com/google/highway
    [ ! -d libjxl ] && git clone --depth 1 https://github.com/libjxl/libjxl
    [ ! -d libqrencode ] && git clone --depth 1 https://github.com/fukuchi/libqrencode
    [ ! -d quirc ] && git clone --depth 1 https://github.com/dlbeer/quirc
    [ ! -d chromaprint ] && git clone --depth 1 https://github.com/acoustid/chromaprint
    [ ! -d libcaca ] && git clone --depth 1 https://github.com/cacalabs/libcaca
    [ ! -d pixman ] && git clone --depth 1 https://gitlab.freedesktop.org/pixman/pixman
    [ ! -d pango ] && git clone --depth 1 https://github.com/GNOME/pango
    [ ! -d cairo ] && git clone --depth 1 https://gitlab.freedesktop.org/cairo/cairo
    [ ! -d librsvg ] && git clone --depth 1 https://github.com/GNOME/librsvg

    [ ! -d zlib ]        && tar -xf zlib.tar.gz        && mv "$ZLIB_VERSION" zlib
    [ ! -d brotli ]      && tar -xf brotli.tar.gz      && mv "brotli-${BROTLI_VERSION}" brotli
    [ ! -d xz ]          && tar -xf xz.tar.gz          && mv "$XZ_VERSION"       xz
    [ ! -d zstd ]        && tar -xf zstd.tar.gz        && mv "$ZSTD_VERSION"     zstd
    [ ! -d bzip2 ]       && tar -xf bzip2.tar.gz       && mv "bzip2-${BZIP2_VERSION}" bzip2
    [ ! -d openssl ]     && tar -xf openssl.tar.gz     && mv "$OPENSSL_VERSION" openssl
    [ ! -d x264 ]        && tar -xf x264.tar.gz        && mv "$X264_VERSION" x264
    [ ! -d x265 ]        && tar -xf x265.tar.gz        && mv "$X265_VERSION" x265
    [ ! -d libvpx ]      && tar -xf libvpx.tar.gz      && mv "$LIBVPX_VERSION" libvpx
    [ ! -d aac ]         && tar -xf aac.tar.gz         && mv "$AAC_VERSION" aac
    [ ! -d lame ]        && tar -xf lame.tar.gz        && mv "$LAME_VERSION" lame
    [ ! -d libpng ]      && tar -xf libpng.tar.gz      && mv "$LIBPNG_VERSION" libpng
    [ ! -d opus ]        && tar -xf opus.tar.gz        && mv "$OPUS_VERSION" opus
    [ ! -d vorbis ]      && tar -xf vorbis.tar.xz      && mv "$VORBIS_VERSION" vorbis
    [ ! -d ogg ]         && tar -xf ogg.tar.gz         && mv "$OGG_VERSION" ogg
    [ ! -d dav1d ]       && tar -xf dav1d.tar.gz       && mv "$DAV1D_VERSION"* dav1d
    [ ! -d libass ]      && tar -xf libass.tar.gz      && mv "$LIBASS_VERSION" libass
    [ ! -d fontconfig ]  && tar -xf fontconfig.tar.xz  && mv "$FONTCONFIG_VERSION" fontconfig
    [ ! -d fribidi ]     && tar -xf fribidi.tar.xz     && mv "$FRIBIDI_VERSION" fribidi
    [ ! -d bluray ]      && tar -xf bluray.tar.gz      && mv "$BLURAY_VERSION"* bluray
    [ ! -d theora ]      && tar -xf theora.tar.gz      && mv "$THEORA_VERSION" theora
    [ ! -d speex ]       && tar -xf speex.tar.gz       && mv "$SPEEX_VERSION" speex
    [ ! -d libexpat ]    && tar -xf libexpat.tar.gz    && mv "$LIBEXPAT_VERSION" libexpat
    [ ! -d budfread ]    && tar -xf budfread.tar.gz    && mv "$BUDFREAD_VERSION" budfread
    [ ! -d openmpt ]     && tar -xf openmpt.tar.gz     && mv "$OPENMPT_VERSION"* openmpt
    [ ! -d libgsm ]      && tar -xf libgsm.tar.xz      && mv gsm* libgsm
  #  [ ! -d tiff ]        && tar -xf tiff.tar.gz        && mv "$TIFF_VERSION" tiff
    [ ! -d libilibc ]    && tar -xf libilibc.tar.gz    && mv "$LIBILIBC_VERSION" libilibc
    [ ! -d libssh ]      && tar -xf libssh.tar.gz && mv "$LIBSSH_VERSION" libssh
    [ ! -d svtav1 ]      && tar -xf svtav1.tar.gz && mv "$SVTAV1_VERSION" svtav1
    [ ! -d xvidcore ]    && tar -xf xvid.tar.xz
    [ ! -d libbs2b ]     && tar -xf libbs2b.tar.gz     && mv "$LIBBS2B_VERSION" libbs2b
    [ ! -f fftw ] && tar -xf fftw.tar.gz && mv "$FFTW_VERSION" "fftw"
    [ ! -d ffmpeg ]      && tar -xf ffmpeg.tar.xz      && mv "$FFMPEG_VERSION" ffmpeg
    # deprecated [ ! -d schroedinger ]  && tar -xf schroedinger.tar.gz && mv "$SCHROEDINGER_VERSION" schroedinger
    
}


COMMON_CMAKE_FLAGS=(
    "-DCMAKE_INSTALL_PREFIX=$PREFIX"
    "-DCMAKE_C_COMPILER=$CC_ABS"
    "-DCMAKE_CXX_COMPILER=$CXX_ABS"
    "-DCMAKE_C_FLAGS=$CFLAGS"
    "-DCMAKE_AR=$AR_ABS"
    "-DCMAKE_RANLIB=$RANLIB_ABS"
    "-DCMAKE_STRIP=$STRIP_ABS"
    "-DCMAKE_FIND_ROOT_PATH=$SYSROOT;$PREFIX"
    "-DCMAKE_EXE_LINKER_FLAGS=$LDFLAGS"
    "-DCMAKE_SYSROOT=$SYSROOT"
)




build_zlib() {
    echo "Building zlib for $ARCH (required for OpenSSL and curl)..."
    cd "$BUILD_DIR/zlib"

    export CHOST="$HOST"

    # Temporarily use safe flags for configure
    CONFIGURE_CFLAGS="-fPIC --sysroot=$SYSROOT"

    # Run configure with minimal flags
    CFLAGS="$CONFIGURE_CFLAGS" ./configure --prefix="$PREFIX" --static

    # Compile using full optimization flags
    make -j$(nproc) CFLAGS="$CFLAGS"
    make install

    echo "✔ zlib built successfully (OpenSSL + curl dependency)"
}

build_brotli() {
    echo "Building Brotli for $ARCH..."
    cd "$BUILD_DIR/brotli"
    rm -rf out
    mkdir -p out && cd out

    cmake .. \
        -DCMAKE_INSTALL_PREFIX="$PREFIX" \
        -DCMAKE_SYSTEM_NAME=Linux \
        -DCMAKE_C_COMPILER="$CC_ABS" \
        -DCMAKE_CXX_COMPILER="$CXX_ABS" \
        -DCMAKE_AR="$AR_ABS" \
        -DCMAKE_RANLIB="$RANLIB_ABS" \
        -DCMAKE_STRIP="$STRIP_ABS" \
        -DCMAKE_FIND_ROOT_PATH_MODE_PROGRAM=NEVER \
        -DCMAKE_FIND_ROOT_PATH_MODE_LIBRARY=ONLY \
        -DCMAKE_FIND_ROOT_PATH_MODE_INCLUDE=ONLY \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_C_FLAGS="$CFLAGS -I$PREFIX/include" \
        -DCMAKE_CXX_FLAGS="$CXXFLAGS -I$PREFIX/include" \
        -DCMAKE_EXE_LINKER_FLAGS="$LDFLAGS -L$PREFIX/lib" \
        -DBUILD_SHARED_LIBS=OFF \
        -DBROTLI_BUNDLED_MODE=OFF \
        -DBROTLI_DISABLE_TESTS=ON

    make -j"$(nproc)"
    make install

    echo "✔ Brotli built successfully"
}

build_liblzma() {
    echo "Building liblzma for $ARCH"
    cd "$BUILD_DIR/xz"
    CONFIGURE_CFLAGS="-O2"
    
    ./configure \
      --host="$HOST" \
      --prefix="$PREFIX" \
      --enable-static \
      --disable-shared \
      CC="$CC_ABS" \
      CFLAGS="$CFLAGS" \
      CXXFLAGS="$CXXFLAGS"
      LDFLAGS="$LDFLAGS"
    make -j$(nproc)
    make install
    
    echo "✔ liblzma built successfully"
}

build_zstd() {
    cd "$BUILD_DIR/zstd"
    
    # Clean any previous build
    make clean || true
    
    # Build only static library
    make -j1 -C lib \
        CC="$CC_ABS" \
        AR="$AR_ABS" \
        RANLIB="$RANLIB_ABS" \
        CFLAGS="$CFLAGS" \
        LDFLAGS="$LDFLAGS" \
        PREFIX="$PREFIX" \
        HAVE_THREAD=1 \
        ZSTD_LEGACY_SUPPORT=0 \
        libzstd.a
    
    # Install everything (static lib, headers, and pkg-config file)
    make -C lib install-static install-includes install-pc \
        PREFIX="$PREFIX"
}

build_openssl() {
    echo "Building OpenSSL for $ARCH"
    cd "$BUILD_DIR/openssl"

    case "$ARCH" in
        aarch64) OPENSSL_TARGET="linux-aarch64" ;;
        armv7)   OPENSSL_TARGET="linux-armv4" ;;
        x86)     OPENSSL_TARGET="linux-x86" ;;
        x86_64)  OPENSSL_TARGET="linux-x86_64" ;;
        riscv64) OPENSSL_TARGET="linux-generic64" ;;
    esac
     (make clean && make distclean) || true
    ./Configure "$OPENSSL_TARGET" \
     no-tests no-shared no-dso no-threads no-engine no-ssl3 no-comp \
    --prefix="$PREFIX" \
    --openssldir="$PREFIX/ssl" \
     --with-zlib-include="$PREFIX/include" \
     --with-zlib-lib="$PREFIX/lib"


    make -j"$(nproc)" build_sw
    make install_sw

    echo "✔ OpenSSL built successfully"
}



build_x264() {
    echo "Building x264 for $ARCH..."
    cd "$BUILD_DIR/x264"
    (make clean && make distclean) || true

    ./configure \
        --prefix="$PREFIX" \
        --host="$HOST" \
        --cross-prefix="${HOST}-" \
        --enable-static \
        --disable-cli \
        --disable-opencl \
        --enable-pic \
        --extra-cflags="$CFLAGS -I$PREFIX/include" \
        --extra-ldflags="$LDFLAGS -L$PREFIX/lib"

    make -j"$(nproc)"
    make install

    echo "✔ x264 built successfully"
}


build_x265() {
    echo "Building x265 for $ARCH..."

    SOURCE_DIR="$BUILD_DIR/x265/source"
    CMAKELIST="$SOURCE_DIR/CMakeLists.txt"

    if [ ! -d "$SOURCE_DIR" ]; then
        echo "ERROR: x265 source directory not found: $SOURCE_DIR"
        return 1
    fi

    [ -f "$CMAKELIST.bak" ] && cp "$CMAKELIST.bak" "$CMAKELIST"
    cp "$CMAKELIST" "$CMAKELIST.bak"

    sed -i 's/^\s*cmake_policy(SET CMP0025 OLD)/# &/; s/^\s*cmake_policy(SET CMP0054 OLD)/# &/' "$CMAKELIST"

    BUILD_X265_DIR="$BUILD_DIR/x265/build/linux"
    
    # Clean any existing build to avoid cache issues
    rm -rf "$BUILD_X265_DIR"
    mkdir -p "$BUILD_X265_DIR"
    cd "$BUILD_X265_DIR"

    # Resolve absolute paths at build time
    CC_ABS=$(which "$CC")
    CXX_ABS=$(which "$CXX") 
    AR_ABS=$(which "$AR")
    RANLIB_ABS=$(which "$RANLIB")
    STRIP_ABS=$(which "$STRIP")
    NM_ABS=$(which "$NM")

    echo "Current directory: $(pwd)"
    echo "Using CC: $CC_ABS"
    echo "Using AR: $AR_ABS"
    
    # Verify all tools are found
    for tool in "$CC_ABS" "$CXX_ABS" "$AR_ABS" "$RANLIB_ABS" "$STRIP_ABS" "$NM_ABS"; do
        if [ -z "$tool" ] || [ ! -x "$tool" ]; then
            echo "ERROR: Tool not found or not executable: $tool"
            return 1
        fi
    done
    
    # Alternative approach: Set environment variables for CMake
    export CMAKE_C_COMPILER="$CC_ABS"
    export CMAKE_CXX_COMPILER="$CXX_ABS"
    export CMAKE_AR="$AR_ABS"
    export CMAKE_RANLIB="$RANLIB_ABS"
    
    cmake "$SOURCE_DIR" \
        -DCMAKE_INSTALL_PREFIX="$PREFIX" \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_SYSTEM_NAME=Linux \
        -DCMAKE_C_COMPILER="$CC_ABS" \
        -DCMAKE_CXX_COMPILER="$CXX_ABS" \
        -DCMAKE_AR="$AR_ABS" \
        -DCMAKE_RANLIB="$RANLIB_ABS" \
        -DCMAKE_STRIP="$STRIP_ABS" \
        -DCMAKE_NM="$NM_ABS" \
        -DCMAKE_FIND_ROOT_PATH_MODE_PROGRAM=NEVER \
        -DCMAKE_FIND_ROOT_PATH_MODE_LIBRARY=ONLY \
        -DCMAKE_FIND_ROOT_PATH_MODE_INCLUDE=ONLY \
        -DENABLE_SHARED=OFF \
        -DENABLE_CLI=OFF \
        -DENABLE_PIC=ON \
        -DCMAKE_C_FLAGS="$CFLAGS -I$PREFIX/include" \
        -DCMAKE_CXX_FLAGS="$CXXFLAGS -I$PREFIX/include" \
        -DCMAKE_EXE_LINKER_FLAGS="$LDFLAGS -L$PREFIX/lib" \
        -DCMAKE_POLICY_VERSION_MINIMUM=3.5

    if [ $? -ne 0 ]; then
        echo "ERROR: CMake configuration failed"
        return 1
    fi

    # Check what CMake actually configured
    echo "Checking CMake cache for AR setting:"
    grep CMAKE_AR CMakeCache.txt || echo "CMAKE_AR not found in cache"

    make -j$(nproc)
    
    if [ $? -ne 0 ]; then
        echo "ERROR: Make failed"
        return 1
    fi

    make install

    echo "✔ x265 built successfully"
}

build_twolame() {
  echo "Building twolame for $ARCH..."
  cd "$BUILD_DIR/twolame" || exit 1
  (make clean && make distclean) || true

  autoreconf -fi || exit 1
  ./configure \
    --host="$HOST" \
    --prefix="$PREFIX" \
    --enable-static \
    --disable-shared \
    CC="$CC" \
    AR="$AR" \
    RANLIB="$RANLIB" \
    STRIP="$STRIP" \
    CFLAGS="$CFLAGS" \
    LDFLAGS="$LDFLAGS" || exit 1

  # Build only the static library, skip docs
  make -C libtwolame -j"$(nproc)" || exit 1
  make -C libtwolame install || exit 1
}


build_libgsm() {
  echo "Building libgsm for $ARCH..."
  cd "$BUILD_DIR/libgsm" || exit 1

  (make clean && make distclean) || true

  CC="$CC" AR="$AR" RANLIB="$RANLIB" STRIP="$STRIP" \
  CFLAGS="$CFLAGS" LDFLAGS="$LDFLAGS" \
  make -j"$(nproc)" CC="$CC" || exit 1

  make install INSTALL_ROOT="$PREFIX" || exit 1

  # Install header files manually
  HEADER_SRC_DIR="$BUILD_DIR/libgsm"
  HEADER_DST_DIR="$PREFIX/include/gsm"
  mkdir -p "$HEADER_DST_DIR"
  find "$HEADER_SRC_DIR" -type f -name '*.h' -exec cp {} "$HEADER_DST_DIR/" \;

  # Generate pkg-config file if missing
  PC_DIR="$PREFIX/lib/pkgconfig"
  PC_FILE="$PC_DIR/gsm.pc"

  if [ ! -f "$PC_FILE" ]; then
    echo "Generating gsm.pc..."

    mkdir -p "$PC_DIR"
    cat > "$PC_FILE" <<EOF
prefix=$PREFIX
exec_prefix=\${prefix}
libdir=\${exec_prefix}/lib
includedir=\${prefix}/include/gsm

Name: libgsm
Description: GSM 06.10 lossy speech compression
Version: 1.0.22
Libs: -L\${libdir} -lgsm
Cflags: -I\${includedir}
EOF
  fi

  echo "✔ libgsm built successfully"
}



build_libvpx() {
    echo "Building libvpx for $ARCH..."
    cd "$BUILD_DIR/libvpx"
    (make clean && make distclean) || true
    find . -name '*.d' -delete  # <- stale dependency fix

    case "$ARCH" in
      x86_64)   VPX_TARGET="x86_64-linux-gcc" ;;
      x86)      VPX_TARGET="x86-linux-gcc" ;;
      armv7)    VPX_TARGET="armv7-linux-gcc" ;;
      aarch64)  VPX_TARGET="arm64-linux-gcc" ;;
      riscv64)  VPX_TARGET="generic-gnu" ;;  # closest match
      *)        echo "Unsupported arch for libvpx"; exit 1 ;;
    esac

    ./configure \
        --prefix="$PREFIX" \
        --target="$VPX_TARGET" \
        --disable-examples \
        --disable-tools \
        --disable-docs \
        --disable-unit-tests \
        --enable-pic \
        --enable-vp8 \
        --disable-neon-i8mm \
        --enable-vp9 \
        --enable-static \
        --disable-shared \
        --extra-cflags="$CFLAGS -I$PREFIX/include"

    make -j"$(nproc)"
    make install

    echo "✔ libvpx built successfully"
}


build_aac() {
    echo "Building libfdk-aac for $ARCH..."
    cd "$BUILD_DIR/aac"
(make clean && make distclean) || true

    ./configure \
        --prefix="$PREFIX" \
        --host="$HOST" \
        --enable-static \
        --disable-shared \
        CFLAGS="$CFLAGS -I$PREFIX/include" \
        LDFLAGS="$LDFLAGS -L$PREFIX/lib"

    make -j"$(nproc)"
    make install

    echo "✔ libfdk-aac built successfully"
}

build_lame() {
    echo "Building LAME for $ARCH..."
    cd "$BUILD_DIR/lame"
(make clean && make distclean) || true

    ./configure \
        --prefix="$PREFIX" \
        --host="$HOST" \
        --enable-static \
        --disable-shared \
        CFLAGS="$CFLAGS -I$PREFIX/include" \
        LDFLAGS="$LDFLAGS -L$PREFIX/lib"

    make -j"$(nproc)"
    make install

    echo "✔ LAME built successfully"
}

build_opus() {
    echo "Building Opus for $ARCH..."
    cd "$BUILD_DIR/opus"
(make clean && make distclean) || true

    ./configure \
        --prefix="$PREFIX" \
        --host="$HOST" \
        --disable-shared \
        --enable-static \
        --disable-doc \
        --disable-extra-programs \
        --with-pic \
        CFLAGS="$CFLAGS -I$PREFIX/include" \
        LDFLAGS="$LDFLAGS -L$PREFIX/lib"

    make -j"$(nproc)"
    make install

    echo "✔ Opus built successfully"
}

build_vorbis() {
    echo "Building libvorbis for $ARCH..."
    cd "$BUILD_DIR/vorbis"
    (make clean && make distclean) || true


    ./configure \
        --prefix="$PREFIX" \
        --host="$HOST" \
        --with-ogg="$PREFIX" \
        --enable-static \
        --disable-shared \
        --disable-oggtest \
        CFLAGS="$CFLAGS -I$PREFIX/include" \
        LDFLAGS="$LDFLAGS -L$PREFIX/lib"

    make -j"$(nproc)"
    make install

    echo "✔ libvorbis built successfully"
}

build_ogg() {
    echo "Building libogg for $ARCH..."
    cd "$BUILD_DIR/ogg"
    (make clean && make distclean) || true


    ./configure \
        --prefix="$PREFIX" \
        --host="$HOST" \
        --enable-static \
        --disable-shared \
        CFLAGS="$CFLAGS" \
        LDFLAGS="$LDFLAGS"

    make -j"$(nproc)"
    make install

    echo "✔ libogg built successfully"
}

build_speex() {
    echo "Building Speex for $ARCH..."
    cd "$BUILD_DIR/speex"
(make clean && make distclean) || true

    ./configure \
        --prefix="$PREFIX" \
        --host="$HOST" \
        --enable-static \
        --disable-shared \
        --disable-oggtest \
        --with-ogg="$PREFIX" \
        CFLAGS="$CFLAGS -I$PREFIX/include" \
        LDFLAGS="$LDFLAGS -L$PREFIX/lib"

    make -j"$(nproc)"
    make install

    echo "✔ Speex built successfully"
}

build_aom() {
  echo "Building libaom for $ARCH..."

  cd "$BUILD_DIR/aom" || exit 1
  rm -rf out
  mkdir -p out && cd out

  cmake .. \
    -DCMAKE_INSTALL_PREFIX="$PREFIX" \
    -DCMAKE_SYSTEM_NAME=Linux \
    -DCMAKE_C_COMPILER="$CC_ABS" \
    -DCMAKE_CXX_COMPILER="$CXX_ABS" \
    -DCMAKE_AR="$AR_ABS" \
    -DCMAKE_RANLIB="$RANLIB_ABS" \
    -DCMAKE_STRIP="$STRIP_ABS" \
    -DCMAKE_FIND_ROOT_PATH_MODE_PROGRAM=NEVER \
    -DCMAKE_FIND_ROOT_PATH_MODE_INCLUDE=ONLY \
    -DCMAKE_C_FLAGS="$CFLAGS -I$PREFIX/include" \
    -DCMAKE_CXX_FLAGS="$CXXFLAGS -I$PREFIX/include" \
    -DCMAKE_EXE_LINKER_FLAGS="$LDFLAGS -L$PREFIX/lib" \
    -DBUILD_SHARED_LIBS=OFF \
    -DENABLE_TESTS=OFF \
    -DENABLE_NASM=OFF \
    -DENABLE_DOCS=OFF

  make -j"$(nproc)" && make install
  echo "✔ libaom (AV1) built successfully"
}



build_dav1d() {
    echo "Building dav1d for $ARCH..."
    cd "$BUILD_DIR/dav1d"
    rm -rf build && mkdir build && cd build

    # Helper function to properly format flags as array elements
    format_flags() {
    local flags=()
    for flag in $1; do
        [ -n "$flag" ] && flags+=("'$flag'")
    done
    IFS=,; echo "${flags[*]}"
}


    meson setup . .. \
        --cross-file <(cat <<EOF
[binaries]
c = '$CC_ABS'
ar = '$AR_ABS'
strip = '$STRIP_ABS'
pkg-config = 'pkg-config'

[host_machine]
system = 'linux'
cpu_family = '${ARCH}'
cpu = '${ARCH}'
endian = 'little'

[built-in options]
c_args = [$(format_flags "$CFLAGS")]
cpp_args = [$(format_flags "$CXXFLAGS")]
c_link_args = [$(format_flags "$LDFLAGS")]
cpp_link_args = [$(format_flags "$LDFLAGS")]
EOF
    ) \
    --prefix="$PREFIX" \
    --default-library=static \
    --buildtype=release

    ninja -j"$(nproc)"
    ninja install

    echo "✔ dav1d built successfully"
}

build_fribidi() {
    echo "Building fribidi for $ARCH..."
    cd "$BUILD_DIR/fribidi"
(make clean && make distclean) || true

    ./configure \
        --prefix="$PREFIX" \
        --host="$HOST" \
        --enable-static \
        --disable-shared \
        CFLAGS="$CFLAGS -I$PREFIX/include" \
        LDFLAGS="$LDFLAGS -L$PREFIX/lib"

    make -j"$(nproc)"
    make install

    echo "✔ fribidi built successfully"
}

build_bzip2() {
    echo "Building bzip2 for $ARCH..."
    cd "$BUILD_DIR/bzip2"

    make clean || true

    [ -f Makefile.bak ] && cp Makefile.bak Makefile
    cp Makefile Makefile.bak
sed -i '/^test:/,/^$/c\test:\n\t@echo "Skipping tests during cross-compilation"' Makefile


    make -j"$(nproc)" \
        CC="$CC" \
        AR="$AR" \
        RANLIB="$RANLIB" \
        CFLAGS="$CFLAGS -I$PREFIX/include"

    make install PREFIX="$PREFIX"

    cat > "$PREFIX/lib/pkgconfig/bz2.pc" <<EOF
prefix=$PREFIX
exec_prefix=\${prefix}
libdir=\${exec_prefix}/lib
includedir=\${prefix}/include

Name: bzip2
Description: Lossless data compression library
Version: 1.0.8
Libs: -L\${libdir} -lbz2
Cflags: -I\${includedir}
EOF

    echo "✔ bzip2 built successfully"
}


#build_freetype() {
 #   echo "Building freetype for $ARCH..."
  #  cd "$BUILD_DIR/freetype"
#(make clean && make distclean) || true

 #   ./autogen.sh || true

  #  ./configure \
   ###   --enable-static \
      #  --disable-shared \
       # CFLAGS="$CFLAGS -I$PREFIX/include" \
        #LDFLAGS="$LDFLAGS -L$PREFIX/lib"

   # make -j"$(nproc)"
   # make install

    #echo "✔ freetype built successfully"
#}


build_freetype() {
    echo "Building FreeType for $ARCH..."

    cd "$BUILD_DIR/freetype" || exit 1
    rm -rf build && mkdir build

    SANITIZED_CFLAGS=$(echo "$CFLAGS" | xargs -n1 | sed '/^$/d; s/.*/'"'"'&'"'"'/' | paste -sd, -)
    SANITIZED_LDFLAGS=$(echo "$LDFLAGS" | xargs -n1 | sed '/^$/d; s/.*/'"'"'&'"'"'/' | paste -sd, -)

    meson setup build . \
        --cross-file /dev/fd/63 \
        --prefix="$PREFIX" \
        --buildtype=release \
        -Ddefault_library=static \
        -Dbrotli=disabled \
        -Dbzip2=disabled \
        -Dharfbuzz=disabled \
        -Dpng=disabled \
        -Dzlib=system \
        -Dtests=disabled \
        -Derror_strings=false \
        63<<EOF
[binaries]
c = '$CC_ABS'
cpp = '$CXX_ABS'
ar = '$AR_ABS'
nm = '$NM_ABS'
strip = '$STRIP_ABS'
pkg-config = 'pkg-config'

[built-in options]
c_args = [${SANITIZED_CFLAGS}]
c_link_args = [${SANITIZED_LDFLAGS}]

[host_machine]
system = 'linux'
cpu_family = '${ARCH}'
cpu = '${ARCH}'
endian = 'little'
EOF

    ninja -C build
    ninja -C build install
}



build_libpng() {
    echo "Building libpng for $ARCH..."
    cd "$BUILD_DIR/libpng"

    export CPPFLAGS="-I$PREFIX/include"
    export LDFLAGS="-L$PREFIX/lib"
(make clean && make distclean) || true

    ./configure \
        --prefix="$PREFIX" \
        --host="$HOST" \
        --enable-static \
        --disable-shared \
        --with-zlib-prefix="$PREFIX"

    make -j"$(nproc)"
    make install

    echo "✔ libpng built successfully"
}


build_libass() {
    echo "Building libass for $ARCH..."
    cd "$BUILD_DIR/libass"
(make clean && make distclean) || true

    ./configure \
        --prefix="$PREFIX" \
        --host="$HOST" \
        --enable-static \
        --disable-shared \
        --disable-require-system-font-provider \
        CFLAGS="$CFLAGS -I$PREFIX/include" \
        LDFLAGS="$LDFLAGS -L$PREFIX/lib"

    make -j"$(nproc)"
    make install

    echo "✔ libass built successfully"
}


build_libxml2() {
    echo "Building libxml2 for $ARCH..."
    cd "$BUILD_DIR/libxml2"
(make clean && make distclean) || true

    ./autogen.sh || true

    ./configure \
        --prefix="$PREFIX" \
        --host="$HOST" \
        --enable-static \
        --disable-shared \
        --without-python \
        --without-lzma \
        CFLAGS="$CFLAGS -I$PREFIX/include" \
        LDFLAGS="$LDFLAGS -L$PREFIX/lib"

    make -j"$(nproc)"
    make install

    echo "✔ libxml2 built successfully"
}

build_libexpat() {
    echo "Building expat for $ARCH..."
    cd "$BUILD_DIR/libexpat"
    (make clean && make distclean) || true

    ./configure \
        --prefix="$PREFIX" \
        --host="$HOST" \
        --enable-static \
        --disable-shared \
        --without-examples \
        --without-tests \
        --without-docbook \
        CFLAGS="$CFLAGS" \
        CXXFLAGS="$CXXFLAGS" \
        LDFLAGS="$LDFLAGS" \
        PKG_CONFIG_PATH="$PREFIX/lib/pkgconfig"
    
    make -j"$(nproc)"
    make install
    
    echo "✔ expat built successfully"
}


build_harfbuzz() {
    echo "Building harfbuzz for $ARCH..."
    cd "$BUILD_DIR/harfbuzz"
    
    rm -rf build && mkdir build && cd build

    MESON_CFLAGS=$(echo "$CFLAGS" | sed "s/\s\+/\n/g" | grep -v '^$' | sed "s/.*/'&'/" | tr '\n' ',' | sed 's/,$//')
    MESON_CXXFLAGS=$(echo "$CXXFLAGS" | sed "s/\s\+/\n/g" | grep -v '^$' | sed "s/.*/'&'/" | tr '\n' ',' | sed 's/,$//')
    MESON_LDFLAGS=$(echo "$LDFLAGS" | sed "s/\s\+/\n/g" | grep -v '^$' | sed "s/.*/'&'/" | tr '\n' ',' | sed 's/,$//')

    meson setup . .. \
        --cross-file <(cat <<EOF
[binaries]
c = '$CC_ABS'
ar = '$AR_ABS'
strip = '$STRIP_ABS'
pkg-config = 'pkg-config'

[host_machine]
system = 'linux'
cpu_family = '${ARCH}'
cpu = '${ARCH}'
endian = 'little'

[built-in options]
c_args = [$MESON_CFLAGS]
cpp_args = [$MESON_CXXFLAGS]
c_link_args = [$MESON_LDFLAGS]
cpp_link_args = [$MESON_LDFLAGS]
EOF
    ) \
    --prefix="$PREFIX" \
    --default-library=static \
    --buildtype=release \
    -Dtests=disabled \
    -Ddocs=disabled \
    -Dbenchmark=disabled \
    -Dglib=disabled \
    -Dgobject=disabled \
    -Dicu=disabled \
    -Dgraphite=disabled \
    -Dfreetype=enabled \
    -Dutilities=disabled

    ninja
    ninja install

    echo "✔ harfbuzz built successfully with Meson"
}


build_fontconfig() {
    echo "Building fontconfig for $ARCH..."
    cd "$BUILD_DIR/fontconfig"
    
    rm -rf build && mkdir build && cd build

    # Convert CFLAGS/CXXFLAGS/LDFLAGS to proper Meson array format
    MESON_CFLAGS=$(echo "$CFLAGS" | sed "s/\s\+/\n/g" | grep -v '^$' | sed "s/.*/'&'/" | tr '\n' ',' | sed 's/,$//')
    MESON_CXXFLAGS=$(echo "$CXXFLAGS" | sed "s/\s\+/\n/g" | grep -v '^$' | sed "s/.*/'&'/" | tr '\n' ',' | sed 's/,$//')
    MESON_LDFLAGS=$(echo "$LDFLAGS" | sed "s/\s\+/\n/g" | grep -v '^$' | sed "s/.*/'&'/" | tr '\n' ',' | sed 's/,$//')

    # Ensure PKG_CONFIG_PATH includes libxml2
    export PKG_CONFIG_PATH="$PREFIX/lib/pkgconfig:$PKG_CONFIG_PATH"

    meson setup . .. \
        --cross-file <(cat <<EOF
[binaries]
c = '$CC_ABS'
ar = '$AR_ABS'
strip = '$STRIP_ABS'
pkg-config = 'pkg-config'

[host_machine]
system = 'linux'
cpu_family = '${ARCH}'
cpu = '${ARCH}'
endian = 'little'

[built-in options]
c_args = [$MESON_CFLAGS]
cpp_args = [$MESON_CXXFLAGS]
c_link_args = [$MESON_LDFLAGS]
cpp_link_args = [$MESON_LDFLAGS]
EOF
    ) \
    --prefix="$PREFIX" \
    --default-library=static \
    --buildtype=release \
    -Ddoc=disabled \
    -Dnls=disabled \
    -Dtests=disabled \
    -Dtools=disabled \
    -Dcache-build=disabled \

    ninja
    ninja install

    echo "✔ fontconfig built successfully with Meson"
}

build_udfread() {
    echo "Building libudfread for $ARCH..."
    cd "$BUILD_DIR/budfread" || exit 1

    rm -rf build && mkdir build && cd build || exit 1

    # Convert flags to Meson-style arrays
    MESON_CFLAGS=$(printf "'%s'," $CFLAGS | sed 's/,$//')
    MESON_CXXFLAGS=$(printf "'%s'," $CXXFLAGS | sed 's/,$//')
    MESON_LDFLAGS=$(printf "'%s'," $LDFLAGS | sed 's/,$//')

    # Create a temporary cross file
    CROSS_FILE=cross_file.txt
    cat > "$CROSS_FILE" <<EOF
[binaries]
c = '$CC_ABS'
ar = '$AR_ABS'
strip = '$STRIP_ABS'
pkg-config = 'pkg-config'

[host_machine]
system = 'linux'
cpu_family = '${ARCH}'
cpu = '${ARCH}'
endian = 'little'

[built-in options]
c_args = [${MESON_CFLAGS}]
cpp_args = [${MESON_CXXFLAGS}]
c_link_args = [${MESON_LDFLAGS}]
cpp_link_args = [${MESON_LDFLAGS}]
EOF

    meson setup . .. \
        --cross-file "$CROSS_FILE" \
        --prefix="$PREFIX" \
        --default-library=static \
        --buildtype=release || exit 1

    ninja -j$(nproc)
    ninja install

    echo "✔ libudfread built successfully with Meson"
}


build_bluray() {
    echo "Building libbluray for $ARCH..."
    cd "$BUILD_DIR/bluray"
(make clean && make distclean) || true

    ./bootstrap --disable-doxygen || true

    ./configure \
  --prefix="$PREFIX" \
  --host="$HOST" \
  --enable-static \
  --disable-shared \
  --disable-doxygen-doc \
  --disable-bdjava-jar \
  --disable-bdj-support \
  --disable-utils \
  --disable-examples \
  --disable-tests \
  CFLAGS="$CFLAGS -I$PREFIX/include -fPIC" \
  LDFLAGS="$LDFLAGS -L$PREFIX/lib"


    make -j"$(nproc)" install

    echo "✔ libbluray built successfully"
}

build_libtheora() {
    echo "Building libtheora for $ARCH..."
    cd "$BUILD_DIR/theora"
(make clean && make distclean) || true

    ./configure \
        --prefix="$PREFIX" \
        --host="$HOST" \
        --enable-static \
        --disable-shared \
        --disable-examples \
        --disable-oggtest \
        --disable-vorbistest \
        CFLAGS="$CFLAGS -I$PREFIX/include" \
        LDFLAGS="$LDFLAGS -L$PREFIX/lib"

    make -j"$(nproc)"
    make install

    echo "✔ libtheora built successfully"
}

build_openjpeg() {
    echo "Building openjpeg for $ARCH..."
    cd "$BUILD_DIR/openjpeg"
    rm -rf build

    mkdir -p build && cd build

    cmake .. \
        -DCMAKE_INSTALL_PREFIX="$PREFIX" \
        -DCMAKE_SYSTEM_NAME=Linux \
        -DCMAKE_C_COMPILER="$CC_ABS" \
        -DCMAKE_AR="$AR_ABS" \
        -DCMAKE_RANLIB="$RANLIB_ABS" \
        -DCMAKE_STRIP="$STRIP_ABS" \
        -DCMAKE_BUILD_TYPE=Release \
        -DBUILD_SHARED_LIBS=OFF \
        -DBUILD_STATIC_LIBS=ON \
        -DBUILD_CODEC=OFF \
        -DBUILD_DOC=OFF \
        -DBUILD_PKGCONFIG_FILES=ON \
        -DBUILD_TESTING=OFF \
        -DBUILD_THIRDPARTY=OFF

    make -j"$(nproc)"
    make install

    echo "✔ openjpeg built successfully"
}

build_libwebp() {
    echo "Building libwebp for $ARCH..."
    cd "$BUILD_DIR/libwebp"
    (make clean && make distclean) || true

    ./autogen.sh
    ./configure \
        --prefix="$PREFIX" \
        --disable-shared \
        --enable-static \
        --host="$HOST" \
        CC="$CC_ABS" \
        CXX="$CXX_ABS" \
        AR="$AR_ABS" \
        RANLIB="$RANLIB_ABS" \
        STRIP="$STRIP_ABS" \
        CFLAGS="$CFLAGS" \
        CXXFLAGS="$CXXFLAGS" \
        LDFLAGS="$LDFLAGS"

    make -j$(nproc) && make install
}

build_vmaf() {
    echo "Building libvmaf for $ARCH..."

    TOOLCHAIN_FILE="$BUILD_DIR/vmaf/toolchain-$ARCH.txt"

    echo "Generating Meson cross-file at $TOOLCHAIN_FILE..."
    cat > "$TOOLCHAIN_FILE" <<EOF
[binaries]
c = '$CC_ABS'
cpp = '$CXX_ABS'
ar = '$AR_ABS'
strip = '$STRIP_ABS'
pkg-config = 'pkg-config'
ranlib = '$RANLIB_ABS'

[built-in options]
c_args = [$(printf "'%s', " $CFLAGS)]
cpp_args = [$(printf "'%s', " $CXXFLAGS)]
c_link_args = [$(printf "'%s', " $LDFLAGS)]
cpp_link_args = [$(printf "'%s', " $LDFLAGS)]

[host_machine]
system = 'linux'
cpu_family = '${ARCH}'
cpu = '${ARCH}'
endian = 'little'
EOF

    cd "$BUILD_DIR/vmaf/libvmaf"
    rm -rf build
    meson setup build \
        --prefix="$PREFIX" \
        --default-library=static \
        --buildtype=release \
        --cross-file="$TOOLCHAIN_FILE"

    ninja -C build -j$(nproc)
    ninja -C build install
}

build_libzimg() {
    echo "Building libzimg for $ARCH..."
    cd "$BUILD_DIR/zimg"
    (make clean && make distclean) || true


    ./autogen.sh

    ./configure \
        --prefix="$PREFIX" \
        --host="$HOST" \
        --enable-static \
        --disable-shared \
        CFLAGS="$CFLAGS" \
        LDFLAGS="$LDFLAGS"

    make -j$(nproc)
    make install
}

build_libmysofa() {
    echo "Building libmysofa for $ARCH..."
    cd "$BUILD_DIR/libmysofa"
    rm -rf CMakeCache.txt CMakeFiles build
    mkdir -p build && cd build

        cmake .. -G Ninja \
        -DCMAKE_INSTALL_PREFIX="$PREFIX" \
        -DCMAKE_PREFIX_PATH="$PREFIX" \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_C_COMPILER="$CC_ABS" \
        -DCMAKE_AR="$AR_ABS" \
        -DCMAKE_RANLIB="$RANLIB_ABS" \
        -DCMAKE_STRIP="$STRIP_ABS" \
        -DCMAKE_C_FLAGS="$CFLAGS" \
        -DCMAKE_EXE_LINKER_FLAGS="$LDFLAGS" \
        -DBUILD_SHARED_LIBS=OFF \
        -DBUILD_TESTS=OFF \
        -DMATH='-lm'


    ninja
    ninja install
}



build_vidstab() {
    echo "Building vid.stab for $ARCH..."
    cd "$BUILD_DIR/vidstab"
    
    # Clean CMake cache completely
    rm -rf CMakeCache.txt CMakeFiles/ cmake_install.cmake build.ninja .ninja_deps .ninja_log
    
    echo "Using AR: $AR_ABS"
    
    cmake . -G Ninja \
        -DCMAKE_POLICY_DEFAULT_CMP0091=NEW \
        -DCMAKE_BUILD_TYPE=Release \
        "${COMMON_CMAKE_FLAGS[@]}" \
        -DBUILD_SHARED_LIBS=OFF \
        -DENABLE_SHARED=OFF \
        -DCMAKE_POLICY_VERSION_MINIMUM=3.5 \
        -DENABLE_STATIC=ON
        
    ninja -v
    ninja install
}

build_frei0r() {
    echo "Building frei0r for $ARCH..."
    cd "$BUILD_DIR/frei0r"

    cmake . -G Ninja \
        -DCMAKE_PREFIX_PATH="$PREFIX" \
        "${COMMON_CMAKE_FLAGS[@]}" \
        -DCMAKE_BUILD_TYPE=Release \
        -DWITHOUT_GAVL=ON \
        -DBUILD_SHARED_LIBS=OFF

    ninja
    ninja install
}


build_soxr() {
    echo "Building soxr for $ARCH..."
    cd "$BUILD_DIR/soxr"

    rm -rf build

    cmake -B build -G Ninja . \
        -DCMAKE_BUILD_TYPE=Release \
        -DBUILD_SHARED_LIBS=OFF \
        -DCMAKE_SYSTEM_NAME=Linux \
        "${COMMON_CMAKE_FLAGS[@]}" \
        -DWITH_OPENMP=OFF \
        -DCMAKE_POLICY_VERSION_MINIMUM=3.5 \
        -Wno-dev

    cmake --build build
    cmake --install build

    # Generate .pc file if missing
    PC_DIR="$PREFIX/lib/pkgconfig"
    PC_FILE="$PC_DIR/soxr.pc"

    if [ ! -f "$PC_FILE" ]; then
        echo "Generating soxr.pc..."
        mkdir -p "$PC_DIR"
        cat > "$PC_FILE" <<EOF
prefix=$PREFIX
exec_prefix=\${prefix}
libdir=\${exec_prefix}/lib
includedir=\${prefix}/include

Name: soxr
Description: High quality, one-dimensional sample-rate conversion library
Version: 0.1.3
Libs: -L\${libdir} -lsoxr
Cflags: -I\${includedir}
EOF
    fi

    echo "✔ soxr built successfully"
}


build_openmpt() {
    echo "Building openmpt for $ARCH..."
    cd "$BUILD_DIR/openmpt"
(make clean && make distclean) || true

    ./configure \
        --prefix="$PREFIX" \
        --host="$HOST" \
        --enable-static \
        --disable-shared \
        --disable-openmpt123 \
        --disable-tests \
        --without-mpg123 \
        --without-ogg \
        --without-vorbis \
        --without-pulseaudio \
        --without-portaudio \
        --without-sndfile \
        --without-flac \
        --without-mpg123 \
        --without-portaudio \
         --without-portaudiocpp \
        CFLAGS="$CFLAGS" \
        CXXFLAGS="$CXXFLAGS" \
        LDFLAGS="$LDFLAGS"

    make -j$(nproc)
    make install
}

build_svtav1() {
    echo "Building SVT-AV1 for $ARCH..."

    cd "$BUILD_DIR/svtav1"

    rm -rf build && mkdir build && cd build

    cmake .. \
        -DCMAKE_SYSTEM_NAME=Linux \
        -DCMAKE_BUILD_TYPE=Release \
        "${COMMON_CMAKE_FLAGS[@]}" \
        -DBUILD_SHARED_LIBS=OFF \
        -DBUILD_APPS=OFF \
        -DENABLE_NEON_I8MM=OFF

    make -j"$(nproc)"
    make install
}

build_libsrt() {
    echo "Building libsrt for $ARCH..."

    cd "$BUILD_DIR/srt"

    rm -rf build && mkdir build && cd build

    cmake .. \
        -DCMAKE_SYSTEM_NAME=Linux \
        -DCMAKE_BUILD_TYPE=Release \
        "${COMMON_CMAKE_FLAGS[@]}" \
        -DENABLE_STATIC=ON \
        -DENABLE_SHARED=OFF \
        -DENABLE_APPS=OFF \
        -DENABLE_CXX=ON

    make -j"$(nproc)"
    make install
}

build_libtiff() {
  echo "Building libtiff for $ARCH..."
  cd "$BUILD_DIR/tiff" || exit 1

  make distclean >/dev/null 2>&1 || true

  ./configure \
    --host="$HOST" \
    --prefix="$PREFIX" \
    --disable-shared \
    --enable-static \
    --disable-jbig \
    --disable-lzma \
    --disable-cxx \
    --disable-tools \
    CC="$CC" \
    AR="$AR" \
    RANLIB="$RANLIB" \
    STRIP="$STRIP" \
    CFLAGS="$CFLAGS" \
    LDFLAGS="$LDFLAGS" || exit 1

  make -j"$(nproc)" || exit 1
  make install || exit 1
}


build_libzmq() {
    echo "Building libzmq (ZeroMQ) for $ARCH..."

    cd "$BUILD_DIR/libzmq"

    rm -rf build && mkdir build && cd build

    cmake .. \
        -DCMAKE_SYSTEM_NAME=Linux \
        -DCMAKE_BUILD_TYPE=Release \
        "${COMMON_CMAKE_FLAGS[@]}" \
        -DENABLE_CURVE=OFF \
        -DENABLE_DRAFTS=OFF \
        -DENABLE_SHARED=OFF \
        -DENABLE_STATIC=ON \
        -DBUILD_SHARED=OFF \
        -DBUILD_STATIC=ON \
        -DWITH_LIBSODIUM=OFF \
        -DBUILD_TESTS=OFF \
        -DZMQ_BUILD_TESTS=OFF

    make -j"$(nproc)"
    make install
}

build_libplacebo() {
    echo "Building libplacebo (Meson) for $ARCH..."
    
    cd "$BUILD_DIR/libplacebo"
    
    # Initialize submodules (required for glad and other dependencies)
    git submodule update --init --recursive
    
    rm -rf build && mkdir build
    
    S_CFLAGS=$(echo "$CFLAGS" | xargs -n1 | sed "/^$/d; s/.*/'&'/" | paste -sd, -)
    S_CXXFLAGS=$(echo "$CXXFLAGS" | xargs -n1 | sed "/^$/d; s/.*/'&'/" | paste -sd, -)
    S_LDFLAGS=$(echo "$LDFLAGS" | xargs -n1 | sed "/^$/d; s/.*/'&'/" | paste -sd, -)

    meson setup build . \
        --cross-file /dev/fd/63 \
        --prefix="$PREFIX" \
        --buildtype=release \
        -Ddefault_library=static \
        -Dtests=false \
        -Dshaderc=disabled \
        -Dvulkan=disabled \
        -Dglslang=disabled \
        -Dopengl=enabled \
        63<<EOF
[binaries]
c = '$CC_ABS'
cpp = '$CXX_ABS'
ar = '$AR_ABS'
nm = '$NM_ABS'
strip = '$STRIP_ABS'
pkg-config = 'pkg-config'

[built-in options]
c_args = [${S_CFLAGS}]
cpp_args = [${S_CXXFLAGS}]
c_link_args = [${S_LDFLAGS}]
cpp_link_args = [${S_LDFLAGS}]

[host_machine]
system = 'linux'
cpu_family = '${ARCH}'
cpu = '${ARCH}'
endian = 'little'
EOF

    ninja -C build
    ninja -C build install
}

build_librist() {
    echo "Building librist (Meson) for $ARCH..."
    
    cd "$BUILD_DIR/librist"
    
    rm -rf build && mkdir build
    
    S_CFLAGS=$(echo "$CFLAGS" | xargs -n1 | sed "/^$/d; s/.*/'&'/" | paste -sd, -)
    S_CXXFLAGS=$(echo "$CXXFLAGS" | xargs -n1 | sed "/^$/d; s/.*/'&'/" | paste -sd, -)
    S_LDFLAGS=$(echo "$LDFLAGS" | xargs -n1 | sed "/^$/d; s/.*/'&'/" | paste -sd, -)

    meson setup build . \
        --cross-file /dev/fd/63 \
        --prefix="$PREFIX" \
        --buildtype=release \
        -Ddefault_library=static \
        -Duse_mbedtls=false \
        -Dbuiltin_cjson=true \
        -Dtest=false \
        -Dbuilt_tools=false \
        63<<EOF
[binaries]
c = '$CC_ABS'
cpp = '$CXX_ABS'
ar = '$AR_ABS'
nm = '$NM_ABS'
strip = '$STRIP_ABS'
pkg-config = 'pkg-config'

[built-in options]
c_args = [${S_CFLAGS}]
cpp_args = [${S_CXXFLAGS}]
c_link_args = [${S_LDFLAGS}]
cpp_link_args = [${S_LDFLAGS}]

[host_machine]
system = 'linux'
cpu_family = '${ARCH}'
cpu = '${ARCH}'
endian = 'little'
EOF

    ninja -C build
    ninja -C build install
}






build_libvo_amrwbenc() {
  echo "Building vo-amrwbenc for $ARCH..."

  cd "$BUILD_DIR/vo-amrwbenc" || exit 1
  ( make clean && make distclean ) || true
  # Generate configure script
  autoreconf -fi || exit 1

  

  ./configure \
    --host="$HOST" \
    --prefix="$PREFIX" \
    --enable-static \
    --disable-shared \
    CC="$CC" \
    AR="$AR" \
    RANLIB="$RANLIB" \
    STRIP="$STRIP" \
    CFLAGS="$CFLAGS" \
    LDFLAGS="$LDFLAGS" || exit 1

  make -j"$(nproc)" || exit 1
  make install || exit 1
}


build_opencore_amr() {
  echo "Building opencore-amr for $ARCH..."
  cd "$BUILD_DIR/opencore-amr" || exit 1
    (make distclean && make clean) || true
[ -f "configure.ac.bak" ] && cp "configure.ac.bak" "configure.ac"
cp "configure.ac" "configure.bak"
  sed -i '/AC_FUNC_MALLOC/d' configure.ac
  autoreconf -fi || exit 1
  ./configure \
    --host="$HOST" \
    --prefix="$PREFIX" \
    --enable-static \
    --disable-shared \
    CC="$CC" \
    AR="$AR" \
    RANLIB="$RANLIB" \
    STRIP="$STRIP" \
    CFLAGS="$CFLAGS" \
    LDFLAGS="$LDFLAGS" || exit 1
  make -j"$(nproc)" || exit 1
  make install || exit 1
}

build_libilbc() {
  echo "Building libilbc for $ARCH..."
  cd "$BUILD_DIR/libilibc" || exit 1
  rm -rf build
  mkdir build && cd build || exit 1

  cmake .. \
    -DCMAKE_SYSTEM_NAME=Linux \
    "${COMMON_CMAKE_FLAGS[@]}" \
    -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_SHARED_LIBS=OFF || exit 1

  cmake --build . -j"$(nproc)" || exit 1
  cmake --install . || exit 1
}

build_libcodec2() {
  echo "Building libcodec2 for $ARCH..."

  cd "$BUILD_DIR/libcodec2" || exit 1

  rm -rf build && mkdir build && cd build

  cmake .. \
    -DCMAKE_SYSTEM_NAME=Linux \
    "${COMMON_CMAKE_FLAGS[@]}" \
    -DBUILD_SHARED_LIBS=OFF \
    -DCODEC2_BUILD_TESTS=OFF \
    -DCODEC2_BUILD_EXAMPLES=OFF \
    -DCODEC2_BUILD_MANPAGES=OFF

  make -j"$(nproc)" || exit 1
  make install || exit 1

  # Generate pkg-config file if not present
  PC_DIR="$PREFIX/lib/pkgconfig"
  PC_FILE="$PC_DIR/libcodec2.pc"
  if [ ! -f "$PC_FILE" ]; then
    echo "Generating libcodec2.pc..."
    mkdir -p "$PC_DIR"
    cat > "$PC_FILE" <<EOF
prefix=$PREFIX
exec_prefix=\${prefix}
libdir=\${exec_prefix}/lib
includedir=\${prefix}/include

Name: libcodec2
Description: Low bit rate speech codec
Version: 1.0
Libs: -L\${libdir} -lcodec2
Cflags: -I\${includedir}
EOF
  fi

  echo "✔ libcodec2 built successfully"
}


build_aribb24() {
  echo "Building aribb24 for $ARCH..."

  cd "$BUILD_DIR/aribb24" || exit 1

  # Clean any previous build
  make distclean >/dev/null 2>&1 || true
  autoreconf -fi || exit 1

  ./configure \
    --host="$HOST" \
    --prefix="$PREFIX" \
    --enable-static \
    --disable-shared \
    CC="$CC" \
    AR="$AR" \
    RANLIB="$RANLIB" \
    STRIP="$STRIP" \
    CFLAGS="-static -Os -ffunction-sections -fdata-sections -DNDEBUG" \
    LDFLAGS="-static -Wl,--gc-sections -Wl,--strip-all -Wl,--allow-multiple-definition" || exit 1

  make -j"$(nproc)" || exit 1
  make install || exit 1
}

build_uavs3d() {
    echo "Building uavs3d..."

    cd "$BUILD_DIR/uavs3d" || exit 1
    rm -rf build && mkdir build && cd build

    cmake .. \
        -DCMAKE_SYSTEM_NAME=Linux \
        -DCMAKE_SYSTEM_PROCESSOR="$ARCH" \
        "${COMMON_CMAKE_FLAGS[@]}" \
        -DCMAKE_BUILD_TYPE=Release \
        -DBUILD_SHARED_LIBS=OFF \
        -DCOMPILE_10BIT=OFF


    cmake --build . --target uavs3d -j"$(nproc)"
    cmake --install . || exit 1
}


build_xvidcore() {
  echo "Building xvidcore..."

  cd "$BUILD_DIR/xvidcore/build/generic" || exit 1
  make distclean || true

  ./configure \
    --host="$HOST" \
    --prefix="$PREFIX" \
    --enable-static \
    --disable-shared \
    CC="$CC_ABS" \
    AR="$AR_ABS" \
    RANLIB="$RANLIB_ABS" \
    STRIP="$STRIP_ABS" \
    CFLAGS="-static -Os -ffunction-sections -fdata-sections -DNDEBUG" \
    LDFLAGS="-static -Wl,--gc-sections -Wl,--strip-all -Wl,--allow-multiple-definition" || exit 1

  make -j"$(nproc)" || exit 1
  make install || exit 1
}

build_kvazaar() {
    echo "Building kvazaar..."
    cd "$BUILD_DIR/kvazaar" || exit 1
    (make clean && make distclean) || true
    if [ ! -f configure ]; then
        ./autogen.sh || exit 1
    fi
    ./configure \
        --prefix="$PREFIX" \
        --enable-static \
        --disable-shared \
        --host="$HOST"
    make -j"$(nproc)" || exit 1
    make install || exit 1
}

build_orc() {
    echo "Building orc (Meson) for $ARCH..."
    
    cd "$BUILD_DIR/orc" || exit 1
    
    rm -rf build && mkdir build
    
    SANITIZED_CFLAGS=$(echo "$CFLAGS" | xargs -n1 | sed "/^$/d; s/.*/'&'/" | paste -sd, -)
    SANITIZED_CXXFLAGS=$(echo "$CXXFLAGS" | xargs -n1 | sed "/^$/d; s/.*/'&'/" | paste -sd, -)
    SANITIZED_LDFLAGS=$(echo "$LDFLAGS" | xargs -n1 | sed "/^$/d; s/.*/'&'/" | paste -sd, -)

    meson setup build . \
        --cross-file /dev/fd/63 \
        --prefix="$PREFIX" \
        --buildtype=release \
        -Ddefault_library=static \
        -Dtests=disabled \
        -Dexamples=disabled \
        -Dtools=enabled \
        -Dbenchmarks=disabled \
        -Dgtk_doc=disabled \
        63<<EOF
[binaries]
c = '$CC_ABS'
cpp = '$CXX_ABS'
ar = '$AR_ABS'
nm = '$NM_ABS'
strip = '$STRIP_ABS'
pkg-config = 'pkg-config'

[built-in options]
c_args = [${SANITIZED_CFLAGS}]
cpp_args = [${SANITIZED_CXXFLAGS}]
c_link_args = [${SANITIZED_LDFLAGS}]
cpp_link_args = [${SANITIZED_LDFLAGS}]

[host_machine]
system = 'linux'
cpu_family = '${ARCH}'
cpu = '${ARCH}'
endian = 'little'
EOF

    ninja -C build
    ninja -C build install
}

build_schroedinger() {
  echo "Building schroedinger for $ARCH..."
  cd "$BUILD_DIR/schroedinger" || exit 1

  make distclean || true

  ./configure \
    --prefix="$PREFIX" \
    --disable-shared \
    --enable-static \
    CC="$CC_ABS" \
    AR="$AR_ABS" \
    RANLIB="$RANLIB_ABS" \
    STRIP="$STRIP_ABS" \
    CFLAGS="$CFLAGS" \
    LDFLAGS="$LDFLAGS"

  make -j$(nproc) && make install
}

build_xavs() {
    echo "Building xavs for $ARCH..."

    cd "$BUILD_DIR/xavs/trunk" || exit 1
    make distclean || true

    EXTRA_CONFIGURE_FLAGS=""
if [ "$ARCH" != "x86" ] && [ "$ARCH" != "x86_64" ]; then
    EXTRA_CONFIGURE_FLAGS="--disable-asm"
fi


    ./configure \
  --prefix="$PREFIX" \
  --enable-static \
  --disable-shared \
  $EXTRA_CONFIGURE_FLAGS \
  CC="$CC_ABS" \
  AR="$AR_ABS" \
  RANLIB="$RANLIB_ABS" \
  STRIP="$STRIP_ABS" \
  CFLAGS="$CFLAGS" \
  LDFLAGS="$LDFLAGS"


    make -j"$(nproc)" && make install
}

build_xavs2() {
    echo "Building xavs2 for $ARCH..."

    cd "$BUILD_DIR/xavs2/build/linux" || exit 1
    (make distclean && make clean) || true

    export CC="$CC_ABS"
    export AR="$AR_ABS"
    export RANLIB="$RANLIB_ABS"
    export STRIP="$STRIP_ABS"
    local CROSS_PREFIX="/opt/${HOST}-cross/bin/${HOST}-"
    local ASM_FLAG=""

    if [ "$ARCH" != "x86" ] && [ "$ARCH" != "x86_64" ]; then
        ASM_FLAG="--disable-asm"
    fi

    [ -f configure.bak ] && cp "configure.bak" "configure"
    cp "configure" "configure.bak"

        ./configure \
        --prefix="$PREFIX" \
        --host="$TARGET" \
        --cross-prefix="${CROSS_PREFIX}" \
        --extra-cflags="-fPIC -Os -ffunction-sections -fdata-sections -DNDEBUG" \
        --extra-ldflags="-static -Wl,--gc-sections -Wl,--strip-all -Wl,--allow-multiple-definition" \
          $ASM_FLAG \
        --enable-static \
        --sysroot="$SYSROOT" \
        --host="$HOST" \
        --disable-cli

    sed -i 's/^\(ASFLAGS[[:space:]]*=\)/\1 -DPIC/' config.mak

    make -j"$(nproc)" && make install
}

build_davs2() {
    echo "Building davs2 for $ARCH..."

    cd "$BUILD_DIR/davs2/build/linux" || exit 1
    (make distclean && make clean) || true

    export CC="$CC_ABS"
    export AR="$AR_ABS"
    export RANLIB="$RANLIB_ABS"
    export STRIP="$STRIP_ABS"
    local CROSS_PREFIX="/opt/${HOST}-cross/bin/${HOST}-"
    local ASM_FLAG=""

    if [ "$ARCH" != "x86" ] && [ "$ARCH" != "x86_64" ]; then
        ASM_FLAG="--disable-asm"
    fi

    [ -f configure.bak ] && cp "configure.bak" "configure"
    cp "configure" "configure.bak"

        ./configure \
        --prefix="$PREFIX" \
        --host="$TARGET" \
        --cross-prefix="${CROSS_PREFIX}" \
        --extra-cflags="-fPIC -Os -ffunction-sections -fdata-sections -DNDEBUG" \
        --extra-ldflags="-static -Wl,--gc-sections -Wl,--strip-all -Wl,--allow-multiple-definition" \
          $ASM_FLAG \
        --enable-static \
        --sysroot="$SYSROOT" \
        --host="$HOST" \
        --disable-cli

    sed -i 's/^\(ASFLAGS[[:space:]]*=\)/\1 -DPIC/' config.mak

    make -j"$(nproc)" && make install
}




build_rtmp() {
    echo "Building librtmp for $ARCH..."
    
    cd "$BUILD_DIR/rtmpdump/librtmp" 
    (make clean && make distclean) || true
    make librtmp.a \
        CC="$CC_ABS" \
        AR="$AR_ABS" \
        RANLIB="$RANLIB_ABS" \
        CFLAGS="$CFLAGS -DUSE_OPENSSL -I$PREFIX/include -I$PREFIX/include/openssl" \
        LDFLAGS="$LDFLAGS" \
        XLIBS="-L$PREFIX/lib -lssl -lcrypto -lz -ldl -lpthread" \
        -j$(nproc)
    
    mkdir -p "$PREFIX/include/librtmp"
    cp "$(pwd)"/*.h "$PREFIX/include/librtmp/"
    mkdir -p "$PREFIX/lib"
    cp "$(pwd)/librtmp.a" "$PREFIX/lib/"
    
    mkdir -p "$PREFIX/lib/pkgconfig"
    cat > "$PREFIX/lib/pkgconfig/librtmp.pc" << EOF
prefix=$PREFIX
exec_prefix=\${prefix}
libdir=\${exec_prefix}/lib
includedir=\${prefix}/include

Name: librtmp
Description: RTMP implementation
Version: 2.4
Requires: openssl zlib
Libs: -L\${libdir} -lrtmp
Libs.private: -lssl -lcrypto -lz -ldl -lpthread
Cflags: -I\${includedir}
EOF
}

build_libssh() {
    echo "Building libssh for $ARCH..."
    cd "$BUILD_DIR/libssh"

    rm -rf build && mkdir build && cd build

    SYSROOT_FLAGS="--sysroot=$SYSROOT"

    cmake .. \
        -DCMAKE_SYSTEM_NAME=Linux \
        -DCMAKE_SYSTEM_PROCESSOR="$TARGET" \
        "${COMMON_CMAKE_FLAGS[@]}" \
        -DBUILD_SHARED_LIBS=OFF \
        -DWITH_GSSAPI=OFF \
        -DWITH_EXAMPLES=OFF \
        -DWITH_ZLIB=ON \
        -DOPENSSL_ROOT_DIR="$PREFIX" \
        -DOPENSSL_INCLUDE_DIR="$PREFIX/include" \
        -DOPENSSL_LIBRARIES="$PREFIX/lib"

    make -j"$(nproc)"
    make install
}


build_vvenc() {
    cd "$BUILD_DIR/vvenc"
    rm -rf build && mkdir build && cd build
    cmake .. \
        -DCMAKE_BUILD_TYPE=Release \
        "${COMMON_CMAKE_FLAGS[@]}" \
        -DBUILD_SHARED_LIBS=OFF \
        -DVVENC_LIBRARY_ONLY=ON \
        -DVVENC_ENABLE_LINK_TIME_OPT=OFF
    cmake --build . --target install -- -j$(nproc)
}

build_vvdec() {
    cd "$BUILD_DIR/vvdec"
    rm -rf build && mkdir build && cd build
    cmake .. \
        -DCMAKE_BUILD_TYPE=Release \
        "${COMMON_CMAKE_FLAGS[@]}" \
        -DBUILD_SHARED_LIBS=OFF \
        -DVVDEC_ENABLE_LINK_TIME_OPT=OFF \
        -DVVDEC_ENABLE_BITSTREAM_DOWNLOAD=OFF
    cmake --build . --target install -- -j$(nproc)
}



build_vapoursynth() {
    cd "$BUILD_DIR/vapoursynth"
    (make clean && make distclean) || true
    rm -rf build && mkdir build

    SANITIZED_CFLAGS=$(echo "$CFLAGS" | xargs -n1 | sed "/^$/d; s/.*/'&'/" | paste -sd, -)
    SANITIZED_CXXFLAGS=$(echo "$CXXFLAGS" | xargs -n1 | sed "/^$/d; s/.*/'&'/" | paste -sd, -)
    SANITIZED_LDFLAGS=$(echo "$LDFLAGS" | xargs -n1 | sed "/^$/d; s/.*/'&'/" | paste -sd, -)

    ASM_ENABLED=false
    case "$ARCH" in
        x86|x86_64) ASM_ENABLED=true ;;
    esac

    meson setup build . \
        --cross-file /dev/fd/63 \
        --prefix="$PREFIX" \
        --buildtype=release \
        -Dstatic_build=true \
        -Dcore=true \
        -Dvsscript=false \
        -Dvspipe=false \
        -Dpython_module=false \
        -Dx86_asm=$ASM_ENABLED \
        63<<EOF
[binaries]
c = '$CC_ABS'
cpp = '$CXX_ABS'
ar = '$AR_ABS'
nm = '$NM_ABS'
strip = '$STRIP_ABS'
pkg-config = 'pkg-config'

[built-in options]
c_args = [${SANITIZED_CFLAGS}]
cpp_args = [${SANITIZED_CXXFLAGS}]
c_link_args = [${SANITIZED_LDFLAGS}]
cpp_link_args = [${SANITIZED_LDFLAGS}]

[host_machine]
system = 'linux'
cpu_family = '${ARCH}'
cpu = '${ARCH}'
endian = 'little'
EOF

    ninja -C build
    ninja -C build install
}


build_libffi() {
    cd "$BUILD_DIR/libffi"
    autoreconf -fiv
    mkdir -p "build" && cd build
    ../configure \
    --prefix="$PREFIX" \
    --disable-shared \
    --enable-static \
    --host="$HOST"
    CFLAGS="$CFLAGS" \
    CXXFLAGS="$CXXFLAGS" \
    LDFLAGS="$LDFLAGS" \
    CC="$CC_ABS" \
    CXX="$CXX_ABS"

    make -j$(nproc)
    make install
}

build_glib() {
    echo "Building glib (Meson) for $ARCH..."

    cd "$BUILD_DIR/glib" || exit 1

    rm -rf build && mkdir build

    SANITIZED_CFLAGS=$(echo "$CFLAGS" | xargs -n1 | sed "/^$/d; s/.*/'&'/" | paste -sd, -)
    SANITIZED_CXXFLAGS=$(echo "$CXXFLAGS" | xargs -n1 | sed "/^$/d; s/.*/'&'/" | paste -sd, -)
    SANITIZED_LDFLAGS=$(echo "$LDFLAGS" | xargs -n1 | sed "/^$/d; s/.*/'&'/" | paste -sd, -)

    meson setup build . \
        --cross-file /dev/fd/63 \
        --prefix="$PREFIX" \
        --buildtype=release \
        -Ddefault_library=static \
        -Dtests=false \
        -Dintrospection=disabled \
        -Dglib_debug=disabled \
        -Dlibmount=disabled \
        -Dselinux=disabled \
        -Dman=false \
        63<<EOF
[binaries]
c = '$CC_ABS'
cpp = '$CXX_ABS'
ar = '$AR_ABS'
nm = '$NM_ABS'
strip = '$STRIP_ABS'
pkg-config = 'pkg-config'

[built-in options]
c_args = [${SANITIZED_CFLAGS}]
cpp_args = [${SANITIZED_CXXFLAGS}]
c_link_args = [${SANITIZED_LDFLAGS}]
cpp_link_args = [${SANITIZED_LDFLAGS}]

[host_machine]
system = 'linux'
cpu_family = '${ARCH}'
cpu = '${ARCH}'
endian = 'little'
EOF

    ninja -C build
    ninja -C build install
}

build_lensfun () {
    cd "$BUILD_DIR/lensfun"
    rm -rf build && mkdir build && cd build

    cmake_args=(
      -DCMAKE_INSTALL_PREFIX="$PREFIX"
      -DCMAKE_BUILD_TYPE=RELEASE
      -DBUILD_STATIC=ON
      -DCMAKE_C_COMPILER="$CC_ABS"
      -DCMAKE_CXX_COMPILER="$CXX_ABS"
      -DCMAKE_AR="$AR_ABS"
      -DCMAKE_RANLIB="$RANLIB_ABS"
      -DCMAKE_STRIP="$STRIP_ABS"
      -DCMAKE_C_FLAGS="$CFLAGS"
      -DCMAKE_CXX_FLAGS="$CXXFLAGS"
      -DCMAKE_EXE_LINKER_FLAGS="$LDFLAGS"
    )

    case "$ARCH" in
      x86|x86_64|i686)
        # SSE is supported — do nothing
        ;;
      *)
        # Disable SSE on non-x86 targets
        cmake_args+=(
          -DBUILD_FOR_SSE=OFF
          -DBUILD_FOR_SSE2=OFF
        )
        ;;
    esac

    cmake ../ "${cmake_args[@]}"
    make -j$(nproc)
    make install
}


 build_flite() {
    echo "Building flite for $ARCH..."

    cd "$BUILD_DIR/flite" || exit 1

    (make clean && make distclean) || true

    ./configure \
        --host="$TARGET" \
        --prefix="$PREFIX" \
        --disable-shared \
        --with-audio=none \
        CC="$CC" \
        CFLAGS="$CFLAGS" \
        LDFLAGS="$LDFLAGS" \
        AR="$AR" \
        RANLIB="$RANLIB" \
        STRIP="$STRIP" \
        --host="$HOST"

    make -j"$(nproc)"
    make install
}

build_libv4l() {
    echo "Building libv4l for $ARCH..."

    patch_libv4l_argp() {
        local file="$BUILD_DIR/libv4l/meson.build"
        echo "Patching argp check in $file"
        [ -f "$file.bak" ] && cp "$file.bak" "$file"
        cp "$file" "$file.bak"
        sed -i '/if cc.has_function.*argp_parse/,/endif/d' "$file"
        sed -i "/conf.set.*HAVE_BACKTRACE.*/a \\
    dep_argp = dependency('', required: false)
    " "$file"
    }

    patch_libv4l_argp

    cd "$BUILD_DIR/libv4l" || exit 1
    rm -rf build && mkdir build

    SANITIZED_CFLAGS=$(echo "$CFLAGS" | xargs -n1 | sed "/^$/d; s/.*/'&'/" | paste -sd, -)
    SANITIZED_CXXFLAGS=$(echo "$CXXFLAGS" | xargs -n1 | sed "/^$/d; s/.*/'&'/" | paste -sd, -)
    SANITIZED_LDFLAGS=$(echo "$LDFLAGS" | xargs -n1 | sed "/^$/d; s/.*/'&'/" | paste -sd, -)

    meson setup build . \
        --cross-file /dev/fd/63 \
        --prefix="$PREFIX" \
        --buildtype=release \
        -Ddefault_library=static \
        -Dbpf=disabled \
        -Dgconv=disabled \
        -Djpeg=disabled \
        -Dlibdvbv5=disabled \
        -Dqv4l2=disabled \
        -Dqvidcap=disabled \
        -Dv4l2-tracer=disabled \
        -Dv4l-plugins=false \
        -Dv4l-utils=false \
        -Dv4l-wrappers=true \
        -Dv4l2-compliance-32=false \
        -Dv4l2-compliance-32-time64=false \
        -Dv4l2-compliance-libv4l=false \
        -Dv4l2-ctl-32=false \
        -Dv4l2-ctl-32-time64=false \
        -Dv4l2-ctl-libv4l=false \
        -Dv4l2-ctl-stream-to=false \
        -Ddoxygen-doc=disabled \
        -Ddoxygen-html=false \
        -Ddoxygen-man=false \
        63<<EOF
[binaries]
c = '$CC_ABS'
cpp = '$CXX_ABS'
ar = '$AR_ABS'
nm = '$NM_ABS'
strip = '$STRIP_ABS'
pkg-config = 'pkg-config'

[built-in options]
c_args = [${SANITIZED_CFLAGS}]
cpp_args = [${SANITIZED_CXXFLAGS}]
c_link_args = [${SANITIZED_LDFLAGS}]
cpp_link_args = [${SANITIZED_LDFLAGS}]

[host_machine]
system = 'linux'
cpu_family = '${ARCH}'
cpu = '${ARCH}'
endian = 'little'
EOF

    ninja -C build
    ninja -C build install

    echo "✔ libv4l built and installed successfully"
}


build_libbs2b() {
    echo "Building libbs2b for $ARCH..."

    cd "$BUILD_DIR/libbs2b" || exit 1

    (make clean && make distclean) || true 


    [ -f configure.ac.bak ] && cp configure.ac.bak configure.ac
        cp configure.ac configure.ac.bak

    sed -i '/PKG_CHECK_EXISTS(\[sndfile\]/,/])$/d' configure.ac
    sed -i 's/dist-lzma//g' configure.ac
    sed -i '/AC_FUNC_MALLOC/d' configure.ac



    autoreconf -fiv

    ./configure \
        --host="$HOST" \
        --prefix="$PREFIX" \
        --disable-shared \
        --enable-static \
        CC="$CC_ABS" \
        CXX="$CXX_ABS" \
        AR="$AR_ABS" \
        RANLIB="$RANLIB_ABS" \
        STRIP="$STRIP_ABS"

    # Build and install
        sed -i '/^bin_PROGRAMS *=/d' src/Makefile.am
    sed -i '/bs2bconvert/d' src/Makefile.am
    make -j"$(nproc)"
    make install
}

build_libgme() {
    echo "Building libgme for $ARCH..."

    local SRC="$BUILD_DIR/libgme"
    local BUILD="$SRC/build"
    rm -rf "$BUILD"
    mkdir -p "$BUILD"
    cd "$BUILD" || exit 1

    cmake .. \
        -DCMAKE_SYSTEM_NAME=Linux \
        -DCMAKE_SYSTEM_PROCESSOR="$TARGET" \
        "${COMMON_CMAKE_FLAGS[@]}" \
        -DBUILD_SHARED_LIBS=OFF \
        -DCMAKE_BUILD_TYPE=Release

    make -j$(nproc)
    make install
}

build_opencl() {
    cd "$BUILD_DIR/opencl"
    echo "[+] Installing OpenCL headers..."
    mkdir -p "$PREFIX/include/CL"
    cp -v CL/*.h "$PREFIX/include/CL/"

    echo "[+] Building POCL..."
    rm -rf build && mkdir build && cd build

    cmake .. \
        -DCMAKE_INSTALL_PREFIX="$PREFIX" \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_C_COMPILER="$CC_ABS" \
        -DCMAKE_AR="$AR_ABS" \
        -DCMAKE_RANLIB="$RANLIB_ABS" \
        -DCMAKE_STRIP="$STRIP_ABS" \
        -DCMAKE_C_FLAGS="$SYSROOT_FLAGS $CFLAGS" \
        -DCMAKE_EXE_LINKER_FLAGS="$LDFLAGS" \
        -DBUILD_SHARED_LIBS=OFF

    make -j$(nproc)
    make install
}

    build_llvm() {
    local LLVM_SRC="$BUILD_DIR/llvm-project"
    local LLVM_BUILD="$LLVM_SRC/build"
    local LLVM_PREFIX="$PREFIX/llvm"

    echo "[+] Building LLVM for $TARGET"

    cd "$LLVM_SRC"
    rm -rf "$LLVM_BUILD"
    mkdir -p "$LLVM_BUILD"
    cd "$LLVM_BUILD"

    cmake ../llvm \
        -G Ninja \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_INSTALL_PREFIX="$LLVM_PREFIX" \
        -DLLVM_TARGETS_TO_BUILD="AArch64" \
        -DLLVM_ENABLE_PROJECTS="clang" \
        -DCMAKE_SYSTEM_NAME=Linux \
        -DCMAKE_C_COMPILER="$CC_ABS" \
        -DCMAKE_CXX_COMPILER="$CXX_ABS" \
         -DCMAKE_AR="$AR_ABS" \
        -DCMAKE_RANLIB="$RANLIB_ABS" \
        -DCMAKE_STRIP="$STRIP_ABS" \
        -DCMAKE_C_FLAGS="$SYSROOT_FLAGS $CFLAGS" \
        -DCMAKE_EXE_LINKER_FLAGS="$LDFLAGS" \
        -DLLVM_ENABLE_ZLIB=OFF \
        -DLLVM_ENABLE_TERMINFO=OFF \
        -DLLVM_ENABLE_THREADS=OFF \
        -DBUILD_SHARED_LIBS=OFF \
        -DLLVM_BUILD_LLVM_DYLIB=OFF \
        -DLLVM_INCLUDE_EXAMPLES=OFF \
        -DLLVM_INCLUDE_TESTS=OFF \
        -DLLVM_INCLUDE_DOCS=OFF \
        -DLLVM_ENABLE_BINDINGS=OFF \
        -DCMAKE_SYSROOT="$SYSROOT"

    ninja -j"$JOBS"
    ninja install

    echo "[+] LLVM installed to $LLVM_PREFIX"
}

build_highway() {
    cd "$BUILD_DIR/highway" || exit 1

    cmake -B build -S . \
        "${COMMON_CMAKE_FLAGS[@]}" \
        -DCMAKE_BUILD_TYPE=Release \
        -DBUILD_SHARED_LIBS=OFF \
        -DHWY_ENABLE_CONTRIB=OFF \
        -DHWY_ENABLE_TESTS=OFF

    cmake --build build -j$(nproc)
    cmake --install build
}


build_libjxl(){
    cd "$BUILD_DIR/libjxl"
    rm -rf build && mkdir -p build && cd build
    cmake .. \
    "${COMMON_CMAKE_FLAGS[@]}" \
    -DBUILD_SHARED_LIBS=OFF \
    -DJXL_FORCE_SYSTEM_GTEST=OFF \
    -DBUILD_TESTING=OFF


    make -j$(nproc)
    make install
}

build_libqrencode() {
    echo "Building libqrencode for $ARCH".....
    cd "$BUILD_DIR/libqrencode"
    rm -rf build && mkdir -p build && cd build
    cmake .. \
    "${COMMON_CMAKE_FLAGS[@]}" \
    -DWITH_TOOLS="NO" \
    -DBUILD_SHARED_LIBS="NO"

    make -j$(nproc)
    make install

}


build_quirc() {
    echo "Building quirc for $ARCH"..........
    cd "$BUILD_DIR/quirc"
    (make clean && make distclean) || true
    make \
        CC="$CC_ABS" \
        AR="$AR_ABS" \
        STRIP="$STRIP_ABS" \
        CFLAGS="$CFLAGS -fPIC" \
        QUIRC_CFLAGS="-Ilib $CFLAGS -fPIC" \
        libquirc.a

    mkdir -p "$PREFIX/lib/pkgconfig" "$PREFIX/include"
    cp libquirc.a "$PREFIX/lib/"
    cp lib/quirc.h "$PREFIX/include/"

    cat > "$PREFIX/lib/pkgconfig/quirc.pc" <<EOF
prefix=$PREFIX
exec_prefix=\${prefix}
libdir=\${exec_prefix}/lib
includedir=\${prefix}/include

Name: quirc
Description: QR-code recognition library
Version: 1.2
Libs: -L\${libdir} -lquirc
Cflags: -I\${includedir}
EOF
}

build_libcaca() {
    echo "Building libcaca for $ARCH..."

    cd "$BUILD_DIR/libcaca"

    (make clean && make distclean) || true

    autoreconf -fi


    CC="$CC_ABS" \
    CXX="$CXX_ABS" \
    ./configure \
        --host="$HOST" \
        --disable-shared \
        --enable-static \
        --disable-curses \
        --disable-ncurses \
        --disable-slang \
        --disable-x11 \
        --disable-imlib2 \
        --disable-doc \
        --prefix="$PREFIX"

    make -j"$(nproc)"
    make install
}


build_fftw() {
    cd "$BUILD_DIR/fftw"
    echo "Building fftw for $ARCH.........."

    rm -rf build && mkdir -p build && cd build

    cmake .. \
        -DCMAKE_INSTALL_PREFIX="$PREFIX" \
        -DBUILD_SHARED_LIBS=OFF \
        -DENABLE_FLOAT=OFF \
        -DENABLE_LONG_DOUBLE=OFF \
        -DENABLE_THREADS=OFF \
        -DWITH_PIC=ON \
        "${COMMON_CMAKE_FLAGS[@]}"

    make -j$(nproc)
    make install
}


build_chromaprint() {
    cd "$BUILD_DIR/chromaprint"
    echo "Building Chromaprint for $ARCH.........."

    rm -rf build && mkdir -p build && cd build

    cmake .. \
        -DCMAKE_INSTALL_PREFIX="$PREFIX" \
        -DBUILD_SHARED_LIBS=OFF \
        -DBUILD_TOOLS=OFF \
        -DBUILD_TESTS=OFF \
        -DFFT_BACKEND=fftw \
        -DCMAKE_PREFIX_PATH="$PREFIX" \
        -DCMAKE_POSITION_INDEPENDENT_CODE=ON \
        "${COMMON_CMAKE_FLAGS[@]}"

    make -j$(nproc)
    make install
}


build_pixman() {
    echo "Building pixman for $ARCH..."

    cd "$BUILD_DIR/pixman" || exit 1
    rm -rf build && mkdir build

    SANITIZED_CFLAGS=$(echo "$CFLAGS" | xargs -n1 | sed "/^$/d; s/.*/'&'/" | paste -sd, -)
    SANITIZED_CXXFLAGS=$(echo "$CXXFLAGS" | xargs -n1 | sed "/^$/d; s/.*/'&'/" | paste -sd, -)
    SANITIZED_LDFLAGS=$(echo "$LDFLAGS" | xargs -n1 | sed "/^$/d; s/.*/'&'/" | paste -sd, -)

    # Set SIMD features based on architecture
    ARM_FEATURES="disabled"
    NEON_FEATURE="disabled"
    A64_NEON_FEATURE="disabled"

    case "$ARCH" in
        arm*|armv7*) ARM_FEATURES="enabled" ;;
        aarch64)     A64_NEON_FEATURE="enabled" ;;
    esac

    meson setup build . \
        --cross-file /dev/fd/63 \
        --prefix="$PREFIX" \
        --buildtype=release \
        -Ddefault_library=static \
        -Dtests=disabled \
        -Ddemos=disabled \
        -Dgtk=disabled \
        -Dlibpng=disabled \
        -Dgnuplot=false \
        -Dtimers=false \
        -Dopenmp=disabled \
        -Dloongson-mmi=disabled \
        -Dmmx=disabled \
        -Dsse2=disabled \
        -Dssse3=disabled \
        -Dvmx=disabled \
        -Darm-simd=${ARM_FEATURES} \
        -Dneon=${ARM_FEATURES} \
        -Da64-neon=${A64_NEON_FEATURE} \
        -Dmips-dspr2=disabled \
        -Drvv=disabled \
        -Dtls=enabled \
        -Dgnu-inline-asm=enabled \
        63<<EOF
[binaries]
c = '$CC_ABS'
cpp = '$CXX_ABS'
ar = '$AR_ABS'
nm = '$NM_ABS'
strip = '$STRIP_ABS'
pkg-config = 'pkg-config'

[built-in options]
c_args = [${SANITIZED_CFLAGS}]
cpp_args = [${SANITIZED_CXXFLAGS}]
c_link_args = [${SANITIZED_LDFLAGS}]
cpp_link_args = [${SANITIZED_LDFLAGS}]

[host_machine]
system = 'linux'
cpu_family = '${ARCH}'
cpu = '${ARCH}'
endian = 'little'
EOF

    ninja -C build
    ninja -C build install
}

build_cairo() {
    echo "Building cairo for $ARCH..."

    cd "$BUILD_DIR/cairo" || exit 1
    rm -rf build && mkdir build

    SANITIZED_CFLAGS=$(echo "$CFLAGS" | xargs -n1 | sed "/^$/d; s/.*/'&'/" | paste -sd, -)
    SANITIZED_CXXFLAGS=$(echo "$CXXFLAGS" | xargs -n1 | sed "/^$/d; s/.*/'&'/" | paste -sd, -)
    SANITIZED_LDFLAGS=$(echo "$LDFLAGS" | xargs -n1 | sed "/^$/d; s/.*/'&'/" | paste -sd, -)

    meson setup build . \
        --cross-file /dev/fd/63 \
        --prefix="$PREFIX" \
        --buildtype=release \
        -Ddefault_library=static \
        -Dtests=disabled \
        -Dspectre=disabled \
        -Dfreetype=enabled \
        -Dfontconfig=enabled \
        -Dlzo=disabled \
        -Dgtk2-utils=disabled \
        -Dtee=disabled \
        -Dxlib=disabled \
        -Dxcb=disabled \
        -Dxlib-xcb=disabled \
        -Dquartz=disabled \
        -Dpng=enabled \
        -Dzlib=enabled \
        63<<EOF
[binaries]
c = '$CC_ABS'
cpp = '$CXX_ABS'
ar = '$AR_ABS'
nm = '$NM_ABS'
strip = '$STRIP_ABS'
pkg-config = 'pkg-config'

[built-in options]
c_args = [${SANITIZED_CFLAGS}]
cpp_args = [${SANITIZED_CXXFLAGS}]
c_link_args = [${SANITIZED_LDFLAGS}]
cpp_link_args = [${SANITIZED_LDFLAGS}]

[host_machine]
system = 'linux'
cpu_family = '${ARCH}'
cpu = '${ARCH}'
endian = 'little'
EOF

    ninja -C build
    ninja -C build install
}

build_pango() {
    echo "Building Pango for $ARCH..."

    cd "$BUILD_DIR/pango" || exit 1
    rm -rf build && mkdir build

     PANGO_LDFLAGS="$LDFLAGS -Wl,-Bstatic -latomic -Wl,-Bdynamic"

    SANITIZED_CFLAGS=$(echo "$CFLAGS" | xargs -n1 | sed "/^$/d; s/.*/'&'/" | paste -sd, -)
    SANITIZED_CXXFLAGS=$(echo "$CXXFLAGS" | xargs -n1 | sed "/^$/d; s/.*/'&'/" | paste -sd, -)
    SANITIZED_LDFLAGS=$(echo "$PANGO_LDFLAGS" | xargs -n1 | sed "/^$/d; s/.*/'&'/" | paste -sd, -)

    meson setup build . \
        --cross-file /dev/fd/63 \
        --prefix="$PREFIX" \
        --buildtype=release \
        -Ddefault_library=static \
        -Dintrospection=disabled \
        -Ddocumentation=false \
        -Dfontconfig=enabled \
        -Dfreetype=enabled \
        63<<EOF
[binaries]
c = '$CC_ABS'
cpp = '$CXX_ABS'
ar = '$AR_ABS'
nm = '$NM_ABS'
strip = '$STRIP_ABS'
pkg-config = 'pkg-config'

[built-in options]
c_args = [${SANITIZED_CFLAGS}]
cpp_args = [${SANITIZED_CXXFLAGS}]
c_link_args = [${SANITIZED_LDFLAGS}]
cpp_link_args = [${SANITIZED_LDFLAGS}]

[host_machine]
system = 'linux'
cpu_family = '${ARCH}'
cpu = '${ARCH}'
endian = 'little'
EOF

    ninja -C build
    ninja -C build install
}

build_libunwind() {
    echo "Building libunwind for $ARCH..."
    
    cd "$BUILD_DIR/libunwind" || exit 1
    autoreconf -fi
    
    ./configure \
        --host="$HOST" \
        --prefix="$PREFIX" \
        --enable-static \
        --disable-shared \
        --disable-tests \
        --disable-documentation
    
    make -j$(nproc)
    make install
}


build_librsvg() {
 

    echo "Building librsvg for $ARCH..."

    cd "$BUILD_DIR/librsvg" || exit 1
    rm -rf build && mkdir build

    

    SANITIZED_CFLAGS=$(echo "$CFLAGS" | xargs -n1 | sed "/^$/d; s/.*/'&'/" | paste -sd, -)
    SANITIZED_CXXFLAGS=$(echo "$CXXFLAGS" | xargs -n1 | sed "/^$/d; s/.*/'&'/" | paste -sd, -)
    SANITIZED_LDFLAGS=$(echo "$LDFLAGS" | xargs -n1 | sed "/^$/d; s/.*/'&'/" | paste -sd, -)
    echo "[DEBUG] Rust Target IS $RUST_TARGET"...
    echo "[DEBUG] checking var $CARGO_TARGET_VAR"........
    export PKG_CONFIG_LIBDIR="$PREFIX/lib/pkgconfig"
    export PKG_CONFIG_SYSROOT_DIR="$PREFIX"
    

    meson setup build . \
        --cross-file /dev/fd/63 \
        --prefix="$PREFIX" \
        --buildtype=release \
        -Ddefault_library=static \
        -Dintrospection=disabled \
        -Dtests=false \
        -Drust_std=enabled \
        -Ddocs=disabled \
        -Dpixbuf=disabled \
        -Dpkg_config_path="$PREFIX/lib/pkgconfig" \
        -Dpixbuf-loader=disabled \
        -Dvala=disabled \
        -Davif=disabled \
        -Dtriplet="$RUST_TARGET" \
        63<<EOF
[binaries]
c = '$CC_ABS'
cpp = '$CXX_ABS'
ar = '$AR_ABS'
nm = '$NM_ABS'
strip = '$STRIP_ABS'
pkg-config = 'pkg-config'
rust = ['rustc', '--target', '$RUST_TARGET']
cargo = 'cargo'

[built-in options]
c_args = [${SANITIZED_CFLAGS}]
cpp_args = [${SANITIZED_CXXFLAGS}]
c_link_args = [${SANITIZED_LDFLAGS}]
cpp_link_args = [${SANITIZED_LDFLAGS}]

[host_machine]
system = 'linux'
cpu_family = '${ARCH}'
cpu = '${ARCH}'
endian = 'little'

[properties]
pkg_config_libdir = '$PREFIX/lib/pkgconfig'
sys_root = '$PREFIX'
EOF

    ninja -C build
    ninja -C build install
}


build_ffmpeg() {
    echo "Building FFmpeg for $ARCH..."
    cd "$BUILD_DIR/ffmpeg"
      (make clean && make distclean) || true
    ./configure \
        --enable-cross-compile \
        --prefix="$PREFIX" \
        --host-cc=/usr/bin/gcc \
        --cc="$CC_ABS" \
        --cxx="$CXX_ABS" \
        --ar="$AR_ABS" \
        --nm="$NM_ABS" \
        --strip="$STRIP_ABS" \
        --ranlib="$RANLIB_ABS" \
        --arch="$ARCH" \
        --target-os="linux" \
        --pkg-config-flags="--static" \
        --extra-cflags="-I$PREFIX/include" \
        --extra-ldflags="-L$PREFIX/lib" \
        --extra-libs="-lm -lpthread -lstdc++ -lcrypto -lz" \
        --enable-static \
        --disable-shared \
        --disable-debug \
        --disable-doc \
        --enable-gpl \
        --enable-version3 \
        --enable-nonfree \
        --enable-libx264 \
        --enable-libx265 \
        --enable-libvpx \
        --enable-libaom \
        --enable-libdav1d \
        --enable-libharfbuzz \
        --enable-libbs2b \
        --enable-libgsm \
        --enable-libtheora \
        --enable-libopenjpeg \
        --enable-libwebp \
        --enable-libxvid \
        --enable-libkvazaar \
        --enable-libxavs \
        --enable-libxavs2 \
        --enable-libdavs2 \
        --enable-libmp3lame \
        --enable-libvorbis \
        --enable-libopus \
        --enable-libfdk-aac \
        --enable-libspeex \
        --enable-libtwolame \
        --enable-libsoxr \
        --enable-libvo-amrwbenc \
        --enable-libopencore-amrnb \
        --enable-libopencore-amrwb \
        --enable-libvvenc \
        --enable-libilbc \
        --enable-libcodec2 \
        --enable-libmysofa \
        --enable-libopenmpt \
        --enable-libfreetype \
        --enable-libfontconfig \
        --enable-libfribidi \
        --enable-libass \
        --enable-libharfbuzz \
        --enable-libbluray \
        --enable-libxml2 \
        --enable-openssl \
        --enable-zlib \
        --enable-bzlib \
        --enable-libsrt \
        --enable-libzmq \
        --enable-librist \
        --enable-libaribb24 \
        --enable-libvmaf \
        --enable-libzimg \
        --enable-liblensfun \
        --enable-libflite \
        --enable-libssh \
        --enable-libsvtav1 \
        --enable-libuavs3d \
        --enable-libv4l2 \
        --enable-librtmp \
        --enable-libgme \
        --enable-libjxl \
        --enable-vapoursynth \
        --enable-libqrencode \
        --enable-libquirc \
        --enable-libcaca \
        --enable-chromaprint


    make -j"$(nproc)"
    make install

    echo "✔ FFmpeg built successfully"
}



#download_sources
#build_zlib
#build_liblzma
#build_zstd
#build_openssl
#build_libgsm
#build_x264
#build_x265
#build_libvpx
#build_aac
#build_lame
#build_twolame
#build_opus
#build_ogg
#build_vorbis
#build_speex
#build_aom
#build_dav1d
#build_fribidi
#build_brotli
#build_bzip2
#build_freetype
#build_libxml2
#build_libexpat
#build_libpng
#build_harfbuzz
#build_fontconfig
#build_libass
#build_udfread
#build_bluray
#build_libtheora
#build_openjpeg
#build_libwebp
#build_vmaf
#build_libzimg
#build_libtiff ( removed )
#build_libmysofa
#build_vidstab
##########build_frei0r
#build_soxr
#build_openmpt
#build_svtav1
#build_libsrt
#build_libzmq
#build_libplacebo
#build_librist
#build_libvo_amrwbenc
#build_opencore_amr
#build_libilbc
#build_libcodec2
#build_aribb24
#build_uavs3d
#build_xvidcore

#build_kvazaar
#build_orc
#build_schroedinger ( removed )
#build_xavs
#build_xavs2
#build_davs2
#build_vvenc
#build_rav1e ( not compiling for aarch64)
# build_vvdec # ( not needed )
#build_vapoursynth # ( baad mein dekhte hain isse )
#build_libffi
#build_glib
#build_lensfun
#build_flite
#build_libbs2b
#build_libssh
#build_libv4l
#build_libgme
#build_rtmp
#build_llvm ( tmkc ye kya ho gaya )
#build_opencl ( kya chutiyapa hai , iske liye ab mai llvm compile karun? )
#build_highway
#build_libjxl
#build_libqrencode
#build_quirc
#build_libcaca
build_fftw
build_chromaprint
#----------- These 4 are needed to build librsvg---------------#
# build_pixman
# build_cairo
# build_pango
# build_libunwind
# build_librsvg
#---------------------------------------------------------------#
#build_ffmpeg