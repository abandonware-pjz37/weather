#ifndef RESULT_HPP_
#define RESULT_HPP_

// Copyright (c) 2014, Ruslan Baratov
// All rights reserved.

#include <string>
#include <boost/config.hpp> // BOOST_NOEXCEPT

class Result {
 public:
  static Result make(
      std::string longitude,
      std::string lattitude,
      std::string temperature,
      std::string wind_speed
  );

  static Result make_failed(std::string error_message);

  bool is_ok() const BOOST_NOEXCEPT;

  std::string error_message() const BOOST_NOEXCEPT;

  std::string longitude() const BOOST_NOEXCEPT;
  std::string lattitude() const BOOST_NOEXCEPT;
  std::string temperature() const BOOST_NOEXCEPT;
  std::string wind_speed() const BOOST_NOEXCEPT;

 private:
  Result(
      std::string longitude,
      std::string lattitude,
      std::string temperature,
      std::string wind_speed
  );

  Result(std::string error_message);

  const bool is_ok_;

  const std::string error_message_;

  const std::string longitude_;
  const std::string lattitude_;
  const std::string temperature_;
  const std::string wind_speed_;
};

#endif // RESULT_HPP_
