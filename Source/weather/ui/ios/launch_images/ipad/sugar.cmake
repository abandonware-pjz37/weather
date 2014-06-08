# This file generated automatically by:
#   generate_sugar_files.py
# see wiki for more info:
#   https://github.com/ruslo/sugar/wiki/Collecting-sources

if(DEFINED WEATHER_UI_IOS_LAUNCH_IMAGES_IPAD_SUGAR_CMAKE_)
  return()
else()
  set(WEATHER_UI_IOS_LAUNCH_IMAGES_IPAD_SUGAR_CMAKE_ 1)
endif()

include(sugar_files)

sugar_files(
    WEATHER_IOS_RESOURCES
    Launch_Landscape@2x~ipad.png
    Launch_Landscape~ipad.png
    Launch_Portrait@2x~ipad.png
    Launch_Portrait~ipad.png
)
