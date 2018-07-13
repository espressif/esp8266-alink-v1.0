# Automatically generated build file. Do not edit.
COMPONENT_INCLUDES += $(IDF_PATH)/components/cjson/include $(IDF_PATH)/components/cjson/cJSON
COMPONENT_LDFLAGS += -L$(BUILD_DIR_BASE)/cjson -lcjson
COMPONENT_LINKER_DEPS += 
COMPONENT_SUBMODULES += 
COMPONENT_LIBRARIES += cjson
component-cjson-build: 
