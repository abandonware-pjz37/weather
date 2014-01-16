# Copyright (c) 2014, Ruslan Baratov
# All rights reserved.

if(DEFINED WEATHER_SOURCES_UI_IOS_RESOURCES_SUGAR_CMAKE_)
  return()
else()
  set(WEATHER_SOURCES_UI_IOS_RESOURCES_SUGAR_CMAKE_ 1)
endif()

include(sugar_files)

sugar_files(
    WEATHER_IOS_RESOURCES
    Default-568h@2x.png
    Default.png
    Default@2x.png
    MainStoryboard_iPad.storyboard
    MainStoryboard_iPhone.storyboard
    about.png
    weather.png
)

sugar_files(
    WEATHER_PLIST
    plist.in
)
