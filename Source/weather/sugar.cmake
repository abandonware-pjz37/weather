# This file generated automatically by:
#   generate_sugar_files.py
# see wiki for more info:
#   https://github.com/ruslo/sugar/wiki/Collecting-sources

if(DEFINED WEATHER_SUGAR_CMAKE_)
  return()
else()
  set(WEATHER_SUGAR_CMAKE_ 1)
endif()

include(sugar_files)
include(sugar_include)

sugar_include(ui)

sugar_files(
    WEATHER_SOURCES
    DelegateBase.cpp
    DelegateBase.hpp
)
