[[中文]](readme_cn.md) 

# 1. Alink Overview

This document introduces how to use Alink V1.0 and get familiar with its features, including network configuration, upgrading, and data transmission.

## 1.1 What is Alink？
Alink is an integrated turnkey smart device solution provided by the Alibaba group. This solution is composed of three main parts, namely the smart hardware modules (device), the Aliyun server (cloud), and an app (Alibaba Smart Living).

<img src="docs/readme_image/alink_description.png" width="700" />

## 1.2 Why Alink?
Alink is a powerful solution which eliminates the difficulties and complexity that the development of smart home applications entails. The six key phrases that best describe this platform include: low cost, fast development, high security, big data, standardization and customization.

<img src="docs/readme_image/alink_advantage.png" width="700" />

## 1.3 How to use Alink?
Espressif has already ported the Alink SDK to its modules, so users can easily launch their own product with some secondary development based on Espressif modules.

<img src="docs/readme_image/alink_development.png" width="700" />

# 2. Preparation
## 2.1 Basic Knowledge
- If you wish to learn more about Alink, please see Alibaba's [Platform Introduction](https://open.aliplus.com/docs/open/).
- If you wish to learn more about ESP8266, please see [ESP8266 Get Started](https://www.espressif.com/en/support/explore/get-started/esp8266/getting-started-guide).

## 2.2 Hardware Preparation 

- Development Board: 1 x ESP-Launcher
- Router: ESP8266 supports only a 2.4G network connection. Therefore, users must disable the 5G network before connecting to the Alink network. All data must be exchanged through the Aliyun server.
- Mobile phone: [Ali Smart Living (for factory testing)](https://open.aliplus.com/download) must be installed on your phone.

# 3. Development Board 

![ESP_WROOM_02 开发板](docs/readme_image/ESP_WROOM_02_en.png)

* Toggle the *Power (switch 1)* upwards to power up the board. Toggle it downwards to power off the board.
* Toggle the *IO0 pin (switch 2)* downwards (“L”) to enter the download mode. Toggle IO0 pin (switch 2) upwards (“H”) to enter the running mode.
* By default, *EN pin (switch 3)* should always be toggled upwards. 
* A jumper cap must be fitted onto the top two pins of the *Flash select jumper*.
* A jumper cap must be fitted onto the *Power jumper*, as well.
* Press *SW1* (>=3s) to enter the network configuration mode.
* Press *SW2* (>=3s) to disconnect the device and restore the factory settings.

>Note: To enable the above-mentioned instruction, please solder the GPIO4 pin to the small hole next to SW2.

# 4. File Dictionary

    esp8266-alink-v1.0
    ├── bin                                      // stores the generated bin files
    ├── docs                                     // stores the figures used in demo-related documentation
    ├── driver                                   // driver for keys
    ├── esp8266-rtos-sdk                         // ESP8266 SDK
    ├── gen_misc.sh                              // script for compiling
    ├── include                                  // header file for customer configuration
    ├── Makefile                                 // makefile that can be used to configure the Alink parameters
    ├── platforms                                // platform-related files
    │   ├── alink                                // Alink-related APIs
    │   │   ├── adaptation                       // Alink's bottom-layer adapation
    │   │   ├── application                      // Alink's application-layer APIs
    │   │   │   ├── esp_alink_data_transport.c   // Alink's data transmission
    │   │   │   ├── esp_alink_main.c             // connects to AP, restores factory settings, addresses event callbacks
    │   │   │   ├── esp_info_store.c             // Flash read and write
    │   │   │   └── Makefile
    │   │   ├── include
    │   │   │   ├── alink_adaptation.h           // APIs defined during the bottom-layer adapation
    │   │   │   ├── alink_export.h               // Offical application-layer APIs provided by Alink
    │   │   │   ├── alink_export_rawdata.h       // Offical application-layer APIs provided by Alink
    │   │   │   ├── alink_json.h                 // Offical JSON APIs provided by Alink    
    │   │   │   ├── esp_alink.h                                  // Instruction and configuration of application-layer APIs
    │   │   │   ├── esp_alink_log.h              // defines the print level
    │   │   │   └── esp_info_store.h             // stores API details and examples
    │   │   ├── Makefile
    │   │   └── README.md                        
    │   └── Makefile
    ├── README.md                                // demo user guide
    └── user                                     // user-related files
        ├── alink_key_trigger.c                  // key-trigger function
        ├── ALINKTEST_LIVING_LIGHT_SMARTLED_LUA.lua  // the Lua script used in pass-thru transmission demo
        ├── Makefile
        ├── sample_json.c                        // Alink non-pass-thru transmission demo
        ├── sample_passthrough.c                 // Alink pass-thru transmission demo
        └── user_main.c                          // program entry

# 5. Compiling Environment
Both the xcc and gcc compilers can be used to compile the project. However, it is recommended that the gcc be used. For more information about the gcc compiler, please refer to [esp-open-sdk](https://github.com/pfalcon/esp-open-sdk).

# 6. Configuration and Compilation
1. **Configuration:** 
	
	Parameters including the log level and packet size can be configured by modifying the Makefile file.

	```bash
	/*!< 打开 json 调试，您可以查看任务的栈空间使用情况判断是事出现栈溢出 */
	CCFLAGS += -D SAMPLE_JSON_DEBUG
	        
	/*!< 打开后编译透传示例，默认编译非透传示例 */
	CCFLAGS += -D CONFIG_ALINK_PASSTHROUGH
	        
	/*!< 用户程序 log 等级 */
	CCFLAGS += -D CONFIG_LOG_ALINK_LEVEL=5
	        
	/*!< ALINK SDK 的 log 等级 */
	CCFLAGS += -D CONFIG_ALINK_SDK_LOG_LEVEL=5
	```

2. **Compilation:** 
	- Users developing on the Ubuntu platform should only run the `gen_misc.sh` script. 
	- Users developing on other platforms should click [here](https://github.com/pfalcon/esp-open-sdk) for more information.  

# 7. Firmware Downloading
## 7.1 Ubuntu
The *esptool.py* script should be used for downloading:

```bash
python esptool.py --chip esp8266 --port /dev/ttyUSB0 --baud 115200 write_flash -z --flash_mode dio --flash_freq 40m --flash_size detect 0x0000 ./bin/boot_v1.6.bin 0x1000 ./bin/upgrade/user1.2048.new.5.bin 0x1f8000 ./bin/blank_12k.bin 0x1fb000 ./bin/blank.bin 0x1fc000 ./bin/esp_init_data_default.bin 0x1fe000 bin/blank.bin
```

## 7.2 Windows
1. Install the [Serial Port Driver](http://www.usb-drivers.org/ft232r-usb-uart-driver.html)  
2. Install the [Download Tool](http://espressif.com/en/support/download/other-tools)
3. Download the relevant bin files (To achieve this, toggle *Switch 2* downwards to enter the download mode, then toggle *Switch 1* upwards on the ESP-Launcher to power up the board).

    ![烧录图例](docs/readme_image/download.png)

        boot.bin------------------->0x000000    // boot program
        user1.2048.new.5.bin------->0x01000     // main program
        blank_12k.bin-------------->0x1F8000    // initialize the user parameters
        blank.bin------------------>0x1FB000    // initialize RF_CAL parameters
        esp_init_data_default.bin-->0x1FC000    // initialize other RF parameters
        blalk.bin------------------>0x1FE000    // initialize system parameters

    > Note: The J82 jumper on ESP-Launcher must be shorted with a jumper cap. Otherwise, the downloading will fail.

4. Toggle *Switch 2* upwards on ESP-Launcher to enter the running mode. Then, toggle *Switch 1* upwards to power up the board. At this point, a message saying "ENTER SAMARTCONFIG MODE" is displayed, indicating that the development board has entered the configuration mode.

    ![烧写检查](docs/readme_image/running.png)

# 8. Operating and Debugging
1. Download [Alibaba Smart Living](https://open.aliplus.com/download).
2. Log in with your [taobao account](https://reg.taobao.com/member/reg/fill_mobile.htm).
3. Enable the "配网模组测试列表" (Module Certification and Test) option:
    - For the Android platform: click on the "环境切换" (Switch Environment), scroll down to the bottom of the screen and check the "开启配网模式测试列表" (Enable the Module Certification and Test) option.
    - For the iOS platform: click on "AKDebug" to see all the testing options and check "仅显示模组认证入口" (Show ONLY the Module Certification Portal).
4. "添加设备" (Add a Device): Click the "+" sign in the upper right corner, and select "添加设备" (Add a Device) -> "分类查找" (Search by Category) -> "模组认证" (Module Certification) -> "智能云-smartled".
    > If the pass-thru demo is used, please select "智能云-smartled_lua", instead of "智能云-smartled".
5. Key Definition:
	- IO13_RESET_KEY (SW1): press this key (>=3s) to reconfigure the network
	- SW2: press this key (>=3s) to restore the factory settings

# 9. Important Steps
## 9.1 Sign in Your Account
[Sign in](https://open.aliplus.com/docs/open/open/enter/index.html) the Alibaba platform with your Taobao account, and complete the account authorization.
## 9.2 Register Your Product
A product must be [registered with Alibaba](https://open.aliplus.com/docs/open/open/register/index.html) before it appears on the Alibaba platform.
## 9.3 Product development
You can simply focus on modifying the code in the user folder during your [project development](https://open.aliplus.com/docs/open/open/develop/index.html), without getting bogged down in the core implementation details.

1. **Initialization**

    Export the TRD file from the background of the Aliyun platform, and modify the macro definitions in the `user_config.h` file. At this point, the system will call the `alink_init()` function to set the product registration information, and register the event callback function.
    
    ```c
    #define DEV_NAME              "ALINKTEST"
    #define DEV_BRAND             "espressif"
    #define DEV_CATEGORY          "LIVING"
    #define DEV_TYPE              "LIGHT"
    #define DEV_MANUFACTURE       "ALINKTEST"
    #define DEV_MODEL             "ALINKTEST_LIVING_LIGHT_SMARTLED"
    /* key/secret */
    #define ALINK_KEY             "ljB6vqoLzmP8fGkE6pon"
    #define ALINK_SECRET          "YJJZjytOCXDhtQqip4EjWbhR95zTgI92RVjzjyZF"
    /* sandbox key/secret */
    #define ALINK_KEY_SANDBOX     "dpZZEpm9eBfqzK7yVeLq"
    #define ALINK_SECRET_SANDBOX  "THnfRRsU5vu6g6m9X6uFyAjUWflgZ0iyGjdEneKm"
    /* device hardware information */
    #define DEV_SN                "1234567890"
    #define DEV_VERSION           "1.0.0"
    /* the device MAC addr and chip ID should be acquired by call functions */
    #define DEV_MAC               ""
    #define DEV_CHIPID            ""  
    ```

2. **Network Configuration**
    - Event Callback Function：
        - All the actions during the network configuration will be passed to the event callback function. You can set up the corresponding handling processes by defining the event callback function, according to your actual requirements. For example, when the device enters the network configuration mode, you can program the LED to blink at a lower speed.

        ```c
        typedef enum {
            ALINK_EVENT_CLOUD_CONNECTED = 0,/*!< ESP8266 connected from Alink cloud */
            ALINK_EVENT_CLOUD_DISCONNECTED, /*!< ESP8266 disconnected from Alink cloud */
            ALINK_EVENT_GET_DEVICE_DATA,    /*!< Alink cloud requests data from the device */
            ALINK_EVENT_SET_DEVICE_DATA,    /*!< Alink cloud to send data to the device */
            ALINK_EVENT_POST_CLOUD_DATA,    /*!< The device sends data to Alink cloud  */
            ALINK_EVENT_WIFI_CONNECTED,     /*!< ESP8266 station received IP from the connected AP */
            ALINK_EVENT_WIFI_DISCONNECTED,  /*!< ESP8266 station disconnected from AP */
            ALINK_EVENT_CONFIG_NETWORK,     /*!< The equipment enters the network configuration mode */
            ALINK_EVENT_UPDATE_ROUTER,      /*!< Request to configure the router */
            ALINK_EVENT_FACTORY_RESET,      /*!< Request to restore factory settings */
        } alink_event_t;
        ```
        - The default stack size of the task that handles the event callback function is 1 KB. Therefore, please make sure that the size of your event callback function does not exceed that of the task. However, you can also modify the stack size of the task when it is necessary.
    - Active Reporting: 
	When the device successfully connects to the Aliyun server, it must actively report its status to the server, so the data on the server side and the device side are in sync. Otherwise, the network configuration will fail.

3. **Modify the Types of Triggers**

    You need to be based on your own product, in order determine how the factory settings and network reconfiguration will be triggered. For example, this demo triggers such functions with certain keys. For more informaton on how to change the types of triggers, see the details in `alink_key_trigger.c`.
  
    ```c
    static void key_13_short_press(void)
    {
        ALINK_LOGD("short press..");
    }

    static void key_13_long_press(void)
    {
        ALINK_LOGD("long press..");
        alink_event_send(ALINK_EVENT_UPDATE_ROUTER);
    }

    static void key_sw2_short_press(void)
    {
        ALINK_LOGD("short press..");
    }

    static void key_sw2_long_press(void)
    {
        ALINK_LOGD("long press..");
        alink_event_send(ALINK_EVENT_FACTORY_RESET);
    }
    ```

4. **Data Communication**
    - Data format: check the data format (pass-thru transmission or non pass-thru transmission) used for the device communication
        - Pass-thru transmission: The device receives binary-format data. The conversion between the JSON and binary data will be completed by the lua script on the Aliyun server.
        - Non pass-thru transmission: The device receives JSON-format data. The conversion of JSON-format data will be done on the device side. The lua script on the Aliyun server will not make any changes to the data.
    - Data length: The data length is adjusted to 1 KB for sending data and 2 KB for receiving data, because the memory of ESP8266 is limited.
    - Sending data: The active reporting is initiated by the device.
    - Receiving data: The data received by the device is either for setting the device status, or requesting the device status.

5. **Log Level**

    The logs in this project include the offical Alink logs and the ESP8266 Adaptation Layer Logs. These logs fall into seven categories or levels. Each log level has its own color and a corresponding identifier. When the log level is set, all the relevant information of a lower log level will be printed. Please note that a log with a "<>" prefix is an official Alink log.  
    - Configuration

        ```bash
        # 日志等级列表
        # default 0 if LOG_ALINK_LEVEL_NONE
        # default 1 if LOG_ALINK_LEVEL_FATAL
        # default 2 if LOG_ALINK_LEVEL_ERROR
        # default 3 if LOG_ALINK_LEVEL_WARN
        # default 4 if LOG_ALINK_LEVEL_INFO
        # default 5 if LOG_ALINK_LEVEL_DEBUG
        # default 6 if LOG_ALINK_LEVEL_VERBOSE
        # esp8266 适配层日志等级配置
        CCFLAGS += -D CONFIG_LOG_ALINK_LEVEL=5
        # alink 官方日志等级配置
        CCFLAGS += -D CONFIG_ALINK_SDK_LOG_LEVEL=5
        ```
    - Examples
    	The use of ALINK_LOGI is the same with printf.
    	
        ```c
        /* define labels for log files */
        static const char *TAG = "sample_json";

        ALINK_LOGI("compile time : %s %s", __DATE__, __TIME__);
        ```
> Notes：
> 
> 1. For module certification, the log level of the official Alink log must be set to the debugging mode.
> 2. When a high-frequency test is performed, the log level must be set to the info mode, so that the test will not be affected by excessive log information.

6. **Data Storage**

	To facilitate your work, we have packaged the flash read and write operations. You can use `key_value` for data storage, without being bothered by such things as flash erase, 4-byte alignment, etc.

    - Configuration (add the following definitions in the Makefile)

        ```bash
        # 存储flash的位置
        CCFLAGS += -D CONFIG_INFO_STORE_MANAGER_ADDR=0x1f8000
        # 标识信息字符串 key 的最大长度
        CCFLAGS += -D CONFIG_INFO_STORE_KEY_LEN=16
        # 存储信息的个数，每多一条信息记录需要多占用 60B
        CCFLAGS += -D CONFIG_INFO_STORE_KEY_NUM=5
        ```
    - Examples

        ```c
        /*!< initialize the list of stored information */
        char buf[16] = "12345678910";
        esp_info_init();

        /*!< data storage */
        esp_info_save("test_buf", buf, sizeof(buf));

        /*!< data loading */
        memset(buf, 0, sizeof(buf));
        esp_info_load("test_buf", buf, sizeof(buf));
        printf("buf: %s\n", buf);

        /*!< data erasing */
        esp_info_erase("test_buf");
        ```
    > Note: 
    > The total size of stored information cannot exceed 4 KB. To enhance data security during the flash write operation, e.g. in case of a sudden power loss, we have reserved a 12 KB memory for storing this 4 KB data, with the remaining 8 KB being used for data backup.

# 10. Precautions
- This project is still in progress, so please keep up to date with the latest developments.
- 5G network is not supported by ESP8266, so please make sure the 5G network is disabled on the router.
- The functioning of Alink can be affected by the network environment. Therefore, please ensure you are connected to a stable network during the test. Otherwise, the high-frequency pressure test and the stability test may fail.

# 11. Useful Links
- [ESP8266 Get Started](http://espressif.com/zh-hans/support/explore/get-started/esp8266/getting-started-guide)
- [Aliplus Platform](https://open.aliplus.com/docs/open/)
- [Downloading Tool](http://espressif.com/en/support/download/other-tools)
- [Serial Port Driver](http://www.usb-drivers.org/ft232r-usb-uart-driver.html)
