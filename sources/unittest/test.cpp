// Copyright (c) 2014, Ruslan Baratov
// All rights reserved.

#include <gtest/gtest.h>
#include "Weather.hpp"

TEST(Weather, Madrid) {
  Result result = Weather::get_result("Madrid");

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
