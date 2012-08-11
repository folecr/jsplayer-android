LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := mozillaplayer_shared

LOCAL_MODULE_FILENAME := libmozillaplayer

LOCAL_SRC_FILES := mozillaplayer/main.cpp

LOCAL_WHOLE_STATIC_LIBRARIES := jsbindings
LOCAL_WHOLE_STATIC_LIBRARIES += scriptingcore-spidermonkey
LOCAL_WHOLE_STATIC_LIBRARIES += cocos2dx_static
LOCAL_WHOLE_STATIC_LIBRARIES += cocosdenshion_static

LOCAL_LDLIBS := -landroid
LOCAL_LDLIBS += -llog

include $(BUILD_SHARED_LIBRARY)

$(call import-module,jsbindings)
$(call import-module,cocos2dx)
$(call import-module,CocosDenshion/android)
$(call import-module,targets/spidermonkey/common)
