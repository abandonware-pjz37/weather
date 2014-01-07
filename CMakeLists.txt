# Copyright (c) 2014, Ruslan Baratov
# All rights reserved.

cmake_minimum_required(VERSION 2.8.12)
project(Weather)

# Manage package manager (:
include(HunterGate.cmake)

# Download dependent projects
hunter_add_package(CppNetlib) # Boost/OpenSSL/Sugar will be added automatically
hunter_add_package(GTest)
hunter_add_package(RapidJSON)

include("${SUGAR_ROOT}/cmake/Sugar")

# Wrappers for building iOS universal libraries + some tools
#     * https://github.com/ruslo/sugar/wiki/Building-universal-ios-library
include(sugar_add_executable)
include(sugar_add_gtest)
include(sugar_add_library)
include(sugar_groups_generate)
include(sugar_include)
include(sugar_target_link_libraries)

set(Boost_USE_STATIC_LIBS ON)

# Find downloads
find_package(Boost REQUIRED thread system)
find_package(CppNetlib REQUIRED)
find_package(GTest REQUIRED)
find_package(OpenSSL REQUIRED)
find_package(RapidJSON REQUIRED)

include_directories(${Boost_INCLUDE_DIR})
include_directories(${CPPNETLIB_INCLUDE_DIR})
include_directories(${OPENSSL_INCLUDE_DIR})
include_directories(${RAPIDJSON_INCLUDE_DIR})

include_directories("./sources")

add_definitions(-DNETWORK_ENABLE_HTTPS=1) # OpenSSL is REQUIRED
add_definitions(-DBOOST_ALL_NO_LIB=1) # Disable windows auto-link

# Collect source to variables:
#     * WEATHER_SOURCES
#     * WEATHER_CLI_SOURCES
#     * WEATHER_TEST_SOURCES
sugar_include("./sources")

# Add `SUGAR_SOURCES` to show used `sugar_*.cmake` modules
sugar_add_library(weather ${WEATHER_SOURCES} ${SUGAR_SOURCES})
sugar_target_link_libraries(
    weather
    ${CPPNETLIB_LIBRARIES}
    ${OPENSSL_LIBRARIES}
    ${Boost_LIBRARIES}
)

string(COMPARE EQUAL "${CMAKE_OSX_SYSROOT}" "iphoneos" build_ios_app)

if(build_ios_app)
  add_subdirectory("./sources/ui/ios")
endif()

sugar_add_executable(weather-cli ${WEATHER_CLI_SOURCES})
sugar_add_executable(weather-test ${WEATHER_TEST_SOURCES})

sugar_target_link_libraries(weather-cli weather)
sugar_target_link_libraries(weather-test weather ${GTEST_BOTH_LIBRARIES})

# Generate source groups to fit directories layout (Xcode, Visual Studio)
sugar_groups_generate(
    ${WEATHER_SOURCES}
    ${WEATHER_CLI_SOURCES}
    ${WEATHER_TEST_SOURCES}
    ${SUGAR_SOURCES}
)

enable_testing()
sugar_add_gtest(WeatherTest weather-test)
