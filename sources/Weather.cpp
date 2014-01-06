// Copyright (c) 2014, Ruslan Baratov
// All rights reserved.

#include "Weather.hpp"

#include <boost/network/protocol/http/client.hpp>
#include "Exception.hpp"
#include "Json.hpp"

Result Weather::get_result(const char* city) BOOST_NOEXCEPT {
  try {
    return process_city(city);
  }
  catch (Exception& exception) {
    return Result::make_failed(exception.what());
  }
  catch (std::exception& exception) {
    return Result::make_failed(exception.what());
  }
  catch (...) {
    return Result::make_failed("Unknown exception");
  }
}

Result Weather::process_city(const char* city) {
  std::string body = get_body(city);

  Json doc(body.c_str());

  return Result::make(
      doc.get("coord", "lon"),
      doc.get("coord", "lat"),
      doc.get("main", "temp"),
      doc.get("wind", "speed")
  );
}

std::string Weather::get_body(const char* city) {
  std::string request_url("http://api.openweathermap.org/data/2.5/weather?q=");
  request_url += city;

  namespace network = boost::network;
  namespace http = network::http;

  http::client::request request(request_url);
  request << network::header("Connection", "close");
  http::client client;
  http::client::response response = client.get(request);
  return http::body(response);
}
