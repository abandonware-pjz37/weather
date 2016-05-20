# Copyright (c) 2014-2015, Ruslan Baratov
# All rights reserved.

cmake_minimum_required(VERSION 3.0)
include("cmake/HunterGate.cmake")
HunterGate(
    URL "https://github.com/ruslo/hunter/archive/v0.11.4.tar.gz"
    SHA1 "caded3d303e471f789db67e658b5a4ffb221d670"
    LOCAL
)
project(Weather)

### Download dependencies ###
hunter_add_package(Sober)
hunter_add_package(Sugar) # SUGAR_ROOT

### Find dependencies ###
find_package(Sober CONFIG REQUIRED) # sober

### - ###
include("${SUGAR_ROOT}/cmake/Sugar") # sugar_include
include(sugar_groups_generate)
include(sugar_include)

### Target sources. Init variables: ###
#   WEATHER_SOURCES
#   WEATHER_CLI_SOURCES
sugar_include("./Source/weather")

include_directories("./Source")

string(COMPARE EQUAL "${CMAKE_CXX_COMPILER_ID}" "Clang" is_clang)
string(COMPARE EQUAL "${CMAKE_CXX_COMPILER_ID}" "AppleClang" is_apple_clang)
if(is_clang OR is_apple_clang)
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-deprecated-register")
endif()

### Targets ###
add_executable(weather-cli ${WEATHER_SOURCES} ${WEATHER_CLI_SOURCES})
target_link_libraries(weather-cli sober)
if("${CMAKE_SYSTEM_NAME}" STREQUAL "Linux")
  find_package(Threads REQUIRED)
  target_link_libraries(weather-cli ${CMAKE_THREAD_LIBS_INIT})
endif()
sugar_groups_generate(${WEATHER_SOURCES} ${WEATHER_CLI_SOURCES})

### iOS Target ###
string(COMPARE EQUAL "${CMAKE_OSX_SYSROOT}" "iphoneos" is_ios)
if(is_ios)
  add_subdirectory("./Source/weather/ui/ios")
endif()
