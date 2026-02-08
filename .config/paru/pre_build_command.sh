#/usr/bin/env bash

function print_step {
    local space
    printf -v space '%*s' "$(($1 * 4))" ''
    printf '%s -> %s\n' "$space" "$2"
}

function init {
    print_step 0 "Running PreBuildCommand for ${PKGBASE} ${VERSION}"
}

function patch_ffmpeg_full {
    # Remove openvino due to big size of git repo and removed GITFLAGS makepkg
    # https://gitlab.archlinux.org/pacman/pacman/-/merge_requests/182
    # Openvino support is currently not needed for me anyways
    print_step 1 'Removing openvino from PKGBUILD'
    cat <<EOF | git apply
diff --git a/PKGBUILD b/PKGBUILD
index f2fe135..f61bf8f 100644
--- a/PKGBUILD
+++ b/PKGBUILD
@@ -91,7 +91,6 @@ depends=(
     'opencv'
     'openh264'
     'openjpeg2'
-    'openvino'
     'opus'
     'qrencode'
     'quirc'
@@ -317,7 +316,6 @@ build() {
         --enable-libopenh264 \\
         --enable-libopenjpeg \\
         --enable-libopenmpt \\
-        --enable-libopenvino \\
         --enable-libopus \\
         --enable-libplacebo \\
         --enable-libpulse \\
EOF

    echo
}

if [[ "${PKGBASE}" == "ffmpeg-full" ]]; then
    init
    patch_ffmpeg_full
fi
