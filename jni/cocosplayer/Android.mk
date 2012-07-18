LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := cocosplayer

LOCAL_MODULE_FILENAME := libcocosplayer

LOCAL_SRC_FILES := AppDelegate.cpp \
                   Player.cpp \
                   Java_org_cocos2dx_lib_Cocos2dxRenderer.cpp

LOCAL_C_INCLUDES := $(LOCAL_PATH)

LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)

LOCAL_WHOLE_STATIC_LIBRARIES := spidermonkey_static
LOCAL_WHOLE_STATIC_LIBRARIES += scriptingcore-spidermonkey
LOCAL_WHOLE_STATIC_LIBRARIES += cocos2dx_static
LOCAL_WHOLE_STATIC_LIBRARIES += cocosdenshion_static

LOCAL_LDLIBS := -landroid
LOCAL_LDLIBS += -llog

include $(BUILD_STATIC_LIBRARY)

$(call import-module,spidermonkey/android)
$(call import-module,targets/spidermonkey/common)
$(call import-module,cocos2dx)
$(call import-module,CocosDenshion/android)
