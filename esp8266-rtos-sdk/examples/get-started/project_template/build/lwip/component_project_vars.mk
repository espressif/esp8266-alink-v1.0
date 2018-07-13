# Automatically generated build file. Do not edit.
COMPONENT_INCLUDES += $(IDF_PATH)/components/lwip/include $(IDF_PATH)/components/lwip/include/lwip/apps $(IDF_PATH)/components/lwip/lwip/src/include $(IDF_PATH)/components/lwip/lwip/src/include/posix $(IDF_PATH)/components/lwip/port/esp8266/include
COMPONENT_LDFLAGS += -L$(BUILD_DIR_BASE)/lwip -llwip
COMPONENT_LINKER_DEPS += 
COMPONENT_SUBMODULES += 
COMPONENT_LIBRARIES += lwip
component-lwip-build: 
