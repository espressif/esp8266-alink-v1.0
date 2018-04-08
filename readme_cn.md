[[EN]](readme_en.md) 

# 1. Alink 概述
本文档为阿里云 Alink V1.0 的使用示例，可帮助您了解 Alink 的配网、升级及数据传输等功能。

## 1.1 Alink 是什么？
Alink 是阿里巴巴集团提供的一款一站式设备智能化解决方案，主要有三个部分组成：智能硬件模组（设备端）、阿里云（云服务器）及阿里智能 App（阿里智能）。

<img src="docs/readme_image/alink_description.png" width="700" />

## 1.2 Alink 有何优势？
Alink 是一个非常强大的设备智能化解决方案，可以极大地简化智能家居开发的难度和复杂性，主要有以下六个特点：低成本、短时间、大安全、大数据、标准化和定制化等。

<img src="docs/readme_image/alink_advantage.png" width="700" />

## 1.3 Alink 如何使用？
目前，乐鑫已经完成了 Alink SDK 在模组上的适配工作。因此，用户在进行产品开发时，只需在我们的模组上进行二次开发即可。

<img src="docs/readme_image/alink_development.png" width="700" />

# 2. 前置条件
## 2.1 知识储备
- 更多有关 Alink 的信息，请见阿里提供的官方[技术文档](https://open.aliplus.com/docs/open/)。
- 更多有关 ESP8266 开发的信息，请见 [ESP8266 入门指南](http://espressif.com/zh-hans/support/explore/get-started/esp8266/getting-started-guide)

## 2.2 硬件准备
- 开发板：1 x ESP_Launcher 开发板
- 路由器：ESP8266 只支持 2.4G 网络，所以请关闭 5G 网络，且可以连接外网（所有的数据交互必需通过阿里云服务器）
- 手机：安装[阿里智能厂测包](https://open.aliplus.com/download)

# 3. 开发板介绍

![ESP-Launcher](docs/readme_image/ESP_WROOM_02_cn.png)

* 标号 1 开关拨下为断电状态，拨上为上电状态；
* 标号 2 开关拨下为下载模式，拨上为运行模式；
* 标号 3 开关拨上（CHIP_EN PIN，默认拨上即可）；
* 标号 4 跳线帽插入上方的两个针脚；
* 标号 5 插入跳线帽；
* 标号 6 长按（>=3s）设备进入配网模式；
* 标号 9 出厂设置开关，长按（>=3s）设备端会解绑并恢复出厂设置。

> 注意：为了使能上述功能，请将 GPIO4 与 SW2 旁边的小圆孔连接起来。

# 4. 文件结构

    esp8266-alink-v1.0
    ├── bin                                      // 存放生成的 bin 文件
    ├── docs                                     // demo 使用文档的图片
    ├── driver                                   // 按键驱动
    ├── esp8266-rtos-sdk                         // ESP8266 SDK
    ├── gen_misc.sh                              // 编译脚本
    ├── include                                  // 用户配置头文件
    ├── Makefile                                 // 通过 Makefile 来配置 ALINK 选项
    ├── platforms                                // 平台相关文件
    │   ├── alink                                // alink 相关 API
    │   │   ├── adaptation                       // ALINK 的底层适配
    │   │   ├── application                      // ALINK 应用层 API 的封装
    │   │   │   ├── esp_alink_data_transport.c   // ALINK 数据传传输
    │   │   │   ├── esp_alink_main.c             // 连接 AP 、恢复出厂设置、事件回调函数
    │   │   │   ├── esp_info_store.c             // FLASH 的读写操作
    │   │   │   └── Makefile
    │   │   ├── include
    │   │   │   ├── alink_adaptation.h           // 应用层适配时定义的一些 API
    │   │   │   ├── alink_export.h               // ALINK 官方提供的原生应用层 API
    │   │   │   ├── alink_export_rawdata.h       // ALINK 官方提供的原生应用层 API
    │   │   │   ├── alink_json.h                 // ALINK 官方提供的原生 JSON API
    │   │   │   ├── esp_alink.h                  // 封装的应用层 API 使用说明及配置
    │   │   │   ├── esp_alink_log.h              // 定义了打印等级
    │   │   │   └── esp_info_store.h             // 信息存储 API 详解及 EXAMPLE
    │   │   ├── Makefile
    │   │   └── README.md                        
    │   └── Makefile
    ├── README.md                                // demo 使用文档
    └── user                                     // 用户相关文件
        ├── alink_key_trigger.c                  // 按键触发函数
        ├── ALINKTEST_LIVING_LIGHT_SMARTLED_LUA.lua  // 透传示例使用的 LUA 脚本
        ├── Makefile
        ├── sample_json.c                        // ALINK 非透传示例
        ├── sample_passthrough.c                 // ALINK 透传示例
        └── user_main.c                          // 用户程序入口

# 5. 编译环境的搭建
您可以使用 xcc 和 gcc 编译器来编译项目，建议使用 gcc。更多有关 gcc 编辑器的内容，请参考 [esp-open-sdk](https://github.com/pfalcon/esp-open-sdk)。

# 6. 配置与编译
1. **配置：**
	
	您可以通过修改 Makefile 文件，配置日志等级、数据包大小等参数。  

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

2. **编译：**
	* Ubuntu 用户仅需运行脚本 `gen_misc.sh` 即可；
	* 其他平台用户，请见[这里](https://github.com/pfalcon/esp-open-sdk)。  

# 7. 固件烧写
## 7.1 Ubuntu 用户
请使用 *esptool.py* 进行下载，如下：

```bash
python esptool.py --chip esp8266 --port /dev/ttyUSB0 --baud 115200 write_flash -z --flash_mode dio --flash_freq 40m --flash_size detect 0x0000 ./bin/boot_v1.6.bin 0x1000 ./bin/upgrade/user1.2048.new.5.bin 0x1f8000 ./bin/blank_12k.bin 0x1fb000 ./bin/blank.bin 0x1fc000 ./bin/esp_init_data_default.bin 0x1fe000 bin/blank.bin
```
## 7.2 Windows 用户
1. 安装[串口驱动](http://www.usb-drivers.org/ft232r-usb-uart-driver.html)。
2. 安装[烧写工具](https://www.espressif.com/zh-hans/support/download/other-tools)。
3. 烧录相关 bin 文件，ESP8266 开发板中标号 1 拨上，给开发板上电；标号 2 开关拨下，进入下载状态。

    ![烧录图例](docs/readme_image/download.png)

        boot.bin------------------->0x000000    // 启动程序
        user1.2048.new.5.bin------->0x01000     // 主程序
        blank_12k.bin-------------->0x1F8000    // 初始化用户参数区
        blank.bin------------------>0x1FB000    // 初始化 RF_CAL 参数区。
        esp_init_data_default.bin-->0x1FC000    // 初始化其他射频参数区
        blalk.bin------------------>0x1FE000    // 初始化系统参数区

    > 注：ESP-LAUNCHER 上的 J82 跳针需要用跳线帽短接，否则无法下载

4. 将 ESP8266 开发板标号 2 开关拨上，设置开发板为运行模式；将标号 1 开关拨上，给开发板上电，出现 “ENTER SAMARTCONFIG MODE” 信息，即表示 Alink 程序正常运行，进入配网模式。

    ![烧写检查](docs/readme_image/running.png)

# 8. 运行与调试
1. 下载阿里[智能厂测包](https://open.aliplus.com/download)；
2. 登陆[淘宝账号](https://reg.taobao.com/member/reg/fill_mobile.htm)；
3. 开启配网模组测试列表：
    - 安卓：点击“环境切换”，勾选“开启配网模组测试列表”
    - 苹果：点击“AKDebug”->测试选项，勾选“仅显示模组认证入口”
4. 添加设备：“添加设备”->“分类查找”中查找对应的类别->“模组认证”->“智能云-smartled”；
    > 若使用透传示例，则选择：“智能云-smartled_lua”。
5. 按键说明：
    - IO13_RESET_KEY (SW1)：长按（>=3s）进行重新配网
    - SW2：长按（>=3s）恢复出厂设置

# 9 开发流程
## 9.1 签约入驻
使用淘宝账号[签约入驻](https://open.aliplus.com/docs/open/open/enter/index.html)阿里平台，并完成账号授权。
## 9.2 产品注册
[产品注册](https://open.aliplus.com/docs/open/open/register/index.html)是设备上云的必要过程，任何一款产品在上云之前必须完成在平台的注册。
### 9.3 产品开发
除非另有特殊需求，否则在[产品开发](https://open.aliplus.com/docs/open/open/develop/index.html)时，您仅需修改 user 文件下的代码的即可，无需关心其他内部实现细节。

1. **初始化**

    从阿里服务器后台导出设备 TRD 表格，并在 `user_config.h` 文件中修改宏定义。此时，系统会调用 `alink_init()` 传入产品注册信息，并注册事件回调函数。
    
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
    /* device MAC addr and chip ID, should acquired by call functions */
    #define DEV_MAC               ""
    #define DEV_CHIPID            ""  
    ```

2. **配网**
    - 事件回调函数：
        - 设备配网过程中的所有动作，都会传入事件回调函数中。您可以根据实际需求，在事件回调函数中设置相应的处理。比如，在当设备进入配置配网模式灯慢闪，等待激活时灯快闪等。
        
       	 ```c
        typedef enum {
            ALINK_EVENT_CLOUD_CONNECTED = 0,/*!< ESP8266 connected from alink cloude */
            ALINK_EVENT_CLOUD_DISCONNECTED, /*!< ESP8266 disconnected from alink cloude */
            ALINK_EVENT_GET_DEVICE_DATA,    /*!< Alink cloud requests data from the device */
            ALINK_EVENT_SET_DEVICE_DATA,    /*!< Alink cloud to send data to the device */
            ALINK_EVENT_POST_CLOUD_DATA,    /*!< The device sends data to alink cloud  */
            ALINK_EVENT_WIFI_CONNECTED,     /*!< ESP8266 station got IP from connected AP */
            ALINK_EVENT_WIFI_DISCONNECTED,  /*!< ESP8266 station disconnected from AP */
            ALINK_EVENT_CONFIG_NETWORK,     /*!< The equipment enters the distribution mode */
            ALINK_EVENT_UPDATE_ROUTER,      /*!< Request to configure the router */
            ALINK_EVENT_FACTORY_RESET,      /*!< Request to restore factory settings */
        } alink_event_t;
        ``` 
        - 处理事件回调函数的任务栈默认大小为 1 KB。因此，请确保您的事件回调函数使用的空间不要超过任务栈的空间。不过，如有需要，任务栈的默认空间大小可以修改。
    - 主动上报：当设备成功连接至阿里云服务器时，需要主动上报设备的状态，以保证云端与设备端数据的同步，否则将无法配网成功。

3. **修改触发方式**

    您需要根据实际产品，确定以何种方式触发出厂设置、重新配网等操作。注意，本示例使用了按键触发的方式。如果您的设备没有按键，则可选择反复开关电源等方式实现触发，具体修改参见 `alink_key_trigger.c`。
    
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

4. **数据通信**
    - 数据格式：确认设备通信时的数据格式（透传/非透传）
        - 透传：设备端将收到二进制格式数据，JSON 格式与二进制数据之间的转换将由阿里云端服务器的 lua 脚本完成。
        - 非透传：设备端将收到的 JSON 格式的数据，JSON 格式与二进制数据之间的转换将由设备端完成，阿里云端服务器的 lua 脚本是空实现。
    - 数据长度：由于 ESP8266 内存有限，因此数据长度调整为上报 1 KB，下发 2 KB。
    - 数据上报：主动上报是由设备端主动发起。
    - 数据下发：设备端收到的下发数据有两种，分别为“设置设备状态”和“获取设备状态”。

5. **日志等级**

    本工程的日志分为：Alink 官方日志和 ESP8266 适配层日志。日志共分为七个级别，每一级别的日志在输出时均有颜色和相应的标识以区分。日志前带有"<>"的为 Alink 官方日志。设置日志后，比当前级别低的日志均输出。
    - 配置

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
    - 示例
	   Alink 日志的使用方法与 printf 一致。
    
      ```c
        /* 定义日志文件标识 */
        static const char *TAG = "sample_json";

        ALINK_LOGI("compile time : %s %s", __DATE__, __TIME__);
      ```
> 注意：
> 
> 1. 模组认证时，需将 alink 官方日志等级设置为 debug 模式;
> 2. 在进行高频测试时，需将日志等级都设置成 info 模式，以免过多的日志信息影响高频测试。

6. **信息存储**

    为了方便您的使用，我们已经封装了 flash 的读写操作，您可以通过 `key_value` 的方式进行数据存储，无需关心 flash 的擦写，4 字节对齐等问题。
    - 配置（在 Makefile 中添加如下定义进行配置）

        ```bash
        # 存储flash的位置
        CCFLAGS += -D CONFIG_INFO_STORE_MANAGER_ADDR=0x1f8000
        # 标识信息字符串 key 的最大长度
        CCFLAGS += -D CONFIG_INFO_STORE_KEY_LEN=16
        # 存储信息的个数，每多一条信息记录需要多占用 60B
        CCFLAGS += -D CONFIG_INFO_STORE_KEY_NUM=5
        ```
    - 示例

        ```c
        /*!< 初始化存储信息管理列表 */
        char buf[16] = "12345678910";
        esp_info_init();

        /*!< 数据保存 */
        esp_info_save("test_buf", buf, sizeof(buf));

        /*!< 数据加载 */
        memset(buf, 0, sizeof(buf));
        esp_info_load("test_buf", buf, sizeof(buf));
        printf("buf: %s\n", buf);

        /*!< 数据擦除 */
        esp_info_erase("test_buf");
        ```
    > 注意：
    > 总存储信息量不能超过 4 KB。为了防止在 flash 写操作时出现突然断电等问题对数据造成破坏，我们采用了 12 KB 空间来存储 4 KB 的数据。其中，4 KB 用来存储数据，另外 8 KB 用于对数据进行存储备份。

# 10. 注意事项
- 本项目工程将进行不定时优化，请随时保持更新。
- ESP8266 模组不支持 5G 网络，因此在使用时，请确保路由器已关闭 5G 网络功能。
- Alink 受网络环境的影响极大，因此在进行测试时，请确保网络环境良好，否则高频压测和稳定性测试可能会失败。

# 11. 相关链接
- [ESP8266 入门指南](http://espressif.com/zh-hans/support/explore/get-started/esp8266/getting-started-guide)
- [阿里智能开放平台](https://open.aliplus.com/docs/open/)
- [烧录工具](http://espressif.com/en/support/download/other-tools) 
- [串口驱动](http://www.usb-drivers.org/ft232r-usb-uart-driver.html)
