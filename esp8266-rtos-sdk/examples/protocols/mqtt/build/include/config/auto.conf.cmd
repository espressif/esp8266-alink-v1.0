deps_config := \
	/home/liqingqiao/esp/ESP8266_RTOS_SDK/components/freertos/Kconfig \
	/home/liqingqiao/esp/ESP8266_RTOS_SDK/components/lwip/Kconfig \
	/home/liqingqiao/esp/ESP8266_RTOS_SDK/components/newlib/Kconfig \
	/home/liqingqiao/esp/ESP8266_RTOS_SDK/components/ssl/Kconfig \
	/home/liqingqiao/esp/ESP8266_RTOS_SDK/components/tcpip_adapter/Kconfig \
	/home/liqingqiao/esp/ESP8266_RTOS_SDK/components/esptool_py/Kconfig.projbuild \
	/home/liqingqiao/esp/ESP8266_RTOS_SDK/Kconfig

include/config/auto.conf: \
	$(deps_config)


$(deps_config): ;
