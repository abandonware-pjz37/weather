// Copyright (c) 2014, Ruslan Baratov
// All rights reserved.

#include "Json.hpp"

#include <sstream> // std::ostringstream
#include "Exception.hpp"

Json::Json(const char* doc) {
  doc_.Parse<0>(doc);

  if (!doc_.IsObject()) {
    throw Exception("Response is not JSON document");
  }

  if (doc_.HasMember("message")) {
    if (!doc_["message"].IsString()) {
      throw Exception("Message is not string");
    }
    throw Exception(doc_["message"].GetString());
  }
}

std::string Json::get(const char* x, const char* y) {
  std::ostringstream id;
  id << '[' << x << ',' << y << ']';

  if (!doc_.HasMember(x)) {
    id << " first not found";
    throw Exception(id.str());
  }
  const Value& value_x = doc_[x];
  if (!value_x.HasMember(y)) {
    id << " second not found";
    throw Exception(id.str());
  }
  const Value& value_y = value_x[y];
  if (!value_y.IsDouble()) {
    id << " is not double";
    throw Exception(id.str());
  }

  // boost::lexical_cast output result as: 40.420000000000002
  std::ostringstream result;
  result << value_y.GetDouble();
  return result.str();
}
