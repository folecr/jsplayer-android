LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := game_shared

LOCAL_MODULE_FILENAME := libgame

LOCAL_SRC_FILES := helloworld/main.cpp

LOCAL_WHOLE_STATIC_LIBRARIES := jsbindings
LOCAL_WHOLE_STATIC_LIBRARIES += simpletest
LOCAL_WHOLE_STATIC_LIBRARIES += autogentestbindings-spidermonkey

LOCAL_LDLIBS := -landroid
LOCAL_LDLIBS += -llog

include $(BUILD_SHARED_LIBRARY)

$(call import-module,jsbindings)
$(call import-module,simple_test)
$(call import-module,simple_test_bindings)
