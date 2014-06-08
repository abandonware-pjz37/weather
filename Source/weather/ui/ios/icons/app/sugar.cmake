# This file generated automatically by:
#   generate_sugar_files.py
# see wiki for more info:
#   https://github.com/ruslo/sugar/wiki/Collecting-sources

if(DEFINED WEATHER_UI_IOS_ICONS_APP_SUGAR_CMAKE_)
  return()
else()
  set(WEATHER_UI_IOS_ICONS_APP_SUGAR_CMAKE_ 1)
endif()

include(sugar_files)

sugar_files(
    WEATHER_IOS_RESOURCES
    Icon_iPad_Non-Retina_76x76.png
    Icon_iPad_Retina_152x152.png
    Icon_iPhone_Retina_120x120.png
)
