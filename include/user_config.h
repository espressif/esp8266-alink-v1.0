/*
 * ESPRESSIF MIT License
 *
 * Copyright (c) 2017 <ESPRESSIF SYSTEMS (SHANGHAI) PTE LTD>
 *
 * Permission is hereby granted for use on ESPRESSIF SYSTEMS ESP8266 only, in which case,
 * it is free of charge, to any person obtaining a copy of this software and associated
 * documentation files (the "Software"), to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the Software is furnished
 * to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all copies or
 * substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 * FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 * IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 */

#ifndef __USER_CONFIG_H__
#define __USER_CONFIG_H__

#include "esp_common.h"
#include <freertos/FreeRTOS.h>
#include <freertos/task.h>
#include <freertos/semphr.h>
#include "esp_alink.h"

#ifdef __cplusplus
extern "C" {
#endif

#define CONFIG_ALINK_MODULE_NAME    "ESP-WROOM-02"
#define USER_ALINK_GLOBAL_VER       "A[Alink1.0|56d2476]M[ESP8266]OS[1.3.0(68c9e7b]"

//=============== force sleep ==================
#define FIRST_START_FORCE_SLEEP  (1)
#define RECONNECT_FORCE_SLEEP    (1)
#define FPM_SLEEP_MAX_TIME       0xFFFFFFF
#define RECONNECT_SLEEP_TIME     (5*1000*1000)  // unit: us

#define ALINK_PASSTHROUGH_DATA_LEN  (8)

//============== alink device ==================
#ifndef ALINK_PASSTHROUGH
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
#else
#define DEV_NAME              "ALINKTEST"
#define DEV_BRAND             "espressif"
#define DEV_CATEGORY          "LIVING"
#define DEV_TYPE              "LIGHT"
#define DEV_MANUFACTURE       "ALINKTEST"
#define DEV_MODEL             "ALINKTEST_LIVING_LIGHT_SMARTLED_LUA"
/* key/secret */
#define ALINK_KEY             "bIjq3G1NcgjSfF9uSeK2"
#define ALINK_SECRET          "W6tXrtzgQHGZqksvJLMdCPArmkecBAdcr2F5tjuF"
/* sandbox key/secret */
#define ALINK_KEY_SANDBOX     "dpZZEpm9eBfqzK7yVeLq"
#define ALINK_SECRET_SANDBOX  "THnfRRsU5vu6g6m9X6uFyAjUWflgZ0iyGjdEneKm"
/* device hardware */
#define DEV_SN                "1234567890"
#define DEV_VERSION           "1.0.0"
/* device MAC addr and chip ID, should acquired by call functions */
#define DEV_MAC               ""             
#define DEV_CHIPID            ""   
#endif

#ifdef __cplusplus
}
#endif

#endif

