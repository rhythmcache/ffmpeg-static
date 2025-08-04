#!/bin/bash

set -e
ARCH="$1"

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"


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
export AS="${HOST}-as"
export RANLIB="${HOST}-ranlib"
export STRIP="${HOST}-strip"
export NM="${HOST}-nm"
export STRINGS="${HOST}-strings"

resolve_absolute_path() {
    local tool_name="$1"
    local abs_path=$(which "$tool_name")
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
export CFLAGS="-static $SIZE_CFLAGS -DNDEBUG -fPIC"
export CXXFLAGS="-static $SIZE_CXXFLAGS -DNDEBUG -fPIC" 
export LDFLAGS="-static $SIZE_LDFLAGS -Wl,--allow-multiple-definition"
export SYSROOT=$(${CC_ABS} --print-sysroot)
BUILD_DIR="$ROOT_DIR/build/$ARCH"
PREFIX="$BUILD_DIR/prefix"
mkdir -p "$BUILD_DIR" "$PREFIX"
export PKG_CONFIG_PATH="$PREFIX/lib/pkgconfig:$PKG_CONFIG_PATH"
export PKG_CONFIG_ALLOW_CROSS=1
export CARGO_BUILD_TARGET="${RUST_TARGET}"
export CARGO_DEFAULT_TARGET="${RUST_TARGET}"

CARGO_TARGET_VAR=$(echo "$RUST_TARGET" | tr '[:lower:]' '[:upper:]' | tr '-' '_')

export CARGO_TARGET_"${CARGO_TARGET_VAR}"_LINKER="${CC_ABS}"
export CARGO_TARGET_"${CARGO_TARGET_VAR}"_AR="${AR_ABS}"


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

DOWNLOADER_SCRIPT="${ROOT_DIR}/scripts/download_sources.sh"
BUILD_FUNCTIONS="${ROOT_DIR}/scripts/build_functions.sh"

for script in "${DOWNLOADER_SCRIPT}" "${BUILD_FUNCTIONS}"; do
    if [ ! -f "$script" ]; then
        echo "Missing required script: $script" >&2
        exit 1
    fi
    source "$script"
done

build_ffmpeg() {
    echo "Building FFmpeg for $ARCH..."
    cd "$BUILD_DIR/ffmpeg"
    ASM_FLAGS=()
[ "$ARCH" = "x86" ] && ASM_FLAGS=(--disable-x86asm --disable-sse --disable-sse2 --disable-sse3 --disable-ssse3 --disable-avx --disable-avx2)
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
        "${ASM_FLAGS[@]}" \
        --target-os="linux" \
        --pkg-config-flags="--static" \
        --extra-cflags="-I$PREFIX/include -static -Os -ffunction-sections -fdata-sections" \
        --extra-ldflags="-L$PREFIX/lib -static -Wl,--gc-sections -Wl,--strip-all -Wl,--allow-multiple-definition" \
        --extra-libs="-lm -lpthread -lstdc++ -lcrypto -lz -lfftw3 -lssp" \
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
        --enable-chromaprint \
        --enable-libspeex \
        --enable-libbluray


    make -j"$(nproc)"
    make install

    echo "✔ FFmpeg built successfully"
}

download_sources
build_libcaca
[ -d "$BUILD_DIR/vapoursynth" ] && [ -d "$ROOT_DIR/patches/vapoursynth" ] && cp  "$ROOT_DIR/patches/vapoursynth"/*  "$BUILD_DIR/vapoursynth" 
build_zlib
build_openssl
build_libsrt
build_openjpeg
build_liblzma
build_zstd
build_pcre2
build_rtmp
build_libgsm
build_x264
build_x265
build_libvpx
build_aac
build_lame
build_twolame
build_opus
build_ogg
build_vorbis
build_speex
build_aom
build_dav1d
build_fribidi
build_brotli
build_bzip2
build_freetype
build_libxml2
build_libexpat
build_libpng
build_harfbuzz
build_fontconfig
build_libass
build_udfread
build_bluray
build_libtheora

# build_libjpeg (useless lib)
build_libwebp
build_vmaf
build_libzimg
#build_libtiff ( removed )
build_libmysofa
build_vidstab
##########build_frei0r
build_soxr
build_openmpt
build_svtav1
build_libzmq
build_libplacebo
build_librist
build_libvo_amrwbenc
build_opencore_amr
build_libilbc
build_libcodec2
build_aribb24
build_uavs3d
build_xvidcore

build_kvazaar
#build_orc
#build_schroedinger ( removed )
build_xavs
build_xavs2
build_davs2
build_vvenc
#build_rav1e ( not compiling for aarch64)
#build_vvdec # ( not needed )
build_vapoursynth # ( baad mein dekhte hain isse )
build_libffi
build_glib
build_lensfun
build_flite
build_libbs2b
build_libssh
build_libv4l
build_libgme
#build_llvm ( tmkc ye kya ho gaya )
#build_opencl ( kya chutiyapa hai , iske liye ab mai llvm compile karun? )
build_highway
build_libjxl
build_libqrencode
build_quirc
build_fftw
build_chromaprint
#----------- These 4 are needed to build librsvg---------------#
# build_pixman
# build_cairo
# build_pango
# build_libunwind
# build_librsvg
#---------------------------------------------------------------#
build_ffmpeg
