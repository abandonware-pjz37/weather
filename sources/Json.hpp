#ifndef JSON_HPP_
#define JSON_HPP_

// Copyright (c) 2014, Ruslan Baratov
// All rights reserved.

#include <rapidjson/document.h>
#include <string>

class Json {
 public:
  Json(const char* doc);
  std::string get(const char* x, const char* y);

 private:
  using Value = rapidjson::Value;
  rapidjson::Document doc_;
};

#endif // JSON_HPP_
