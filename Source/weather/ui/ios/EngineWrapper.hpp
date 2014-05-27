#ifndef WEATHER_UI_IOS_ENGINE_WRAPPER_HPP_
#define WEATHER_UI_IOS_ENGINE_WRAPPER_HPP_

// Copyright (c) 2014, Ruslan Baratov
// All rights reserved.

#include <memory> // std::unique_ptr
#include <sober/network/Engine.fpp>
#include <sober/network/http/Stream.fpp>
#include <weather/ui/ios/WeatherTabDelegate.fpp>

// This file included (and managed) by WeatherTab.mm (Objective-C++), so
// do not include network components here because of conflict in spirit::qi
// (nil is reserved): http::Stream -> http::Response -> spirit::qi -> nil
// All network components are hidden using PIMPL idiom.

// For same reason implementation of this class
// must be C++ only (not Objective-C++), so `void*` used
// instead of `@interface WeatherTab`

namespace weather {
namespace ui {
namespace ios {

class EngineWrapper {
 public:
  EngineWrapper(void* weather_tab);
  ~EngineWrapper();

  void run(const char* city);

 private:
  std::unique_ptr<sober::network::Engine> engine_;
  std::unique_ptr<sober::network::http::Stream> stream_;
  std::unique_ptr<weather::ui::ios::WeatherTabDelegate> delegate_;
};

} // namespace ios
} // namespace ui
} // namespace weather

#endif // WEATHER_UI_IOS_ENGINE_WRAPPER_HPP_
