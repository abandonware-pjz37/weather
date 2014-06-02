# This file generated automatically by:
#   generate_sugar_files.py
# see wiki for more info:
#   https://github.com/ruslo/sugar/wiki/Collecting-sources

if(DEFINED WEATHER_UI_ICONS_APP_SUGAR_CMAKE_)
  return()
else()
  set(WEATHER_UI_ICONS_APP_SUGAR_CMAKE_ 1)
endif()

include(sugar_files)

sugar_files(
    WEATHER_IOS_RESOURCES
    Icon.png
    Icon@2x.png
    Icon~iphone.png
)
