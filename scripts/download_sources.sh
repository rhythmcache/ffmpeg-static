#!/bin/bash


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
THEORA_VERSION="libtheora-1.2.0"
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
DAV1D_URL="https://code.videolan.org/videolan/dav1d/-/archive/master/${DAV1D-VERSION}.tar.gz"
LIBASS_URL="https://github.com/libass/libass/releases/download/0.17.4/${LIBASS_VERSION}.tar.gz"
FREETYPE_URL="https://github.com/freetype/freetype"
LIBPNG_URL="https://download.sourceforge.net/libpng/${LIBPNG_VERSION}.tar.gz"
FONTCONFIG_URL="https://www.freedesktop.org/software/fontconfig/release/${FONTCONFIG_VERSION}.tar.xz"
FRIBIDI_URL="https://github.com/fribidi/fribidi/releases/download/v1.0.16/${FRIBIDI_VERSION}.tar.xz"
BLURAY_URL="https://code.videolan.org/videolan/libbluray/-/archive/master/${BLURAY_VERSION}.tar.gz"
THEORA_URL="http://downloads.xiph.org/releases/theora/${THEORA_VERSION}.tar.gz"
SPEEX_URL="http://downloads.xiph.org/releases/speex/${SPEEX_VERSION}.tar.gz"

OPENJPEG_URL="https://github.com/uclouvain/openjpeg"

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


download_sources() {


    cd "$BUILD_DIR" || exit 1

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
    [ ! -f libass.tar.gz ]      && curl -L "$LIBASS_URL" -o libass.tar.gz
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
    [ ! -f xvid.tar.xz ]      && curl -L "$XVID_URL" -o xvid.tar.xz
    [ ! -f ffmpeg.tar.xz ]      && curl -L "$FFMPEG_URL" -o ffmpeg.tar.xz
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
    [ ! -d libilbc ] && git clone --recursive https://github.com/TimothyGu/libilbc
    [ ! -d rav1e ] && git clone --depth 1 https://github.com/xiph/rav1e
    [ ! -d vo-amrwbenc ] && git clone --depth 1 https://github.com/mstorsjo/vo-amrwbenc
    [ ! -d opencore-amr ] && git clone --depth 1 https://github.com/BelledonneCommunications/opencore-amr
    [ ! -d twolame ] && git clone --depth 1 https://github.com/njh/twolame
    [ ! -d libcodec2 ] && git clone --depth 1 https://github.com/MonadicLabs/libcodec2
    [ ! -d aribb24 ] && git clone --depth 1 https://github.com/nkoriyama/aribb24
    [ ! -d uavs3d ] && git clone --depth 1 https://github.com/uavs3/uavs3d
    [ ! -d kvazaar ] && git clone --recursive https://github.com/ultravideo/kvazaar
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
    [ ! -d libssh ]      && tar -xf libssh.tar.gz && mv "$LIBSSH_VERSION" libssh
    [ ! -d svtav1 ]      && tar -xf svtav1.tar.gz && mv "$SVTAV1_VERSION" svtav1
    [ ! -d xvidcore ]    && tar -xf xvid.tar.xz
    [ ! -d libbs2b ]     && tar -xf libbs2b.tar.gz     && mv "$LIBBS2B_VERSION" libbs2b
    [ ! -f fftw ] && tar -xf fftw.tar.gz && mv "$FFTW_VERSION" "fftw"
    [ ! -d ffmpeg ]      && tar -xf ffmpeg.tar.xz      && mv "$FFMPEG_VERSION" ffmpeg
    
}

