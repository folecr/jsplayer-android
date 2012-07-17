LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := jsbindings

LOCAL_SRC_FILES := jsbindings.cpp \
                   JNI_spidermonkey_bindings.cpp

LOCAL_C_INCLUDES := $(LOCAL_PATH)

LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)

LOCAL_WHOLE_STATIC_LIBRARIES := spidermonkey_static
LOCAL_WHOLE_STATIC_LIBRARIES += autogentestbindings
LOCAL_WHOLE_STATIC_LIBRARIES += autogencocosdenshionbindings

LOCAL_LDLIBS := -landroid
LOCAL_LDLIBS += -llog

include $(BUILD_STATIC_LIBRARY)

$(call import-module,spidermonkey/android)
$(call import-module,simple_test_bindings)
$(call import-module,cocosdenshion_bindings)
