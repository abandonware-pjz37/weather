// Copyright (c) 2014, Ruslan Baratov
// All rights reserved.

#include "Json.hpp"

#include <sstream> // std::ostringstream
#include <boost/lexical_cast.hpp>
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
  if (value_y.IsDouble()) {
    // boost::lexical_cast output result as: 40.420000000000002
    std::ostringstream result;
    result << value_y.GetDouble();
    return result.str();
  }
  else if (value_y.IsInt()) {
    return boost::lexical_cast<std::string>(value_y.GetInt());
  }
  else if (value_y.IsInt64()) {
    return boost::lexical_cast<std::string>(value_y.GetInt64());
  }
  else if (value_y.IsUint()) {
    return boost::lexical_cast<std::string>(value_y.GetUint());
  }
  else if (value_y.IsUint64()) {
    return boost::lexical_cast<std::string>(value_y.GetUint64());
  }
  else {
    assert(!value_y.IsNumber());
    id << " is not number";
    throw Exception(id.str());
  }
}
