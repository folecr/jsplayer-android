# set params
NDK_ROOT_LOCAL=/path/to/android/ndk
MOZILLA_ROOT_LOCAL=/path/to/spidermonkey
CXX_GENERATOR_ROOT_LOCAL=/path/to/cxx-generator
GAME_ROOT_LOCAL=/path/to/the/game/directory
CLANG_ROOT_LOCAL=/Users/surith/bin/clang/clang+llvm-3.1-x86_64-apple-darwin11

usage(){
cat << EOF
usage: $0 [options]

Build C/C++ native code using Android NDK

OPTIONS:
   -h	this help
EOF
}

while getopts "s" OPTION; do
	case "$OPTION" in
		h)
			usage
			exit 0
			;;
	esac
done

# try to get global variable
if [ $NDK_ROOT"aaa" != "aaa" ]; then
    NDK_ROOT_LOCAL=$NDK_ROOT
    echo "use global definition of NDK_ROOT: $NDK_ROOT"
fi

if [ $MOZILLA_ROOT"aaa" != "aaa" ]; then
    MOZILLA_ROOT_LOCAL=$MOZILLA_ROOT
    echo "use global definition of MOZILLA_ROOT: $MOZILLA_ROOT"
fi

if [ $CXX_GENERATOR_ROOT"aaa" != "aaa" ]; then
    CXX_GENERATOR_ROOT_LOCAL=$CXX_GENERATOR_ROOT
    echo "use global definition of CXX_GENERATOR_ROOT: $CXX_GENERATOR_ROOT"
fi

if [ $CLANG_ROOT"aaa" != "aaa" ]; then
    CLANG_ROOT_LOCAL=$CLANG_ROOT
    echo "use global definition of CLANG_ROOT: $CLANG_ROOT"
fi

if [ $GAME_ROOT"aaa" != "aaa" ]; then
    GAME_ROOT_LOCAL=$GAME_ROOT
    echo "use global definition of GAME_ROOT: $GAME_ROOT_LOCAL"
else
# if GAME_ROOT is not set
# use current directory
    GAME_ROOT_LOCAL=$PWD
    echo "using current directory for GAME_ROOT: $GAME_ROOT_LOCAL"
fi

# Currently we only have the android game
GAME_ANDROID_ROOT=$GAME_ROOT_LOCAL

# Generate bindings
echo "Generating bindings..."
echo "change directory to the generator to run it..."
set -x
pwd
pushd $PWD
cd ${CXX_GENERATOR_ROOT_LOCAL}
DYLD_LIBRARY_PATH=${CLANG_ROOT_LOCAL}/lib /opt/local/bin/python2.7 ${CXX_GENERATOR_ROOT_LOCAL}/generator.py ${GAME_ROOT_LOCAL}/custom.ini -s test -o ${GAME_ROOT_LOCAL}/jni/simple_test_bindings
popd
pwd
set +x

# build
echo "Building native code..."
$NDK_ROOT_LOCAL/ndk-build -C $GAME_ANDROID_ROOT \
    NDK_MODULE_PATH=${GAME_ANDROID_ROOT}/jni:${MOZILLA_ROOT_LOCAL}:${CXX_GENERATOR_ROOT_LOCAL}
echo "... Building native code : Done."
