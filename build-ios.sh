#!/bin/bash -e

set -x

rm -rf _builds/ios

cmake -H. -B_builds/ios \
    -DHUNTER_STATUS_DEBUG=ON \
    -DCMAKE_TOOLCHAIN_FILE=${POLLY_ROOT}/ios.cmake \
    -GXcode

open _builds/ios/Weather.xcodeproj
