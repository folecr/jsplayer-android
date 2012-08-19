APPNAME="jsplayer-android"

# options

debug=
verbose=

usage(){
cat << EOF
usage: $0 [options]

Build C/C++ code for $APPNAME using Android NDK

OPTIONS:
-d	Build in debug mode
-v  Turn on verbose output
-h	this help

Dependencies :
PYTHON_BIN
CLANG_ROOT
NDK_ROOT

Paths to sources (defaults are in ./submodules) :
COCOS2DX_ROOT
CXX_GENERATOR_ROOT
MOZILLA_ROOT

Define this to run the build script from an external directory :
APP_ROOT

EOF
}

while getopts "dvh" OPTION; do
case "$OPTION" in
d)
debug=1
;;
v)
verbose=1
;;
h)
usage
exit 0
;;
esac
done

# exit this script if any commmand fails
set -e

# read user.cfg if it exists and is readable

_CFG_FILE=$(dirname "$0")"/user.cfg"
if [ -e "$_CFG_FILE" ]
then
    [ -r "$_CFG_FILE" ] || die "Fatal Error: $_CFG_FILE exists but is unreadable"
    . "$_CFG_FILE"
fi

# paths

if [ -z "${NDK_ROOT+aaa}" ]; then
# ... if NDK_ROOT is not set, use "$HOME/bin/android-ndk"
    NDK_ROOT="$HOME/bin/android-ndk"
fi

if [ -z "${CLANG_ROOT+aaa}" ]; then
    CLANG_ROOT="$HOME/bin/clang+llvm-3.1"
fi

if [ -z "${PYTHON_BIN+aaa}" ]; then
# ... if PYTHON_BIN is not set, use "/usr/bin/python2.7"
    PYTHON_BIN="/usr/bin/python2.7"
fi

# paths with defaults hardcoded to relative paths

if [ -z "${APP_ROOT+aaa}" ]; then
    APP_ROOT="$PWD"
fi

if [ -z "${MOZILLA_ROOT+aaa}" ]; then
    MOZILLA_ROOT="$PWD/submodules/mozilla-prebuilt"
fi

if [ -z "${CXX_GENERATOR_ROOT+aaa}" ]; then
    CXX_GENERATOR_ROOT="$PWD/submodules/cxx-generator"
fi

if [ -z "${COCOS2DX_ROOT+aaa}" ]; then
    COCOS2DX_ROOT="$PWD/submodules/cocos2d-x"
fi

echo "CLANG_ROOT: $CLANG_ROOT"
echo "NDK_ROOT: $NDK_ROOT"
echo "APP_ROOT: $APP_ROOT"
echo "MOZILLA_ROOT: $MOZILLA_ROOT"
echo "CXX_GENERATOR_ROOT: $CXX_GENERATOR_ROOT"
echo "COCOS2DX_ROOT: $COCOS2DX_ROOT"
echo "PYTHON_BIN: $PYTHON_BIN"

# Currently we only have the android app
APP_ANDROID_ROOT="$APP_ROOT"

DEBUG_OPTIONS=
if [[ $debug ]]; then
    DEBUG_OPTIONS="NDK_DEBUG=1"
fi

VERBOSE_OPTIONS=
if [[ $verbose ]]; then
    VERBOSE_OPTIONS="NDK_LOG=1 V=1"
fi

# Generate bindings for simpletest
echo "Generating bindings..."
set -x
LD_LIBRARY_PATH=${CLANG_ROOT}/lib $PYTHON_BIN ${CXX_GENERATOR_ROOT}/generator.py ${APP_ANDROID_ROOT}/test.ini -s test -o ${APP_ANDROID_ROOT}/jni/simple_test_bindings
set +x

# build
echo "Building native code..."
$NDK_ROOT/ndk-build -C $APP_ANDROID_ROOT $DEBUG_OPTIONS $VERBOSE_OPTIONS\
    NDK_MODULE_PATH=${APP_ANDROID_ROOT}/jni:${MOZILLA_ROOT}:${CXX_GENERATOR_ROOT}:${COCOS2DX_ROOT}:${COCOS2DX_ROOT}/cocos2dx/platform/third_party/android/prebuilt
echo "... Building native code : Done."
