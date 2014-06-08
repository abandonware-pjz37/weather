# This file generated automatically by:
#   generate_sugar_files.py
# see wiki for more info:
#   https://github.com/ruslo/sugar/wiki/Collecting-sources

if(DEFINED WEATHER_UI_IMAGES_IPHONE_SUGAR_CMAKE_)
  return()
else()
  set(WEATHER_UI_IMAGES_IPHONE_SUGAR_CMAKE_ 1)
endif()

include(sugar_files)

sugar_files(
    WEATHER_IOS_RESOURCES
    Default-568h@2x.png
    Launch_Portrait@2x.png
)
