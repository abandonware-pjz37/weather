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
    AboutTab.h
    AboutTab.mm
    WeatherTab.h
    WeatherTab.mm
)

sugar_files(
    WEATHER_IOS_RESOURCES
    MainStoryboard_iPhone.storyboard
    MainStoryboard_iPad.storyboard
    about.png
    weather.png
)

sugar_files(
    WEATHER_PLIST
    plist.in
)
