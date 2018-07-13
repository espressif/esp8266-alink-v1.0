# Automatically generated build file. Do not edit.
COMPONENT_INCLUDES += $(IDF_PATH)/components/ssl/openssl/include $(IDF_PATH)/components/ssl/mbedtls/mbedtls/include $(IDF_PATH)/components/ssl/mbedtls/port/esp8266/include
COMPONENT_LDFLAGS += -L$(BUILD_DIR_BASE)/ssl -lssl
COMPONENT_LINKER_DEPS += 
COMPONENT_SUBMODULES += 
COMPONENT_LIBRARIES += ssl
component-ssl-build: 
