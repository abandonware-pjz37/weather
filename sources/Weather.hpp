#ifndef WEATHER_HPP_
#define WEATHER_HPP_

// Copyright (c) 2014, Ruslan Baratov
// All rights reserved.

#include <memory>
#include "Network.fpp"
#include "Result.hpp"

class Weather {
 public:
  Weather();
  ~Weather();

  Result get_result(const char* city) BOOST_NOEXCEPT;

 private:
  Result process_city(const char* city);
  std::string get_body(const char* city);

  using Client = boost::network::http::client;

  const std::unique_ptr<Client> client_;
};

#endif // WEATHER_HPP_
