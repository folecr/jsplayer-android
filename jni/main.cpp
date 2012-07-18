#include <jni.h>
#include <android/log.h>
#include <JNI_spidermonkey_bindings.h>
#include <AppDelegate.h>
#include <platform/android/jni/JniHelper.h>

#define  LOG_TAG    "hellojs-main"
#define  LOGD(...)  __android_log_print(ANDROID_LOG_DEBUG,LOG_TAG,__VA_ARGS__)

extern "C"
{

jint JNI_OnLoad (JavaVM *vm, void *reserved) {
    LOGD("JNI_OnLoad vm : 0x%X, reserved : 0x%X", vm, reserved);

    JNIEnv* env;
    vm->GetEnv((void**)&env, JNI_VERSION_1_4);

    // SpiderMonkey bindings (without Cocos)
    JNI_spidermonkey_bindings::registernatives(env);

    // Cocos2D-X
    cocos2d::JniHelper::setJavaVM(vm);

    LOGD("return JNI_VERSION_1_4");
	return JNI_VERSION_1_4;
}

}

#if 0

#include "HelloWorldScene.h"

using namespace cocos2d;
using namespace cocos2d::extension;

extern "C"
{

void Java_org_cocos2dx_lib_Cocos2dxRenderer_nativeInit(JNIEnv*  env, jobject thiz, jint w, jint h)
{
    if (!CCDirector::sharedDirector()->getOpenGLView())
    {
        CCEGLView *view = &CCEGLView::sharedOpenGLView();
        view->setFrameSize(w, h);
        // set the design resolution screen size, if you want to use Design Resoulution scaled to current screen, please uncomment next line.
        // view->setDesignResolutionSize(480, 320);

        AppDelegate *pAppDelegate = new AppDelegate();
        CCApplication::sharedApplication().run();
    }
    else
    {
        ccDrawInit();
        ccGLInvalidateStateCache();
        
        CCShaderCache::sharedShaderCache()->reloadDefaultShaders();
        CCTextureCache::reloadAllTextures();
        CCNotificationCenter::sharedNotificationCenter()->postNotification(EVNET_COME_TO_FOREGROUND, NULL);
        CCDirector::sharedDirector()->setGLDefaultValues(); 
    }
}

}
#endif // 0
