#!/bin/bash

# Version definitions
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
DAV1D_VERSION="dav1d-master"
LIBASS_VERSION="libass-0.17.4"
LIBPNG_VERSION="libpng-1.6.50"
FONTCONFIG_VERSION="fontconfig-2.16.0"
FRIBIDI_VERSION="fribidi-1.0.16"
BLURAY_VERSION="libbluray-master"
SPEEX_VERSION="speex-1.2.1"
LIBEXPAT_VERSION="expat-2.7.1"
BUDFREAD_VERSION="libudfread-master"
OPENMPT_VERSION="libopenmpt-0.8.2"
LIBGSM_VERSION="gsm-1.0.22"
TIFF_VERSION="tiff-4.7.0"
XVID_VERSION="xvidcore-1.3.7"
LIBSSH_VERSION="libssh-0.11.0"
XZ_VERSION="xz-5.8.1"
ZSTD_VERSION="zstd-1.5.7"
LIBBS2B_VERSION="libbs2b-3.1.0"
SVTAV1_VERSION="SVT-AV1-v3.1.0"
FFTW_VERSION="fftw-3.3.10"
LIBFFI_VERSION="libffi-3.5.2"

# URL definitions
FFMPEG_URL="https://ffmpeg.org/releases/${FFMPEG_VERSION}.tar.xz"
ZLIB_URL="https://zlib.net/${ZLIB_VERSION}.tar.gz"
BROTLI_URL="https://github.com/google/brotli/archive/refs/tags/v${BROTLI_VERSION}.tar.gz"
XZ_URL="https://github.com/tukaani-project/xz/releases/download/v5.8.1/${XZ_VERSION}.tar.gz"
ZSTD_URL="https://github.com/facebook/zstd/releases/download/v1.5.7/${ZSTD_VERSION}.tar.gz"
BZIP2_URL="https://github.com/libarchive/bzip2/archive/refs/tags/${BZIP2_VERSION}.tar.gz"
OPENSSL_URL="https://github.com/openssl/openssl/releases/download/${OPENSSL_VERSION}/${OPENSSL_VERSION}.tar.gz"
X264_URL="https://code.videolan.org/videolan/x264/-/archive/master/${X264_VERSION}.tar.gz"
X265_URL="http://ftp.videolan.org/pub/videolan/x265/${X265_VERSION}.tar.gz"
AAC_URL="https://downloads.sourceforge.net/opencore-amr/${AAC_VERSION}.tar.gz"
LAME_URL="https://sourceforge.net/projects/lame/files/lame/3.100/${LAME_VERSION}.tar.gz/download"
OPUS_URL="https://github.com/xiph/opus/releases/download/v1.5.2/${OPUS_VERSION}.tar.gz"
VORBIS_URL="https://downloads.xiph.org/releases/vorbis/${VORBIS_VERSION}.tar.xz"
OGG_URL="https://downloads.xiph.org/releases/ogg/${OGG_VERSION}.tar.gz"
DAV1D_URL="https://code.videolan.org/videolan/dav1d/-/archive/master/${DAV1D_VERSION}.tar.gz"
LIBASS_URL="https://github.com/libass/libass/releases/download/0.17.4/${LIBASS_VERSION}.tar.gz"
FREETYPE_URL="https://github.com/freetype/freetype"
LIBPNG_URL="https://download.sourceforge.net/libpng/${LIBPNG_VERSION}.tar.gz"
FONTCONFIG_URL="https://www.freedesktop.org/software/fontconfig/release/${FONTCONFIG_VERSION}.tar.xz"
FRIBIDI_URL="https://github.com/fribidi/fribidi/releases/download/v1.0.16/${FRIBIDI_VERSION}.tar.xz"
BLURAY_URL="https://code.videolan.org/videolan/libbluray/-/archive/master/${BLURAY_VERSION}.tar.gz"
SPEEX_URL="http://downloads.xiph.org/releases/speex/${SPEEX_VERSION}.tar.gz"
LIBXML2_URL="https://github.com/GNOME/libxml2.git"
HARFBUZZ_URL="https://github.com/harfbuzz/harfbuzz.git"
LIBEXPAT_URL="https://github.com/libexpat/libexpat/releases/download/R_2_7_1/${LIBEXPAT_VERSION}.tar.gz"
BUDFREAD_URL="https://code.videolan.org/videolan/libudfread/-/archive/master/${BUDFREAD_VERSION}.tar.gz"
WEBP_URL="https://chromium.googlesource.com/webm/libwebp"
VMAF_URL="https://github.com/Netflix/vmaf"
VIDSTAB_URL="https://github.com/georgmartius/vid.stab"
ZIMG_URL="https://github.com/sekrit-twc/zimg"
FREI0R_URL="https://github.com/dyne/frei0r"
OPENMPT_URL="https://lib.openmpt.org/files/libopenmpt/src/${OPENMPT_VERSION}+release.autotools.tar.gz"
RUBBERBAND_URL="https://github.com/breakfastquay/rubberband"
SOXR_URL="https://github.com/chirlu/soxr"
LIBMYSOFA_URL="https://github.com/hoene/libmysofa"
SVTAV1_URL="https://gitlab.com/AOMediaCodec/SVT-AV1/-/archive/v3.1.0/${SVTAV1_VERSION}.tar.gz"
SRT_URL="https://github.com/Haivision/srt"
LIBRIST_URL="https://code.videolan.org/rist/librist"
LIBZMQ_URL="https://github.com/zeromq/libzmq"
LIBGSM_URL="https://www.quut.com/gsm/${LIBGSM_VERSION}.tar.gz"
TIFF_URL="https://download.osgeo.org/libtiff/${TIFF_VERSION}.tar.gz"
XVID_URL="https://downloads.xvid.com/downloads/${XVID_VERSION}.tar.gz"
LIBSSH_URL="https://www.libssh.org/files/0.11/${LIBSSH_VERSION}.tar.xz"
LIBBS2B_URL="https://sourceforge.net/projects/bs2b/files/libbs2b/3.1.0/${LIBBS2B_VERSION}.tar.gz/download"
FFTW_URL="https://www.fftw.org/${FFTW_VERSION}.tar.gz"
LIBFFI_URL="https://github.com/libffi/libffi/releases/download/v3.5.2/${LIBFFI_VERSION}.tar.gz"

# Number of parallel downloads
PARALLEL_DOWNLOADS=${PARALLEL_DOWNLOADS:-8}

download_sources() {
	cd "$BUILD_DIR" || exit 1

	echo "Starting parallel downloads (${PARALLEL_DOWNLOADS} concurrent)..."

	# Create temporary directory and files for  commands
	local temp_dir="${ROOT_DIR}/temporary-$"
	mkdir -p "$temp_dir"
	local download_cmds="$temp_dir/download_cmds"
	local clone_cmds="$temp_dir/clone_cmds"

	{
		[ ! -f zlib.tar.gz ] && echo "curl -L --fail --retry 3 --retry-delay 2 '$ZLIB_URL' -o zlib.tar.gz"
		[ ! -f brotli.tar.gz ] && echo "curl -L --fail --retry 3 --retry-delay 2 '$BROTLI_URL' -o brotli.tar.gz"
		[ ! -f xz.tar.gz ] && echo "curl -L --fail --retry 3 --retry-delay 2 '$XZ_URL' -o xz.tar.gz"
		[ ! -f zstd.tar.gz ] && echo "curl -L --fail --retry 3 --retry-delay 2 '$ZSTD_URL' -o zstd.tar.gz"
		[ ! -f bzip2.tar.gz ] && echo "curl -L --fail --retry 3 --retry-delay 2 '$BZIP2_URL' -o bzip2.tar.gz"
		[ ! -f openssl.tar.gz ] && echo "curl -L --fail --retry 3 --retry-delay 2 '$OPENSSL_URL' -o openssl.tar.gz"
		[ ! -f x264.tar.gz ] && echo "curl -L --fail --retry 3 --retry-delay 2 '$X264_URL' -o x264.tar.gz"
		[ ! -f x265.tar.gz ] && echo "curl -L --fail --retry 3 --retry-delay 2 '$X265_URL' -o x265.tar.gz"
		[ ! -f aac.tar.gz ] && echo "curl -L --fail --retry 3 --retry-delay 2 '$AAC_URL' -o aac.tar.gz"
		[ ! -f libgsm.tar.xz ] && echo "curl -L --fail --retry 3 --retry-delay 2 '$LIBGSM_URL' -o libgsm.tar.xz"
		[ ! -f lame.tar.gz ] && echo "curl -L --fail --retry 3 --retry-delay 2 '$LAME_URL' -o lame.tar.gz"
		[ ! -f opus.tar.gz ] && echo "curl -L --fail --retry 3 --retry-delay 2 '$OPUS_URL' -o opus.tar.gz"
		[ ! -f vorbis.tar.xz ] && echo "curl -L --fail --retry 3 --retry-delay 2 '$VORBIS_URL' -o vorbis.tar.xz"
		[ ! -f ogg.tar.gz ] && echo "curl -L --fail --retry 3 --retry-delay 2 '$OGG_URL' -o ogg.tar.gz"
		[ ! -f dav1d.tar.gz ] && echo "curl -L --fail --retry 3 --retry-delay 2 '$DAV1D_URL' -o dav1d.tar.gz"
		[ ! -f libass.tar.gz ] && echo "curl -L --fail --retry 3 --retry-delay 2 '$LIBASS_URL' -o libass.tar.gz"
		[ ! -f libpng.tar.gz ] && echo "curl -L --fail --retry 3 --retry-delay 2 '$LIBPNG_URL' -o libpng.tar.gz"
		[ ! -f fontconfig.tar.xz ] && echo "curl -L --fail --retry 3 --retry-delay 2 '$FONTCONFIG_URL' -o fontconfig.tar.xz"
		[ ! -f fribidi.tar.xz ] && echo "curl -L --fail --retry 3 --retry-delay 2 '$FRIBIDI_URL' -o fribidi.tar.xz"
		[ ! -f bluray.tar.gz ] && echo "curl -L --fail --retry 3 --retry-delay 2 '$BLURAY_URL' -o bluray.tar.gz"
		[ ! -f speex.tar.gz ] && echo "curl -L --fail --retry 3 --retry-delay 2 '$SPEEX_URL' -o speex.tar.gz"
		[ ! -f libexpat.tar.gz ] && echo "curl -L --fail --retry 3 --retry-delay 2 '$LIBEXPAT_URL' -o libexpat.tar.gz"
		[ ! -f budfread.tar.gz ] && echo "curl -L --fail --retry 3 --retry-delay 2 '$BUDFREAD_URL' -o budfread.tar.gz"
		[ ! -f openmpt.tar.gz ] && echo "curl -L --fail --retry 3 --retry-delay 2 '$OPENMPT_URL' -o openmpt.tar.gz"
		# [ ! -f tiff.tar.gz ] && echo "curl -L --fail --retry 3 --retry-delay 2 '$TIFF_URL' -o tiff.tar.gz"
		[ ! -f xvid.tar.xz ] && echo "curl -L --fail --retry 3 --retry-delay 2 '$XVID_URL' -o xvid.tar.xz"
		[ ! -f libssh.tar.gz ] && echo "curl -L --fail --retry 3 --retry-delay 2 '$LIBSSH_URL' -o libssh.tar.gz"
		[ ! -f libbs2b.tar.gz ] && echo "curl -L --fail --retry 3 --retry-delay 2 '$LIBBS2B_URL' -o libbs2b.tar.gz"
		[ ! -f svtav1.tar.gz ] && echo "curl -L --fail --retry 3 --retry-delay 2 '$SVTAV1_URL' -o svtav1.tar.gz"
		[ ! -f fftw.tar.gz ] && echo "curl -L --fail --retry 3 --retry-delay 2 '$FFTW_URL' -o fftw.tar.gz"
		[ ! -f libffi.tar.gz ] && echo "curl -L --fail --retry 3 --retry-delay 2 '$LIBFFI_URL' -o libffi.tar.gz"
	} >"$download_cmds"

	# Build clone commands for git repositories
	{
		[ ! -d freetype ] && echo "git clone --depth 1 '$FREETYPE_URL' freetype"
		[ ! -d lcms ] && echo "git clone --depth 1 https://github.com/mm2/Little-CMS lcms"
		[ ! -d openjpeg ] && echo "git clone --depth 1 https://github.com/uclouvain/openjpeg openjpeg"
		[ ! -d libunwind ] && echo "git clone --depth 1 https://github.com/libunwind/libunwind"
		[ ! -d libvpx ] && echo "git clone --depth 1 https://chromium.googlesource.com/webm/libvpx"
		[ ! -d libxml2 ] && echo "git clone --depth 1 '$LIBXML2_URL' libxml2"
		[ ! -d harfbuzz ] && echo "git clone --depth 1 '$HARFBUZZ_URL' harfbuzz"
		[ ! -d theora ] && echo "git clone --depth 1 https://gitlab.xiph.org/xiph/theora.git"
		[ ! -d libwebp ] && echo "git clone --depth 1 '$WEBP_URL' libwebp"
		[ ! -d vmaf ] && echo "git clone --depth 1 '$VMAF_URL' vmaf"
		[ ! -d vidstab ] && echo "git clone --depth 1 '$VIDSTAB_URL' vidstab"
		[ ! -d zimg ] && echo "git clone --recursive '$ZIMG_URL' zimg"
		[ ! -d rubberband ] && echo "git clone --depth 1 '$RUBBERBAND_URL' rubberband"
		[ ! -d soxr ] && echo "git clone --depth 1 '$SOXR_URL' soxr"
		[ ! -d libmysofa ] && echo "git clone --depth 1 '$LIBMYSOFA_URL' libmysofa"
		[ ! -d srt ] && echo "git clone --depth 1 '$SRT_URL' srt"
		[ ! -d librist ] && echo "git clone --depth 1 '$LIBRIST_URL' librist"
		[ ! -d libzmq ] && echo "git clone --depth 1 '$LIBZMQ_URL' libzmq"
		[ ! -d libplacebo ] && echo "git clone --recursive https://github.com/haasn/libplacebo libplacebo"
		[ ! -d pcre2 ] && echo "git clone --depth 1 https://github.com/PCRE2Project/pcre2.git"
		[ ! -d libilbc ] && echo "git clone --recursive https://github.com/TimothyGu/libilbc libilbc"
		[ ! -d rav1e ] && echo "git clone --depth 1 https://github.com/xiph/rav1e rav1e"
		[ ! -d vo-amrwbenc ] && echo "git clone --depth 1 https://github.com/mstorsjo/vo-amrwbenc vo-amrwbenc"
		[ ! -d opencore-amr ] && echo "git clone --depth 1 https://github.com/BelledonneCommunications/opencore-amr opencore-amr"
		[ ! -d twolame ] && echo "git clone --depth 1 https://github.com/njh/twolame twolame"
		[ ! -d libcodec2 ] && echo "git clone --depth 1 https://github.com/MonadicLabs/libcodec2 libcodec2"
		[ ! -d aribb24 ] && echo "git clone --depth 1 https://github.com/nkoriyama/aribb24 aribb24"
		[ ! -d uavs3d ] && echo "git clone --depth 1 https://github.com/uavs3/uavs3d uavs3d"
		[ ! -d kvazaar ] && echo "git clone --recursive https://github.com/ultravideo/kvazaar kvazaar"
		[ ! -d xavs2 ] && echo "git clone --depth 1 https://github.com/pkuvcl/xavs2 xavs2"
		[ ! -d davs2 ] && echo "git clone --depth 1 https://github.com/pkuvcl/davs2 davs2"
		[ ! -d rtmpdump ] && echo "git clone git://git.ffmpeg.org/rtmpdump rtmpdump"
		#   [ ! -d vvdec ] && echo "git clone --depth 1 https://github.com/fraunhoferhhi/vvdec vvdec"
		[ ! -d vvenc ] && echo "git clone --depth 1 https://github.com/fraunhoferhhi/vvenc vvenc"
		[ ! -d vapoursynth ] && echo "git clone --depth 1 https://github.com/vapoursynth/vapoursynth vapoursynth"
		[ ! -d glib ] && echo "git clone --depth 1 https://github.com/GNOME/glib glib"
		[ ! -d lensfun ] && echo "git clone --depth 1 https://github.com/lensfun/lensfun lensfun"
		[ ! -d flite ] && echo "git clone --depth 1 https://github.com/festvox/flite flite"
		[ ! -d libv4l ] && echo "git clone --depth 1 https://git.linuxtv.org/v4l-utils.git libv4l"
		[ ! -d libgme ] && echo "git clone --depth 1 https://github.com/libgme/game-music-emu libgme"
		[ ! -d aom ] && echo "git clone --depth 1 https://aomedia.googlesource.com/aom aom"
		[ ! -d highway ] && echo "git clone --depth 1 https://github.com/google/highway highway"
		[ ! -d libjxl ] && echo "git clone --recursive https://github.com/libjxl/libjxl libjxl"
		[ ! -d libqrencode ] && echo "git clone --depth 1 https://github.com/fukuchi/libqrencode libqrencode"
		[ ! -d quirc ] && echo "git clone --depth 1 https://github.com/dlbeer/quirc quirc"
		[ ! -d chromaprint ] && echo "git clone --depth 1 https://github.com/acoustid/chromaprint chromaprint"
		[ ! -d libcaca ] && echo "git clone --depth 1 https://github.com/cacalabs/libcaca libcaca"
		[ ! -d ffmpeg ] && echo "git clone --depth 1 https://github.com/FFmpeg/FFmpeg ffmpeg"
	} >"$clone_cmds"

	# Execute downloads in parallel
	if [ -s "$download_cmds" ]; then
		echo "Downloading archives..."
		cat "$download_cmds" | xargs -I {} -P "$PARALLEL_DOWNLOADS" bash -c '{}'
	fi

	# Execute git clones in parallel
	if [ -s "$clone_cmds" ]; then
		echo "Cloning repositories..."
		cat "$clone_cmds" | xargs -I {} -P "$PARALLEL_DOWNLOADS" bash -c '{}'
	fi

	[ ! -d xavs ] && svn checkout https://svn.code.sf.net/p/xavs/code/ xavs

	# Clean up temp files
	rm -f "$download_cmds" "$clone_cmds"

	# Extract archives
	[ ! -d zlib ] && tar -xf zlib.tar.gz && mv "$ZLIB_VERSION" zlib
	[ ! -d brotli ] && tar -xf brotli.tar.gz && mv "brotli-${BROTLI_VERSION}" brotli
	[ ! -d xz ] && tar -xf xz.tar.gz && mv "$XZ_VERSION" xz
	[ ! -d zstd ] && tar -xf zstd.tar.gz && mv "$ZSTD_VERSION" zstd
	[ ! -d bzip2 ] && tar -xf bzip2.tar.gz && mv "bzip2-${BZIP2_VERSION}" bzip2
	[ ! -d openssl ] && tar -xf openssl.tar.gz && mv "$OPENSSL_VERSION" openssl
	[ ! -d x264 ] && tar -xf x264.tar.gz && mv "$X264_VERSION" x264
	[ ! -d x265 ] && tar -xf x265.tar.gz && mv "$X265_VERSION" x265
	[ ! -d aac ] && tar -xf aac.tar.gz && mv "$AAC_VERSION" aac
	[ ! -d lame ] && tar -xf lame.tar.gz && mv "$LAME_VERSION" lame
	[ ! -d libpng ] && tar -xf libpng.tar.gz && mv "$LIBPNG_VERSION" libpng
	[ ! -d opus ] && tar -xf opus.tar.gz && mv "$OPUS_VERSION" opus
	[ ! -d vorbis ] && tar -xf vorbis.tar.xz && mv "$VORBIS_VERSION" vorbis
	[ ! -d ogg ] && tar -xf ogg.tar.gz && mv "$OGG_VERSION" ogg
	[ ! -d dav1d ] && tar -xf dav1d.tar.gz && mv "$DAV1D_VERSION"* dav1d
	[ ! -d libass ] && tar -xf libass.tar.gz && mv "$LIBASS_VERSION" libass
	[ ! -d fontconfig ] && tar -xf fontconfig.tar.xz && mv "$FONTCONFIG_VERSION" fontconfig
	[ ! -d fribidi ] && tar -xf fribidi.tar.xz && mv "$FRIBIDI_VERSION" fribidi
	[ ! -d bluray ] && tar -xf bluray.tar.gz && mv "$BLURAY_VERSION"* bluray
	[ ! -d speex ] && tar -xf speex.tar.gz && mv "$SPEEX_VERSION" speex
	[ ! -d libexpat ] && tar -xf libexpat.tar.gz && mv "$LIBEXPAT_VERSION" libexpat
	[ ! -d budfread ] && tar -xf budfread.tar.gz && mv "$BUDFREAD_VERSION" budfread
	[ ! -d openmpt ] && tar -xf openmpt.tar.gz && mv "$OPENMPT_VERSION"* openmpt
	[ ! -d libgsm ] && tar -xf libgsm.tar.xz && mv gsm* libgsm
	[ ! -d libssh ] && tar -xf libssh.tar.gz && mv "$LIBSSH_VERSION" libssh
	[ ! -d svtav1 ] && tar -xf svtav1.tar.gz && mv "$SVTAV1_VERSION" svtav1
	[ ! -d xvidcore ] && tar -xf xvid.tar.xz
	[ ! -d libbs2b ] && tar -xf libbs2b.tar.gz && mv "$LIBBS2B_VERSION" libbs2b
	[ ! -d fftw ] && tar -xf fftw.tar.gz && mv "$FFTW_VERSION" fftw
	[ ! -d libffi ] && tar -xf libffi.tar.gz && mv "$LIBFFI_VERSION" libffi

}
