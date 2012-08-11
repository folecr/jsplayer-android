LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := spidermonkeyplayer_shared

LOCAL_MODULE_FILENAME := libspidermonkeyplayer

LOCAL_SRC_FILES := spidermonkeyplayer-main.cpp

LOCAL_WHOLE_STATIC_LIBRARIES := spidermonkeybindings
LOCAL_WHOLE_STATIC_LIBRARIES += scriptingcore-spidermonkey
LOCAL_WHOLE_STATIC_LIBRARIES += cocos2dx_static
LOCAL_WHOLE_STATIC_LIBRARIES += cocosdenshion_static

LOCAL_LDLIBS := -landroid
LOCAL_LDLIBS += -llog

include $(BUILD_SHARED_LIBRARY)

$(call import-module,spidermonkeybindings)
$(call import-module,targets/spidermonkey/common)
$(call import-module,cocos2dx)
$(call import-module,CocosDenshion/android)
