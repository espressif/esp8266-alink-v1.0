# Automatically generated build file. Do not edit.
COMPONENT_INCLUDES += $(IDF_PATH)/components/ssl/wolfssl/include $(IDF_PATH)/components/ssl/wolfssl/wolfssl $(IDF_PATH)/components/ssl/wolfssl/wolfssl/wolfssl
COMPONENT_LDFLAGS += -L$(BUILD_DIR_BASE)/ssl -L $(IDF_PATH)/components/ssl/wolfssl/lib -lwolfssl
COMPONENT_LINKER_DEPS += $(IDF_PATH)/components/ssl/wolfssl/lib/libwolfssl.a
COMPONENT_SUBMODULES += 
COMPONENT_LIBRARIES += ssl
component-ssl-build: 
