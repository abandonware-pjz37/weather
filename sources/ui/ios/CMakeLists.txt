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
