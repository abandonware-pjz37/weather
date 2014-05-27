// Copyright (c) 2014, Ruslan Baratov
// All rights reserved.

#include <weather/ui/ios/WeatherTabDelegate.hpp>

#include <sober/network/http/response/attribute/StatusCode.hpp>
#include <weather/ui/ios/iphone/WeatherTab.h>

namespace weather {
namespace ui {
namespace ios {

WeatherTabDelegate::WeatherTabDelegate(
    sober::network::http::Stream& stream, void* weather_tab
): DelegateBase(stream), weather_tab_(weather_tab) {
}

bool WeatherTabDelegate::force_stop() {
  const bool stop = DelegateBase::force_stop();
  WeatherTab* x = (__bridge WeatherTab*)weather_tab_;
  [x on_watchdog_counter:counter() max:max_count() stop:stop];
  return stop;
}

void WeatherTabDelegate::on_success() {
  try {
    DelegateBase::on_success();
  }
  catch (const std::exception& exc) {
    buffer_.str("");
    buffer_ << exc.what();
    on_error();
    return;
  }

  const Attribute& attr = attribute();
  NSString* temperature =
      [NSString stringWithUTF8String:attr.temperature_human.c_str()];
  NSString* description =
      [NSString stringWithUTF8String:attr.description.c_str()];
  NSString* icon =
      [NSString stringWithUTF8String:attr.icon.c_str()];

  WeatherTab* x = (__bridge WeatherTab*)weather_tab_;
  [x
      on_success_longitude:attr.longitude
      latitude:attr.latitude
      temperature:temperature
      description:description
      icon:icon
  ];
}

bool WeatherTabDelegate::restart_on_error(const ErrorCode& error) {
  buffer_.str("");
  buffer_ << error.message();
  on_error();
  return false;
}

bool WeatherTabDelegate::restart_on_error(const StatusCode& status_code) {
  buffer_.str("");
  buffer_ << "Bad status code: " << status_code;
  on_error();
  return false;
}

void WeatherTabDelegate::on_error() {
  NSString* message = [NSString stringWithUTF8String:buffer_.str().c_str()];
  WeatherTab* x = (__bridge WeatherTab*)weather_tab_;
  [x on_error:message];
}

} // namespace ios
} // namespace ui
} // namespace weather
