#ifndef RESULT_HPP_
#define RESULT_HPP_

// Copyright (c) 2014, Ruslan Baratov
// All rights reserved.

#include <boost/optional.hpp>

class Result {
 public:
  using String = std::string;

  template <class T>
  using Opt = boost::optional<T>;

  struct Mandatory {
    Mandatory(String longit, String latt, String temp, String w_speed):
      longitude(longit),
      lattitude(latt),
      temperature(temp),
      wind_speed(w_speed) {
    }

    const String longitude;
    const String lattitude;
    const String temperature;
    const String wind_speed;
  };

  struct Detailed {
    Detailed(String ic, String desr): icon(ic), description(desr) {
    }

    const String icon;
    const String description;
  };

  struct Error {
    Error(String err_message): error_message(err_message) {
    }

    const String error_message;
  };

  explicit Result(Error error): error_(error) {
  }

  explicit Result(Mandatory mandatory): mandatory_(mandatory) {
  }

  Result(Mandatory mandatory, Detailed detailed):
      mandatory_(mandatory),
      detailed_(detailed) {
  }

  const Opt<Mandatory>& mandatory() BOOST_NOEXCEPT { return mandatory_; }
  const Opt<Detailed>& detailed() BOOST_NOEXCEPT { return detailed_; }
  const Opt<Error>& error() BOOST_NOEXCEPT { return error_; }

private:
  Opt<Mandatory> mandatory_;
  Opt<Detailed> detailed_;
  Opt<Error> error_;
};

#endif // RESULT_HPP_
