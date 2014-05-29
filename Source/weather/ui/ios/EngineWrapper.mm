// Copyright (c) 2014, Ruslan Baratov
// All rights reserved.

#include <weather/ui/ios/EngineWrapper.hpp>

#include <sober/network/Engine.hpp>
#include <sober/network/http/Stream.hpp>
#include <sober/utils/Test.hpp>
#include <weather/ui/ios/WeatherTabDelegate.hpp>

namespace weather {
namespace ui {
namespace ios {

EngineWrapper::EngineWrapper(void* weather_tab):
    engine_(new sober::network::Engine()),
    stream_(new sober::network::http::Stream(*engine_)),
    delegate_(new weather::ui::ios::WeatherTabDelegate(*stream_, weather_tab)) {
  // log to std::cout
  sober::utils::Test::init_logs(true, false);
}

EngineWrapper::~EngineWrapper() {
}

void EngineWrapper::run(const char* city) {
  delegate_->async_get_city(city);
  engine_->run();
}

} // namespace ios
} // namespace ui
} // namespace weather
