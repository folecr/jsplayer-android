JS Player runs your JS code on Android :

 * Uses the SpiderMonkey VM
 * Can run pure JavaScript
 * Is set up to hook into the C++ generator script
 * ... and automatically generate bindings to your C++ code
 * ... which you can run from JavaScript!

Coming soon :

 * Launch your JS code in a Cocos2D-X environment

Build :

 * Checkout the repo
 * Update submodules
 * Install Android NDK, Android SDK and Clang/LLVM
 * Install Python 2.7
 * Run build_native.sh 

    NDK_ROOT=/opt/android/android-ndk CLANG_ROOT=/opt/bin/clang/clang+llvm-3.1-x86_64-apple-darwin11 ./build_native.sh

 * then...

    ant debug install
