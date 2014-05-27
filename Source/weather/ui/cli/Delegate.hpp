#ifndef WEATHER_UI_CLI_DELEGATE_HPP_
#define WEATHER_UI_CLI_DELEGATE_HPP_

// Copyright (c) 2014, Ruslan Baratov
// All rights reserved.

#include <weather/DelegateBase.hpp>

namespace weather {
namespace ui {
namespace cli {

class Delegate: public DelegateBase {
 public:
  Delegate(sober::network::http::Stream& stream);

  virtual bool force_stop() override;
  virtual void on_success() override;
  virtual bool restart_on_error(const ErrorCode& error) override;
  virtual bool restart_on_error(const StatusCode& status_code) override;
};

} // namespace cli
} // namespace ui
} // namespace weather

#endif // WEATHER_UI_CLI_DELEGATE_HPP_
