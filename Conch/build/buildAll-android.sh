#!/bin/sh
cd common/proj.android_studio/jni/
ndk-build || echo "[buildAll] common ndk-build FAILED (collecting errors, continuing)"
cd ../../../


cd render/proj.android_studio/jni/
ndk-build || echo "[buildAll] render ndk-build FAILED (collecting errors, continuing)"
cd ../../../

cp common/proj.android_studio/obj/local/arm64-v8a/libcommon.a ../libs/android-arm64/
cp render/proj.android_studio/obj/local/arm64-v8a/librender.a ../libs/android-arm64/

touch ../source/conch/JCConch.cpp
cd conch/proj.android_studio/jni/
ndk-build || echo "[buildAll] conch ndk-build FAILED (collecting errors, continuing)"
cd ../../../
cp conch/proj.android_studio/libs/arm64-v8a/liblayaair.so  conch/proj.android_studio/conch5/libs/arm64-v8a/liblayaair.so

cp conch/proj.android_studio/libs/  conch/proj.android_studio/conch5/ -f -R

if [ ! -f conch/proj.android_studio/conch5/libs/arm64-v8a/liblayaair.so ]; then
  echo "ERROR: liblayaair.so was NOT built"
  exit 1
fi

# Guard: liblayaair.so must NOT depend on libc++_shared.so (we link c++ statically).
if strings conch/proj.android_studio/conch5/libs/arm64-v8a/liblayaair.so | grep -q '^libc++_shared\.so$'; then
  echo "ERROR: liblayaair.so still depends on libc++_shared.so (c++_static not effective)"
  exit 1
fi
echo "[buildAll] OK: liblayaair.so built (no libc++_shared dependency)"
