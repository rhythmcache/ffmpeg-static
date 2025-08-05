#!/bin/bash

build_libunwind() {
    echo "[+] Building libunwind for $ARCH..."

    if [ ! -d "$BUILD_DIR/libunwind" ]; then
        git clone --depth 1 https://github.com/libunwind/libunwind.git "$BUILD_DIR/libunwind"
    fi

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

build_rav1e() {
    build_libunwind

    echo "[+] Checking if Rust target '$RUST_TARGET' is installed..."
if ! rustup target list --installed | grep -q "^$RUST_TARGET$"; then
    echo "[+] Installing Rust target '$RUST_TARGET'..."
    rustup target add "$RUST_TARGET" || {
        echo "[-] Failed to add target $RUST_TARGET"
        exit 1
    }
fi

    echo "[+] Building rav1e for $ARCH..."
    echo "[+] Cloning..."

    if [ ! -d "$BUILD_DIR/rav1e" ]; then
        git clone --depth 1 https://github.com/xiph/rav1e.git "$BUILD_DIR/rav1e"
    fi

    cd "$BUILD_DIR/rav1e" || exit 1
    cargo clean

    mkdir -p .cargo

    cat > .cargo/config.toml << EOF
[target.$RUST_TARGET]
linker = "$CC_ABS"
ar = "$AR_ABS"
rustflags = ["-Ctarget-feature=+crt-static"]

[build]
target = "$RUST_TARGET"
EOF

    export CC="$CC_ABS"
    export CXX="$CXX_ABS"
    export AR="$AR_ABS"

    cargo cinstall --release \
        --target "$RUST_TARGET" \
        --prefix "$PREFIX" \
        --library-type staticlib \
        --no-default-features \
        --features "asm"
}
