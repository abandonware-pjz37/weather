// Copyright (c) 2014, Ruslan Baratov
// All rights reserved.

#include <weather/ui/cli/Delegate.hpp>

#include <iostream> // std::cout
#include <sober/network/http/response/attribute/StatusCode.hpp>

namespace weather {
namespace ui {
namespace cli {

Delegate::Delegate(sober::network::http::Stream& stream):
    DelegateBase(stream) {
}

bool Delegate::force_stop() {
  const bool stop = DelegateBase::force_stop();
  std::cout << "Count " << counter() << "/" << max_count() << std::endl;
  if (stop) {
    std::cerr << "Timeout reached" << std::endl;
  }
  return stop;
}

void Delegate::on_success() {
  try {
    DelegateBase::on_success();
  }
  catch (const std::exception& exc) {
    std::cerr << "Parse failed: " << exc.what() << std::endl;
    return;
  }
  const Attribute& attr = attribute();
  std::cout << "Success..." << std::endl;
  std::cout << "  longitude: " << attr.longitude << std::endl;
  std::cout << "  latitude: " << attr.latitude << std::endl;
  std::cout << "  temperature: " << attr.temperature << std::endl;
  std::cout << "  temperature(human): " << attr.temperature_human
      << std::endl;
  std::cout << "  description: " << attr.description << std::endl;
  std::cout << "  icon: " << attr.icon << std::endl;
}

bool Delegate::restart_on_error(const ErrorCode& error) {
  std::cerr << "Error: " << error.message() << std::endl;
  return false;
}

bool Delegate::restart_on_error(const StatusCode& status_code) {
  std::cerr << "Error(bad status code): " << status_code << std::endl;
  return false;
}

} // namespace cli
} // namespace ui
} // namespace weather
