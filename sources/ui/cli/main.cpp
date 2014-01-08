// Copyright (c) 2014, Ruslan Baratov
// All rights reserved.

#include <iostream> // std::cout

#include "Weather.hpp"

int main(int argc, char** argv) {
  if (argc != 2) {
    std::cerr << "Usage: " << argv[0] << " <city>" << std::endl;
    return EXIT_FAILURE;
  }

  Result result = Weather::get_result(argv[1]);

  if (!result.is_ok()) {
    std::cerr << result.error_message() << std::endl;
    return EXIT_FAILURE;
  }

  std::cout << "longitude: " << result.longitude() << std::endl;
  std::cout << "lattitude: " << result.lattitude() << std::endl;
  std::cout << "temperature: " << result.temperature() << std::endl;
  std::cout << "wind speed: " << result.wind_speed() << std::endl;

  return EXIT_SUCCESS;
}
