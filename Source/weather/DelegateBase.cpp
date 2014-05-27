// Copyright (c) 2014, Ruslan Baratov
// All rights reserved.

#include <weather/DelegateBase.hpp>

namespace weather {

DelegateBase::DelegateBase(sober::network::http::Stream& stream):
    Base(stream),
    max_count_(10) {
}

void DelegateBase::on_start() {
  counter_ = 0;
}

bool DelegateBase::force_stop() {
  ++counter_;
  return (counter_ >= max_count_);
}

boost::posix_time::time_duration DelegateBase::watchdog_period() {
  return boost::posix_time::milliseconds(1000);
}

int DelegateBase::max_count() const {
  return max_count_;
}

int DelegateBase::counter() const {
  return counter_;
}

} // namespace weather
