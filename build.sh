#!/bin/bash

set -e

ARCH="${1:-$ARCH}"

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

VALID_ARCHES="aarch64 armv7 x86 x86_64 riscv64"

if [[ -z "$ARCH" || ! " $VALID_ARCHES " =~ $ARCH ]]; then
	echo "Usage: $0 <aarch64|armv7|x86|x86_64|riscv64> (or set ARCH env variable)"
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

if [ "$ARCH" = "x86" ] || [ "$ARCH" = "x86_64" ]; then
	export AS=nasm
fi

resolve_absolute_path() {
	local tool_name="$1"
	local abs_path
	abs_path=$(which "$tool_name")
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

SYSROOT=$(${CC_ABS} --print-sysroot)
export SYSROOT

BUILD_DIR="$ROOT_DIR/build/$ARCH"

PREFIX="$BUILD_DIR/prefix"

mkdir -p "$BUILD_DIR" "$PREFIX"
mkdir -p "$PREFIX/lib/pkgconfig"
mkdir -p "$PREFIX/lib64/pkgconfig"

export PKG_CONFIG_PATH="$PREFIX/lib/pkgconfig:$PREFIX/lib64/pkgconfig:$PKG_CONFIG_PATH"

export RUSTFLAGS="-C target-feature=+crt-static -C relocation-model=pic -C link-arg=-pie"

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
RAV1E_SCRIPT="${ROOT_DIR}/scripts/build_rav1e.sh"

for script in "$DOWNLOADER_SCRIPT" "$BUILD_FUNCTIONS" "$RAV1E_SCRIPT"; do
	if [ ! -f "$script" ]; then
		echo "Missing required script: $script" >&2
		exit 1
	fi
	source "$script"
done

echo "[+] Checking if Rust target '$RUST_TARGET' is installed..."
if ! rustup target list --installed | grep -q "^$RUST_TARGET$"; then
	echo "[+] Installing Rust target '$RUST_TARGET'..."
	rustup target add "$RUST_TARGET" || {
		echo "[-] Failed to add target $RUST_TARGET"
		exit 1
	}
fi

test_compiler() {
	local tmpdir="$ROOT_DIR/tmp/compiler-test"
	mkdir -p "$tmpdir"

	echo "[+] Testing C compiler: $CC_ABS"
	echo 'int main() { return 0; }' >"$tmpdir/test.c"
	if ! "$CC_ABS" $CFLAGS $LDFLAGS -o "$tmpdir/test_c" "$tmpdir/test.c" >/dev/null 2>&1; then
		echo "    [+] C compile failed"
		"$CC_ABS" $CFLAGS $LDFLAGS -o "$tmpdir/test_c" "$tmpdir/test.c" 2>&1 | sed 's/^/      /'
		exit 1
	else
		echo "    [+] C compile successful"
		file "$tmpdir/test_c" 2>/dev/null || echo "    C binary created"
	fi

	echo "[+] Testing C++ compiler: $CXX_ABS"
	echo 'int main() { return 0; }' >"$tmpdir/test.cpp"
	if ! "$CXX_ABS" $CXXFLAGS $LDFLAGS -o "$tmpdir/test_cpp" "$tmpdir/test.cpp" >/dev/null 2>&1; then
		echo "    [+] C++ compile failed"
		"$CXX_ABS" $CXXFLAGS $LDFLAGS -o "$tmpdir/test_cpp" "$tmpdir/test.cpp" 2>&1 | sed 's/^/      /'
		exit 1
	else
		echo "    [+] C++ compile successful"
		file "$tmpdir/test_cpp" 2>/dev/null || echo "    C++ binary created"
	fi

	echo "[+] Testing Rust compiler: rustc"
	echo 'fn main() {}' >"$tmpdir/test.rs"
	if ! rustc --target="$RUST_TARGET" -C linker="$CC_ABS" -C link-arg=-static -o "$tmpdir/test_rust" "$tmpdir/test.rs" >/dev/null 2>&1; then
		echo "    [+] Rust compile failed"
		rustc --target="$RUST_TARGET" -C linker="$CC_ABS" -C link-arg=-static -o "$tmpdir/test_rust" "$tmpdir/test.rs" 2>&1 | sed 's/^/      /'
		exit 1
	else
		echo "    [+] Rust compile successful"
		file "$tmpdir/test_rust" 2>/dev/null || echo "    Rust binary created"
	fi

	rm -rf "$tmpdir"
}

build_ffmpeg() {
	echo "Building FFmpeg for $ARCH..."
	cd "$BUILD_DIR/ffmpeg" || exit 1

	ASM_FLAGS=()
	[ "$ARCH" = "x86" ] && ASM_FLAGS=(--disable-asm)

	(make clean && make distclean) || true

	CONFIGURE_FLAGS=(
		--enable-cross-compile
		--prefix="$PREFIX"
		--host-cc="$(which gcc)"
		--cc="$CC_ABS"
		--cxx="$CXX_ABS"
		--ar="$AR_ABS"
		--nm="$NM_ABS"
		--strip="$STRIP_ABS"
		--ranlib="$RANLIB_ABS"
		--arch="$ARCH"
		"${ASM_FLAGS[@]}"
		--target-os=linux
		--pkg-config-flags=--static
		--extra-cflags="-I$PREFIX/include -Os -ffunction-sections -fdata-sections"
		--extra-ldflags="-L$PREFIX/lib -L$PREFIX/lib64 -static -Wl,--gc-sections -Wl,--strip-all -Wl,--allow-multiple-definition"
		--extra-libs="-lm -lpthread -lstdc++ -lcrypto -lz -lfftw3 -lssp -latomic -llzma"
		--enable-static
		--disable-shared
		--disable-debug
		--disable-doc
		--enable-gpl
		--enable-version3
		--enable-libx264
		--enable-libx265
		--enable-libvpx
		--enable-libaom
		--enable-libdav1d
		--enable-libharfbuzz
		--enable-libbs2b
		--enable-libgsm
		--enable-libtheora
		--enable-libopenjpeg
		--enable-libwebp
		--enable-libxvid
		--enable-libkvazaar
		--enable-libxavs
		--enable-libxavs2
		--enable-libdavs2
		--enable-libmp3lame
		--enable-libvorbis
		--enable-libopus
		--enable-libtwolame
		--enable-libsoxr
		--enable-libvo-amrwbenc
		--enable-libopencore-amrnb
		--enable-libopencore-amrwb
		--enable-libvvenc
		--enable-libilbc
		--enable-libcodec2
		--enable-libmysofa
		--enable-libopenmpt
		--enable-libfreetype
		--enable-libfontconfig
		--enable-libfribidi
		--enable-libass
		--enable-libxml2
		--enable-openssl
		--enable-zlib
		--enable-bzlib
		--enable-libsrt
		--enable-libzmq
		--enable-librist
		--enable-libaribb24
		--enable-libvmaf
		--enable-libzimg
		--enable-liblensfun
		--enable-libflite
		--enable-libssh
		--enable-libsvtav1
		--enable-libuavs3d
		--enable-libv4l2
		--enable-librtmp
		--enable-libgme
		--enable-libjxl
		--enable-vapoursynth
		--enable-libqrencode
		--enable-libquirc
		--enable-libcaca
		--enable-chromaprint
		--enable-libspeex
		--enable-libbluray
		--enable-librav1e
		--enable-lcms2
	)

	if [ -z "$RELEASE" ]; then
		CONFIGURE_FLAGS+=(
			--enable-nonfree
			--enable-libfdk-aac
		)
	else
		echo "[+] RELEASE=1: Skipping nonfree components"
	fi

	./configure "${CONFIGURE_FLAGS[@]}"
	make -j"$(nproc)"
	make install

	echo "[+] FFmpeg built successfully for $ARCH"
}

#: <<'IDK'

test_compiler
download_sources
[ -d "$BUILD_DIR/vapoursynth" ] && [ -d "$ROOT_DIR/patches/vapoursynth" ] && cp "$ROOT_DIR/patches/vapoursynth"/* "$BUILD_DIR/vapoursynth"
build_zlib
build_openssl
build_x264
build_libvpx
build_libcaca
build_xavs
build_libsrt
build_openjpeg
build_liblzma
build_zstd
build_pcre2
build_rtmp
build_libgsm
build_x265
[ -z "$RELEASE" ] && build_aac
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
build_libunwind
build_rav1e
build_lcms
build_libwebp
build_vmaf
build_libzimg
build_libmysofa
build_vidstab
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
build_xavs2
build_davs2
build_vvenc
build_vapoursynth
build_libffi
build_glib
build_lensfun
build_flite
build_libbs2b
build_libssh
build_libv4l
build_libgme
build_highway
build_libjxl
build_libqrencode
build_quirc
build_fftw
build_ffmpeg
