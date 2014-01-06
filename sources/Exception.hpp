#ifndef EXCEPTION_HPP_
#define EXCEPTION_HPP_

// Copyright (c) 2014, Ruslan Baratov
// All rights reserved.

class Exception: public std::runtime_error {
 public:
  using Base = std::runtime_error;

  Exception(std::string what): Base(what) {
  }
};

#endif // EXCEPTION_HPP_
