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
    return Result(Result::Error(exception.what()));
  }
  catch (std::exception& exception) {
    return Result(Result::Error(exception.what()));
  }
  catch (...) {
    return Result(Result::Error("Unknown exception"));
  }
}

Result Weather::process_city(const char* city) {
  std::string body = get_body(city);

  Json doc(body.c_str());

  std::string temperature = doc.get_number("main", "temp");
  assert(!temperature.empty());
  if (temperature[0] != '-') {
    temperature = '+' + temperature;
  }

  Result::Mandatory mandatory(
      doc.get_number("coord", "lon"),
      doc.get_number("coord", "lat"),
      temperature,
      doc.get_number("wind", "speed") + " mps"
  );

  try {
    Result::Detailed detailed(
        doc.get_string("weather", "icon"),
        doc.get_string("weather", "description")
    );
    return Result(mandatory, detailed);
  }
  catch(Exception&) {
    // ignore exception, detailed description is optional
  }

  return Result(mandatory);
}

std::string Weather::get_body(const char* city) {
  std::string request_url("http://api.openweathermap.org/data/2.5/weather?q=");
  request_url += city;
  request_url += "&units=metric";

  namespace network = boost::network;
  namespace http = network::http;

  http::client::request request(request_url);
  request << network::header("Connection", "close");
  http::client client;
  http::client::response response = client.get(request);
  return http::body(response);
}
