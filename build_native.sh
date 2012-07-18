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
APP_ROOT=$PWD
MOZILLA_ROOT=$PWD/submodules/mozilla-prebuilt
CXX_GENERATOR_ROOT=$PWD/submodules/cocos2d-x/js/cxx-generator
COCOS2DX_ROOT=$PWD/submodules/cocos2d-x

echo "APP_ROOT: $APP_ROOT"
echo "MOZILLA_ROOT: $MOZILLA_ROOT"
echo "CXX_GENERATOR_ROOT: $CXX_GENERATOR_ROOT"

# Currently we only have the android app
APP_ANDROID_ROOT=$APP_ROOT

# Generate bindings for simpletest
echo "Generating bindings..."
echo "change directory to the generator to run it..."
set -x
pwd
pushd $PWD
cd ${CXX_GENERATOR_ROOT}
DYLD_LIBRARY_PATH=${CLANG_ROOT_LOCAL}/lib /opt/local/bin/python2.7 ${CXX_GENERATOR_ROOT}/generator.py ${APP_ANDROID_ROOT}/custom.ini -s test -o ${APP_ANDROID_ROOT}/jni/simple_test_bindings
popd
pwd
set +x

# Generate bindings for cocosdenshion
echo "Generating bindings..."
echo "change directory to the generator to run it..."
set -x
pwd
pushd $PWD
cd ${CXX_GENERATOR_ROOT}
DYLD_LIBRARY_PATH=${CLANG_ROOT_LOCAL}/lib /opt/local/bin/python2.7 ${CXX_GENERATOR_ROOT}/generator.py ${APP_ANDROID_ROOT}/cocosdenshion.ini -s simple-audio-engine -o ${APP_ANDROID_ROOT}/jni/cocosdenshion_bindings
popd
pwd
set +x

# build
echo "Building native code..."
$NDK_ROOT_LOCAL/ndk-build -C $APP_ANDROID_ROOT \
    NDK_MODULE_PATH=${APP_ANDROID_ROOT}/jni:${MOZILLA_ROOT}:${CXX_GENERATOR_ROOT}:${COCOS2DX_ROOT}:${COCOS2DX_ROOT}/cocos2dx/platform/third_party/android/prebuilt
echo "... Building native code : Done."
