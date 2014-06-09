// Copyright (c) 2014, Ruslan Baratov
// All rights reserved.

#include <weather/ui/ios/WeatherTabDelegate.hpp>

#include <sober/network/http/response/attribute/StatusCode.hpp>

namespace weather {
namespace ui {
namespace ios {

WeatherTabDelegate::WeatherTabDelegate(
    sober::network::http::Stream& stream, Weather* weather_view
): DelegateBase(stream), weather_view_(weather_view) {
}

bool WeatherTabDelegate::force_stop() {
  const bool stop = DelegateBase::force_stop();
  [weather_view_ on_watchdog_counter:counter() max:max_count() stop:stop];
  return stop;
}

void WeatherTabDelegate::on_success() {
  try {
    DelegateBase::on_success();
  }
  catch (const std::exception& exc) {
    buffer_.str("");
    if (exc.what() == std::string("Error: Not found city")) {
      // Make message more readable
      buffer_ << "City not found";
    }
    else {
      buffer_ << exc.what();
    }
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

  [weather_view_
      on_success_longitude:attr.longitude
      latitude:attr.latitude
      temperature:temperature
      description:description
      icon:icon
  ];
}

bool WeatherTabDelegate::restart_on_error(const ErrorCode& error) {
  bool do_restart = DelegateBase::restart_on_error(error);
  if (do_restart) {
    return true;
  }
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
  [weather_view_ on_error:message];
}

} // namespace ios
} // namespace ui
} // namespace weather
