deps_config := \
	/home/liqingqiao/esp/esp-idf/components/app_trace/Kconfig \
	/home/liqingqiao/esp/esp-idf/components/aws_iot/Kconfig \
	/home/liqingqiao/esp/esp-idf/components/bt/Kconfig \
	/home/liqingqiao/esp/esp-idf/components/driver/Kconfig \
	/home/liqingqiao/esp/esp-idf/components/esp32/Kconfig \
	/home/liqingqiao/esp/esp-idf/components/esp_adc_cal/Kconfig \
	/home/liqingqiao/esp/esp-idf/components/ethernet/Kconfig \
	/home/liqingqiao/esp/esp-idf/components/fatfs/Kconfig \
	/home/liqingqiao/esp/esp-idf/components/freertos/Kconfig \
	/home/liqingqiao/esp/esp-idf/components/heap/Kconfig \
	/home/liqingqiao/esp/esp-idf/components/libsodium/Kconfig \
	/home/liqingqiao/esp/esp-idf/components/log/Kconfig \
	/home/liqingqiao/esp/esp-idf/components/lwip/Kconfig \
	/home/liqingqiao/esp/esp-idf/components/mbedtls/Kconfig \
	/home/liqingqiao/esp/esp-idf/components/openssl/Kconfig \
	/home/liqingqiao/esp/esp-idf/components/pthread/Kconfig \
	/home/liqingqiao/esp/esp-idf/components/spi_flash/Kconfig \
	/home/liqingqiao/esp/esp-idf/components/spiffs/Kconfig \
	/home/liqingqiao/esp/esp-idf/components/tcpip_adapter/Kconfig \
	/home/liqingqiao/esp/esp-idf/components/wear_levelling/Kconfig \
	/home/liqingqiao/esp/esp-idf/components/bootloader/Kconfig.projbuild \
	/home/liqingqiao/esp/esp-idf/components/esptool_py/Kconfig.projbuild \
	/home/liqingqiao/esp/esp-idf/components/partition_table/Kconfig.projbuild \
	/home/liqingqiao/esp/esp-idf/Kconfig

include/config/auto.conf: \
	$(deps_config)


$(deps_config): ;
