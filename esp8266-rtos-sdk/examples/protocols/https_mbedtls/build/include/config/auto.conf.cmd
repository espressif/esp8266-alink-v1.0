deps_config := \
	/home/liqingqiao/esp/ESP8266_RTOS_SDK/components/esp8266/Kconfig \
	/home/liqingqiao/esp/ESP8266_RTOS_SDK/components/freertos/Kconfig \
	/home/liqingqiao/esp/ESP8266_RTOS_SDK/components/log/Kconfig \
	/home/liqingqiao/esp/ESP8266_RTOS_SDK/components/lwip/Kconfig \
	/home/liqingqiao/esp/ESP8266_RTOS_SDK/components/newlib/Kconfig \
	/home/liqingqiao/esp/ESP8266_RTOS_SDK/components/ssl/Kconfig \
	/home/liqingqiao/esp/ESP8266_RTOS_SDK/components/tcpip_adapter/Kconfig \
	/home/liqingqiao/esp/ESP8266_RTOS_SDK/components/bootloader/Kconfig.projbuild \
	/home/liqingqiao/esp/ESP8266_RTOS_SDK/components/esptool_py/Kconfig.projbuild \
	/home/liqingqiao/esp/ESP8266_RTOS_SDK/examples/protocols/https_mbedtls/main/Kconfig.projbuild \
	/home/liqingqiao/esp/ESP8266_RTOS_SDK/components/partition_table/Kconfig.projbuild \
	/home/liqingqiao/esp/ESP8266_RTOS_SDK/Kconfig

include/config/auto.conf: \
	$(deps_config)


$(deps_config): ;
