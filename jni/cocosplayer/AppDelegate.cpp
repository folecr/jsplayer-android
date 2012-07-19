#include <AppDelegate.h>
#include <Player.h>
#include <ScriptingCore.h>
#include <autogencocosdenshionbindings.hpp>
#include <autogencocos2dxbindings.hpp>
#include <platform/CCFileUtils.h>

#include <android/log.h>

#define  LOG_TAG    "AppDelegate.cpp"
#define  LOGD(...)  __android_log_print(ANDROID_LOG_DEBUG,LOG_TAG,__VA_ARGS__)

USING_NS_CC;

AppDelegate::AppDelegate() {

}

AppDelegate::~AppDelegate() 
{
}

bool AppDelegate::applicationDidFinishLaunching() {
    // initialize director
    CCDirector *pDirector = CCDirector::sharedDirector();

    pDirector->setOpenGLView(&CCEGLView::sharedOpenGLView());

    // enable High Resource Mode(2x, such as iphone4) and maintains low resource on other devices.
    // pDirector->enableRetinaDisplay(true);

    // turn on display FPS
    pDirector->setDisplayStats(true);

    // set FPS. the default value is 1.0/60 if you don't call this
    pDirector->setAnimationInterval(1.0 / 60);

    // create a scene. it's an autorelease object
    CCScene *pScene = Player::scene();

    // CocosDenshion bindings
    register_all_autogencocosdenshionbindings();
    register_all_autogencocos2dxbindings();

    unsigned long size = 0;
    unsigned char* content =
        CCFileUtils::sharedFileUtils()->getFileData("javascript-spidermonkey/main.js",
                                                    "rb",
                                                    &size);

    LOGD("size = %d", size);
    if (content) {
        LOGD("content = %s", content);

        ScriptingCore::getInstance().evalString((const char*)content, NULL);
    } else {
        LOGD("FAIL : content is NULL");
    }

    // run
    // pDirector->runWithScene(pScene);

    return true;
}

// This function will be called when the app is inactive. When comes a phone call,it's be invoked too
void AppDelegate::applicationDidEnterBackground() {
    CCDirector::sharedDirector()->stopAnimation();

    // if you use SimpleAudioEngine, it must be pause
    // SimpleAudioEngine::sharedEngine()->pauseBackgroundMusic();
}

// this function will be called when the app is active again
void AppDelegate::applicationWillEnterForeground() {
    CCDirector::sharedDirector()->startAnimation();

    // if you use SimpleAudioEngine, it must resume here
    // SimpleAudioEngine::sharedEngine()->resumeBackgroundMusic();
}
