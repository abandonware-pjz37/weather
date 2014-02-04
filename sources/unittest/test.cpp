// Copyright (c) 2014, Ruslan Baratov
// All rights reserved.

#include <gtest/gtest.h>
#include "Weather.hpp"

TEST(Weather, Madrid) {
  Weather weather;
  Result result = weather.get_result("Madrid");

  const Result::Opt<Result::Error>& error = result.error();
  if (error.is_initialized()) {
    std::cout << error->error_message << std::endl;
  }
  ASSERT_FALSE(error.is_initialized());

  const Result::Opt<Result::Mandatory>& mandatory = result.mandatory();
  ASSERT_TRUE(mandatory.is_initialized());

  std::cout << "longitude: " << mandatory->longitude << std::endl;
  std::cout << "lattitude: " << mandatory->lattitude << std::endl;
  std::cout << "temperature: " << mandatory->temperature << std::endl;
  std::cout << "wind speed: " << mandatory->wind_speed << std::endl;

  const Result::Opt<Result::Detailed>& detailed = result.detailed();
  if (detailed.is_initialized()) {
    std::cout << "description: " << detailed->description << std::endl;
    std::cout << "icon: " << detailed->icon << std::endl;
  }
}

TEST(Weather, Multi) {
  Weather weather;

  for (int i = 0; i < 1000; ++i) {
    const char* city = nullptr;
    switch (i % 5) {
      case 0:
        city = "Berlin";
        break;
      case 1:
        city = "Sydney";
        break;
      case 2:
        city = "Moscow";
        break;
      case 3:
        city = "New York";
        break;
      case 4:
        city = "London";
        break;
      default:
        assert(false);
    }
    Result result = weather.get_result(city);
    const Result::Opt<Result::Error>& error = result.error();
    if (error.is_initialized()) {
      std::cout << error->error_message << std::endl;
    }
    ASSERT_FALSE(result.error().is_initialized());
    std::cout << city << " - ok" << std::endl;
  }
}
