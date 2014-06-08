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

add_executable(
    weather-ios
    ${WEATHER_SOURCES}
    ${WEATHER_IOS_SOURCES}
    ${WEATHER_IOS_RESOURCES}
    ${WEATHER_PLIST}
)

target_link_libraries(
    weather-ios
    sober
    "-framework CoreGraphics"
    "-framework Foundation"
    "-framework UIKit"
    "-framework MapKit"
)

sugar_groups_generate(
    ${WEATHER_SOURCES}
    ${WEATHER_IOS_SOURCES}
    ${WEATHER_IOS_RESOURCES}
    ${WEATHER_PLIST}
)

set_target_properties(
    weather-ios
    PROPERTIES
    MACOSX_BUNDLE YES
    MACOSX_BUNDLE_INFO_PLIST "${WEATHER_PLIST}"
    XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY "iPhone Developer"
    XCODE_ATTRIBUTE_TARGETED_DEVICE_FAMILY "1,2" # iPhone/iPad
    XCODE_ATTRIBUTE_CLANG_ENABLE_OBJC_ARC YES
    XCODE_ATTRIBUTE_INSTALL_PATH "${CMAKE_BINARY_DIR}/ProductRelease"
    XCODE_ATTRIBUTE_COMBINE_HIDPI_IMAGES "NO" # If this setting is "YES"
        # application can't pass archive validation
    RESOURCE "${WEATHER_IOS_RESOURCES}"
)

set_target_properties(
    weather-ios
    PROPERTIES
    XCODE_ATTRIBUTE_PRODUCT_NAME
    "Weather."
    XCODE_ATTRIBUTE_BUNDLE_IDENTIFIER
    "com.github.ruslo.weather"
)

set_target_properties(
    weather-ios
    PROPERTIES
    XCODE_ATTRIBUTE_PRODUCT_NAME[variant=Debug]
    "Weather-Dbg"
    XCODE_ATTRIBUTE_BUNDLE_IDENTIFIER[variant=Debug]
    "com.github.ruslo.weather.debug"
)
