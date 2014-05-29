// Copyright (c) 2014, Ruslan Baratov
// All rights reserved.

#import <weather/ui/ios/Annotation.hpp>

@implementation Annotation

- (id)init_with_longitude:(double)longitude
    latitude:(double)latitude
    temperature:(NSString*)temperature
    description:(NSString*)description
    icon:(NSString*)icon {
  self = [super init];
  if (self != nullptr) {
    _coordinate.longitude = longitude;
    _coordinate.latitude = latitude;
    _title = temperature;
    _subtitle = description;
    _icon = icon;
  }
  return self;
}

@end