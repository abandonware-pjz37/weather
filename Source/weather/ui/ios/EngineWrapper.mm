// Copyright (c) 2014, Ruslan Baratov
// All rights reserved.

#include <weather/ui/ios/EngineWrapper.hpp>

namespace weather {
namespace ui {
namespace ios {

EngineWrapper::EngineWrapper(WeatherTab* weather_tab):
    stream_(engine_),
    delegate_(stream_, weather_tab) {
}

EngineWrapper::~EngineWrapper() {
}

void EngineWrapper::run(const char* city) {
  delegate_.async_get_city(city);
  engine_.run();
}

} // namespace ios
} // namespace ui
} // namespace weather
