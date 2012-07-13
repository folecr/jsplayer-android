# set params
NDK_ROOT_LOCAL=/path/to/android/ndk
CLANG_ROOT_LOCAL=/path/to/clang+llvm-3.1

# try to get global variable
if [ $NDK_ROOT"aaa" != "aaa" ]; then
    NDK_ROOT_LOCAL=$NDK_ROOT
    echo "use global definition of NDK_ROOT: $NDK_ROOT"
fi

if [ $CLANG_ROOT"aaa" != "aaa" ]; then
    CLANG_ROOT_LOCAL=$CLANG_ROOT
    echo "use global definition of CLANG_ROOT: $CLANG_ROOT"
fi

usage(){
cat << EOF
usage: $0 [options]

Build C/C++ native code using Android NDK

OPTIONS:
   -h	this help
EOF
}

# ------------

# hardcoded
GAME_ROOT=$PWD
MOZILLA_ROOT=$PWD/submodules/mozilla-prebuilt
CXX_GENERATOR_ROOT=$PWD/submodules/cocos2d-x/js/cxx-generator

echo "GAME_ROOT: $GAME_ROOT"
echo "MOZILLA_ROOT: $MOZILLA_ROOT"
echo "CXX_GENERATOR_ROOT: $CXX_GENERATOR_ROOT"

# Currently we only have the android game
GAME_ANDROID_ROOT=$GAME_ROOT

# Generate bindings
echo "Generating bindings..."
echo "change directory to the generator to run it..."
set -x
pwd
pushd $PWD
cd ${CXX_GENERATOR_ROOT}
DYLD_LIBRARY_PATH=${CLANG_ROOT_LOCAL}/lib /opt/local/bin/python2.7 ${CXX_GENERATOR_ROOT}/generator.py ${GAME_ANDROID_ROOT}/custom.ini -s test -o ${GAME_ANDROID_ROOT}/jni/simple_test_bindings
popd
pwd
set +x

# build
echo "Building native code..."
$NDK_ROOT_LOCAL/ndk-build -C $GAME_ANDROID_ROOT \
    NDK_MODULE_PATH=${GAME_ANDROID_ROOT}/jni:${MOZILLA_ROOT}:${CXX_GENERATOR_ROOT}
echo "... Building native code : Done."
