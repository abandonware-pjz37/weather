#ifndef WEATHER_UI_IOS_WEATHER_TAB_DELEGATE_HPP_
#define WEATHER_UI_IOS_WEATHER_TAB_DELEGATE_HPP_

// Copyright (c) 2014, Ruslan Baratov
// All rights reserved.

#include <weather/ui/ios/WeatherTabDelegate.fpp>

#include <weather/DelegateBase.hpp>

// This file is C++ only (included by EngineWrapper.cpp)
// => `void*` used instead of `@interface WeatherTab`

namespace weather {
namespace ui {
namespace ios {

class WeatherTabDelegate: public DelegateBase {
 public:
  WeatherTabDelegate(sober::network::http::Stream& stream, void* weather_tab);

  virtual bool force_stop() override;
  virtual void on_success() override;
  virtual bool restart_on_error(const ErrorCode& error) override;
  virtual bool restart_on_error(const StatusCode& status_code) override;

 private:
  void on_error();

  void* weather_tab_;
  std::ostringstream buffer_;
};

} // namespace ios
} // namespace ui
} // namespace weather

#endif // WEATHER_UI_IOS_WEATHER_TAB_DELEGATE_HPP_
