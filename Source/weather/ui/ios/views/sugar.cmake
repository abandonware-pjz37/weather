# Copyright (c) 2014, Ruslan Baratov
# All rights reserved.

if(DEFINED WEATHER_UI_IOS_VIEWS_SUGAR_CMAKE_)
  return()
else()
  set(WEATHER_UI_IOS_VIEWS_SUGAR_CMAKE_ 1)
endif()

include(sugar_files)

sugar_files(
    WEATHER_IOS_SOURCES
    About.hpp
    About.mm
    Weather.hpp
    Weather.mm
    iPad.hpp
    iPad.mm
    iPhone.hpp
    iPhone.mm
)

sugar_files(
    WEATHER_IOS_RESOURCES
    iPhone.storyboard
    iPad.storyboard
    About.storyboard
    Weather.storyboard
    about.png
    weather.png
)

sugar_files(
    WEATHER_PLIST
    plist.in
)
