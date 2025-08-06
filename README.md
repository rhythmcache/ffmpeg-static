# FFmpeg-Static

This script builds a static FFmpeg binary for multiple architectures using musl libc.

## Supported Architectures

- `aarch64`
- `armv7`
- `x86`
- `x86_64`
- `riscv64`

## Prerequisites

You need cross-compilation toolchains for your target architecture. For example:
- `aarch64-linux-musl-gcc`
- `x86_64-linux-musl-gcc` 
- etc.

You also need:
- Rust with `rustup`
- `nasm` (for x86/x86_64 builds)
- Standard build tools (`make`, `cmake`, `pkg-config`..etc)

## Usage

```bash
# Build for x86_64
./build.sh x86_64

# Or set environment variable
export ARCH=aarch64
./build.sh

# For release build (skips non-free codecs)
RELEASE=1 ./build.sh x86_64
```

The final FFmpeg binary will be in `build/$ARCH/prefix/bin/ffmpeg`.

## What's Included

This builds FFmpeg with a massive amount of libraries:

### Video Codecs
- **H.264** (x264) - Most common video codec
- **H.265/HEVC** (x265) - Next-gen video codec
- **VP8/VP9** (libvpx) - Google's video codecs
- **AV1** (libaom, libdav1d, libsvtav1, librav1e) - Latest royalty-free codec
- **Theora** - Ogg video codec
- **JPEG 2000** (openjpeg)
- **WebP** - Google's image/animation format
- **Xvid** - MPEG-4 codec
- **KVAZAAR** - HEVC encoder
- **XAVS/XAVS2** - Chinese video standards
- **DAVS2** - Another Chinese standard
- **VVC/H.266** (vvenc) - Newest video codec
- **UAVS3D** - Chinese decoder
- **JPEG XL** (libjxl) - New image format

### Audio Codecs
- **MP3** (libmp3lame) - Classic audio codec
- **AAC** (libfdk-aac) - Modern audio codec (non-free builds only)
- **Vorbis** (libvorbis) - Ogg audio codec  
- **Opus** - Low-latency audio codec
- **Speex** - Speech codec
- **FLAC** - Lossless audio
- **Twolame** - MP2 encoder
- **AMR** (opencore-amr, vo-amrwbenc) - Mobile audio
- **iLBC** - Internet speech codec
- **Codec2** - Low-bitrate speech

### Filters & Processing  
- **libass** - Subtitle rendering
- **libfreetype** - Font rendering
- **libfontconfig** - Font management
- **libfribidi** - Text layout
- **harfbuzz** - Text shaping
- **VMAF** - Video quality metrics
- **zimg** - High-quality scaling
- **VapourSynth** - Video processing framework
- **Vid.Stab** - Video stabilization  
- **SoxR** - Audio resampling
- **MySOFA** - 3D audio processing
- **lensfun** - Lens distortion correction
- **bs2b** - Binaural audio
- **lcms2** - Color management

### Network & Streaming
- **SRT** - Low-latency streaming
- **RTMP** - Flash streaming  
- **libsrt** - Secure reliable transport
- **libzmq** - Messaging
- **librist** - Reliable streaming
- **libssh** - SSH support

### Containers & Other
- **Blu-ray** (libbluray) - Blu-ray disc support  
- **OpenMPT** - Module music files
- **GME** - Game music files
- **CACA** - ASCII art output
- **QR codes** (libqrencode, quirc) - QR code generation/detection
- **Chromaprint** - Audio fingerprinting
- **ARIBB24** - Japanese subtitles
- **XML** (libxml2) - XML parsing
- **Flite** - Text-to-speech

## Notes

- Regular builds include non-free codecs like FDK-AAC
- Use `RELEASE=1` to build GPL-only version  
- All binaries are statically linked (no dependencies needed)
- Cross-compilation uses musl libc for better compatibility
- The build takes a while since it compiles everything from source

