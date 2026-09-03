#!/bin/sh
cd common/proj.android_studio/jni/
ndk-build
cd ../../../


cd render/proj.android_studio/jni/
ndk-build
cd ../../../

cp common/proj.android_studio/obj/local/arm64-v8a/libcommon.a ../libs/android-arm64/
cp render/proj.android_studio/obj/local/arm64-v8a/librender.a ../libs/android-arm64/

touch ../source/conch/JCConch.cpp
cd conch/proj.android_studio/jni/
ndk-build
cd ../../../
cp conch/proj.android_studio/libs/arm64-v8a/liblayaair.so  conch/proj.android_studio/conch5/libs/arm64-v8a/liblayaair.so

cp conch/proj.android_studio/libs/  conch/proj.android_studio/conch5/ -f -R
