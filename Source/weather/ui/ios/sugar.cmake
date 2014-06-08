# This file generated automatically by:
#   generate_sugar_files.py
# see wiki for more info:
#   https://github.com/ruslo/sugar/wiki/Collecting-sources

if(DEFINED WEATHER_UI_IOS_SUGAR_CMAKE_)
  return()
else()
  set(WEATHER_UI_IOS_SUGAR_CMAKE_ 1)
endif()

include(sugar_files)
include(sugar_include)

sugar_include(icons)
sugar_include(launch_images)
sugar_include(views)

sugar_files(
    WEATHER_IOS_SOURCES
    Annotation.hpp
    Annotation.mm
    AppDelegate.hpp
    AppDelegate.mm
    EngineWrapper.hpp
    EngineWrapper.mm
    Progress.hpp
    Progress.mm
    SearchBar.hpp
    SearchBar.mm
    WeatherTabDelegate.hpp
    WeatherTabDelegate.mm
    main.mm
)
