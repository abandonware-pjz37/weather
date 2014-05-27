// Copyright (c) 2014, Ruslan Baratov
// All rights reserved.

#include <iostream> // std::cout
#include <sober/sober.hpp>
#include <weather/ui/cli/Delegate.hpp>

int main(int argc, char** argv) {
  try {
    if (argc != 2) {
      std::cerr << "Usage: " << argv[0] << " <city>" << std::endl;
      return sober::Exit::FAIL;
    }
    const char* city = argv[1];

    namespace net = sober::network;

    // Disable boost.log
    sober::utils::Test::init_logs(false, false);

    net::Engine engine;
    net::http::Stream stream(engine);
    weather::ui::cli::Delegate delegate(stream);

    std::cout << "City: " << city << std::endl;
    delegate.async_get_city(city);
    engine.run();
    std::cout << "Done" << std::endl;

    return sober::Exit::OK;
  }
  catch (std::exception& exc) {
    std::cerr << "Exception: " << exc.what() << std::endl;
    return sober::Exit::FAIL;
  }
  catch (...) {
    std::cerr << "Unknown exception" << std::endl;
    return sober::Exit::FAIL;
  }
}
