build_zlib() {
    echo "Building zlib for $ARCH (required for OpenSSL and curl)..."
    cd "$BUILD_DIR/zlib"

    export CHOST="$HOST"

    CONFIGURE_CFLAGS="-fPIC --sysroot=$SYSROOT"

    CFLAGS="$CONFIGURE_CFLAGS" ./configure --prefix="$PREFIX" --static

    make -j"$(nproc)" CFLAGS="$CFLAGS"
    make install

    echo "✔ zlib built successfully"
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
      CXXFLAGS="$CXXFLAGS" \
      LDFLAGS="$LDFLAGS"
    make -j"$(nproc)"
    make install
    
    echo "✔ liblzma built successfully"
}

build_zstd() {
    cd "$BUILD_DIR/zstd"
    
    make clean || true
    

    make -j"$(nproc)" -C lib \
        CC="$CC_ABS" \
        AR="$AR_ABS" \
        RANLIB="$RANLIB_ABS" \
        CFLAGS="$CFLAGS" \
        LDFLAGS="$LDFLAGS" \
        PREFIX="$PREFIX" \
        HAVE_THREAD=1 \
        ZSTD_LEGACY_SUPPORT=0 \
        libzstd.a
    
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
    
    rm -rf "$BUILD_X265_DIR"
    mkdir -p "$BUILD_X265_DIR"
    cd "$BUILD_X265_DIR"

    CC_ABS=$(which "$CC")
    CXX_ABS=$(which "$CXX") 
    AR_ABS=$(which "$AR")
    RANLIB_ABS=$(which "$RANLIB")
    STRIP_ABS=$(which "$STRIP")
    NM_ABS=$(which "$NM")

    echo "Current directory: $(pwd)"
    echo "Using CC: $CC_ABS"
    echo "Using AR: $AR_ABS"
    
    for tool in "$CC_ABS" "$CXX_ABS" "$AR_ABS" "$RANLIB_ABS" "$STRIP_ABS" "$NM_ABS"; do
        if [ -z "$tool" ] || [ ! -x "$tool" ]; then
            echo "ERROR: Tool not found or not executable: $tool"
            return 1
        fi
    done
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

    make -j"$(nproc)"
    
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
  HEADER_SRC_DIR="$BUILD_DIR/libgsm"
  HEADER_DST_DIR="$PREFIX/include/gsm"
  mkdir -p "$HEADER_DST_DIR"
  find "$HEADER_SRC_DIR" -type f -name '*.h' -exec cp {} "$HEADER_DST_DIR/" \;


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

    ninja -j"$(nproc)"
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

   case "$ARCH" in
  x86_64|x86)
    WITH_SIMD=ON
    ;;
  arm*|aarch64)
    WITH_SIMD=OFF
    ;;
  *)
    WITH_SIMD=OFF
    ;;
esac

    mkdir -p build && cd build

    cmake .. \
        "${COMMON_CMAKE_FLAGS[@]}" \
        -DCMAKE_BUILD_TYPE=Release \
        -DENABLE_SHARED=OFF \
        -DENABLE_STATIC=ON \
        -DWITH_SIMD="${WITH_SIMD}" \
        -DWITH_TOOLS=OFF \
         -DWITH_TESTS=OFF \
         -DWITH_FUZZ=OFF \
         -DWITH_TURBOJPEG=OFF


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

    make -j"$(nproc)" && make install
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

    ninja -C build -j"$(nproc)"
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

    make -j"$(nproc)"
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

    make -j"$(nproc)"
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
  cd "$BUILD_DIR/libilbc" || exit 1
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

  make -j"$(nproc)" && make install
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
    local ASM_FLAG=""

    if [ "$ARCH" != "x86" ] && [ "$ARCH" != "x86_64" ]; then
        ASM_FLAG="--disable-asm"
    fi

    [ -f configure.bak ] && cp "configure.bak" "configure"
    cp "configure" "configure.bak"

        ./configure \
        --prefix="$PREFIX" \
        --host="$TARGET" \
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
    local ASM_FLAG=""

    if [ "$ARCH" != "x86" ] && [ "$ARCH" != "x86_64" ]; then
        ASM_FLAG="--disable-asm"
    fi

    [ -f configure.bak ] && cp "configure.bak" "configure"
    cp "configure" "configure.bak"

        ./configure \
        --prefix="$PREFIX" \
        --host="$TARGET" \
        --extra-cflags="-fPIC -Os -ffunction-sections -fdata-sections -DNDEBUG" \
        --extra-ldflags="-static -Wl,--gc-sections -Wl,--strip-all -Wl,--allow-multiple-definition" \
          $ASM_FLAG \
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
        -j"$(nproc)"
    
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
    cmake --build . --target install -- -j"$(nproc)"
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
    cmake --build . --target install -- -j"$(nproc)"
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

    make -j"$(nproc)"
    make install
}


build_pcre2() {
    echo "Building pcre2 for $ARCH....."
    cd "$BUILD_DIR/pcre2"
    rm -rf out && mkdir out && cd out

    cmake .. \
        "${COMMON_CMAKE_FLAGS[@]}" \
        -DBUILD_SHARED_LIBS=OFF \
        -DPCRE2_BUILD_PCRE2_16=OFF \
        -DPCRE2_BUILD_PCRE2_32=OFF \
        -DPCRE2_BUILD_TESTS=OFF \
        -DPCRE2_BUILD_PCRE2GREP=OFF \
        -DPCRE2_BUILD_PCRE2TEST=OFF \
        -DPCRE2_SUPPORT_JIT=OFF \
        -DPCRE2_STATIC_RUNTIME=ON \
        -DCMAKE_POSITION_INDEPENDENT_CODE=ON

    make -j"$(nproc)"
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
    make -j"$(nproc)"
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

    make -j"$(nproc)"
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

    make -j"$(nproc)"
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

    [ -f "BUILD" ] && mv "BUILD" "BUILD.bazzle"

    cmake -B build -S . \
        "${COMMON_CMAKE_FLAGS[@]}" \
        -DCMAKE_BUILD_TYPE=Release \
        -DBUILD_SHARED_LIBS=OFF \
        -DHWY_ENABLE_CONTRIB=OFF \
        -DHWY_ENABLE_TESTS=OFF

    cmake --build build -j"$(nproc)"
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


    make -j"$(nproc)"
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

    make -j"$(nproc)"
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
        --disable-java \
        --disable-ruby \
        --disable-python \
         --disable-csharp \
         --disable-cxx \
        --disable-doc \
        --disable-imlib2 \
        --disable-x11 \
        --disable-gl \
        --disable-slang \
       --disable-ncurses \
        --disable-curses \
       --disable-vga \
        --disable-win32 \
        --disable-conio \
        --disable-sdl \
         --disable-tools \
         --disable-tests \
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

    make -j"$(nproc)"
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

    make -j"$(nproc)"
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
        arm*) ARM_FEATURES="enabled" ;;
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
    
    make -j"$(nproc)"
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
