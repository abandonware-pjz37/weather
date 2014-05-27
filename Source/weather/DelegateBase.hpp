#ifndef WEATHER_DELEGATE_BASE_HPP_
#define WEATHER_DELEGATE_BASE_HPP_

// Copyright (c) 2014, Ruslan Baratov
// All rights reserved.

#include <sober/network/api/OpenWeatherMap.hpp>

namespace weather {

class DelegateBase: public sober::network::api::OpenWeatherMap {
 public:
  using Base = sober::network::api::OpenWeatherMap;
  using StatusCode = sober::network::http::response::attribute::StatusCode;
  using ErrorCode = boost::system::error_code;

  DelegateBase(sober::network::http::Stream& stream);

  virtual void on_start() override;
  virtual bool force_stop() override;
  virtual boost::posix_time::time_duration watchdog_period() override;

  int max_count() const;
  int counter() const;

 private:
  const int max_count_;
  int counter_;
};

} // namespace weather

#endif // WEATHER_DELEGATE_BASE_HPP_
