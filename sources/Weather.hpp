#ifndef WEATHER_HPP_
#define WEATHER_HPP_

// Copyright (c) 2014, Ruslan Baratov
// All rights reserved.

#include "Result.hpp"

class Weather {
 public:
  Result get_result(const char* city) BOOST_NOEXCEPT;

 private:
  Result process_city(const char* city);
  std::string get_body(const char* city);
};

#endif // WEATHER_HPP_
