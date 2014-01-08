# Copyright (c) 2014, Ruslan Baratov
# All rights reserved.

if(NOT XCODE_VERSION)
  sugar_fatal_error("Xcode only")
endif()

# Collect source to variables:
#     * WEATHER_IOS_RESOURCES
#     * WEATHER_IOS_SOURCES
#     * WEATHER_PLIST
sugar_include("./")

include(sugar_mark_macosx_resources)

sugar_mark_macosx_resources(${WEATHER_IOS_RESOURCES})
sugar_add_executable(
    weather-ios
    ${WEATHER_IOS_SOURCES}
    ${WEATHER_IOS_RESOURCES}
    ${WEATHER_PLIST}
)
sugar_set_xcode_ios_sdkroot(TARGET weather-ios PLIST ${WEATHER_PLIST})
sugar_target_link_libraries(weather-ios weather)

sugar_groups_generate(
    ${WEATHER_IOS_SOURCES} ${WEATHER_IOS_RESOURCES} ${WEATHER_PLIST}
)

# Universal device (iPhone + iPad)
set_target_properties(
    weather-ios PROPERTIES XCODE_ATTRIBUTE_TARGETED_DEVICE_FAMILY "1,2"
)

set_target_properties(
    weather-ios
    PROPERTIES
    XCODE_ATTRIBUTE_PRODUCT_NAME
    "Weather"
    XCODE_ATTRIBUTE_BUNDLE_IDENTIFIER
    "com.github.ruslo.weather"
)

set_target_properties(
    weather-ios
    PROPERTIES
    XCODE_ATTRIBUTE_PRODUCT_NAME[variant=Debug]
    "Weather-D"
    XCODE_ATTRIBUTE_BUNDLE_IDENTIFIER[variant=Debug]
    "com.github.ruslo.weather.debug"
)
