LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := jsplayer_shared

LOCAL_MODULE_FILENAME := libjsplayer

LOCAL_SRC_FILES := main.cpp

LOCAL_WHOLE_STATIC_LIBRARIES := jsbindings
LOCAL_WHOLE_STATIC_LIBRARIES += scriptingcore-spidermonkey
LOCAL_WHOLE_STATIC_LIBRARIES += simpletest
LOCAL_WHOLE_STATIC_LIBRARIES += autogentestbindings
LOCAL_WHOLE_STATIC_LIBRARIES += cocos2dx_static
LOCAL_WHOLE_STATIC_LIBRARIES += autogencocos2dxbindings
LOCAL_WHOLE_STATIC_LIBRARIES += cocosdenshion_static
LOCAL_WHOLE_STATIC_LIBRARIES += autogencocosdenshionbindings
LOCAL_WHOLE_STATIC_LIBRARIES += cocosplayer

LOCAL_LDLIBS := -landroid
LOCAL_LDLIBS += -llog

include $(BUILD_SHARED_LIBRARY)

$(call import-module,jsbindings)
$(call import-module,simple_test)
$(call import-module,simple_test_bindings)
$(call import-module,cocos2dx)
$(call import-module,cocos2dx_bindings)
$(call import-module,CocosDenshion/android)
$(call import-module,cocosdenshion_bindings)
$(call import-module,targets/spidermonkey/common)
$(call import-module,cocosplayer)
