# Automatically generated build file. Do not edit.
COMPONENT_INCLUDES += $(IDF_PATH)/components/freertos/include $(IDF_PATH)/components/freertos/include $(IDF_PATH)/components/freertos/include/freertos $(IDF_PATH)/components/freertos/include/freertos/private $(IDF_PATH)/components/freertos/include/port $(IDF_PATH)/components/freertos/include/port/freertos
COMPONENT_LDFLAGS += -L$(BUILD_DIR_BASE)/freertos -lfreertos
COMPONENT_LINKER_DEPS += 
COMPONENT_SUBMODULES += 
COMPONENT_LIBRARIES += freertos
component-freertos-build: 
