// Copyright (c) 2014, Ruslan Baratov
// All rights reserved.

#include <iostream> // std::cout

#include "Weather.hpp"

int main(int argc, char** argv) {
  if (argc != 2) {
    std::cerr << "Usage: " << argv[0] << " <city>" << std::endl;
    return EXIT_FAILURE;
  }

  Weather weather;
  Result result = weather.get_result(argv[1]);

  const Result::Opt<Result::Error>& error = result.error();

  if (error.is_initialized()) {
    std::cerr << error->error_message << std::endl;
    return EXIT_FAILURE;
  }

  const Result::Opt<Result::Mandatory>& mandatory = result.mandatory();
  assert(mandatory.is_initialized());

  std::cout << "longitude: " << mandatory->longitude << std::endl;
  std::cout << "lattitude: " << mandatory->lattitude << std::endl;
  std::cout << "temperature: " << mandatory->temperature << std::endl;
  std::cout << "wind speed: " << mandatory->wind_speed << std::endl;

  const Result::Opt<Result::Detailed>& detailed = result.detailed();
  if (detailed.is_initialized()) {
    std::cout << "description: " << detailed->description << std::endl;
    std::cout << "icon: " << detailed->icon << std::endl;
  }

  return EXIT_SUCCESS;
}
