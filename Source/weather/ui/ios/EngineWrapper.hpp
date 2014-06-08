#ifndef WEATHER_UI_IOS_ENGINE_WRAPPER_HPP_
#define WEATHER_UI_IOS_ENGINE_WRAPPER_HPP_

// Copyright (c) 2014, Ruslan Baratov
// All rights reserved.

#import <weather/ui/ios/views/Weather.h>
#include <sober/network/Engine.hpp>
#include <sober/network/http/Stream.hpp>
#include <weather/ui/ios/WeatherTabDelegate.hpp>

namespace weather {
namespace ui {
namespace ios {

class EngineWrapper {
 public:
  EngineWrapper(Weather* weather_view);
  ~EngineWrapper();

  void run(const char* city);

 private:
  sober::network::Engine engine_;
  sober::network::http::Stream stream_;
  weather::ui::ios::WeatherTabDelegate delegate_;
};

} // namespace ios
} // namespace ui
} // namespace weather

#endif // WEATHER_UI_IOS_ENGINE_WRAPPER_HPP_
