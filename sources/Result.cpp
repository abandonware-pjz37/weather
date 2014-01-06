// Copyright (c) 2014, Ruslan Baratov
// All rights reserved.

#include "Result.hpp"

#include <cassert> // assert
#include <string>

Result Result::make(
    std::string longitude,
    std::string lattitude,
    std::string temperature,
    std::string wind_speed
) {
  return Result(longitude, lattitude, temperature, wind_speed);
}

Result Result::make_failed(std::string error_message) {
  return Result(error_message);
}

bool Result::is_ok() const BOOST_NOEXCEPT {
  return is_ok_;
}

std::string Result::error_message() const BOOST_NOEXCEPT {
  assert(!is_ok());
  return error_message_;
}

std::string Result::longitude() const BOOST_NOEXCEPT {
  assert(is_ok());
  return longitude_;
}

std::string Result::lattitude() const BOOST_NOEXCEPT {
  assert(is_ok());
  return lattitude_;
}

std::string Result::temperature() const BOOST_NOEXCEPT {
  assert(is_ok());
  return temperature_;
}

std::string Result::wind_speed() const BOOST_NOEXCEPT {
  assert(is_ok());
  return wind_speed_;
}

Result::Result(
    std::string longitude,
    std::string lattitude,
    std::string temperature,
    std::string wind_speed
):
    is_ok_(true),
    longitude_(longitude),
    lattitude_(lattitude),
    temperature_(temperature),
    wind_speed_(wind_speed) {
}

Result::Result(std::string error_message):
    is_ok_(false),
    error_message_(error_message) {
}
