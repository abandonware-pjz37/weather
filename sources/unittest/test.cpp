// Copyright (c) 2014, Ruslan Baratov
// All rights reserved.

#include <gtest/gtest.h>
#include "Weather.hpp"

TEST(Weather, Madrid) {
  Weather weather;
  Result result = weather.get_result("Madrid");
  ASSERT_TRUE(result.is_ok());

  std::cout << "longitude: " << result.longitude() << std::endl;
  std::cout << "lattitude: " << result.lattitude() << std::endl;
  std::cout << "temperature: " << result.temperature() << std::endl;
  std::cout << "wind speed: " << result.wind_speed() << std::endl;
}
