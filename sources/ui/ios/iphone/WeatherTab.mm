// Copyright (c) 2014, Ruslan Baratov
// All rights reserved.

#import "WeatherTab.h"

#import <UIKit/UILabel.h>
#include "Weather.hpp"

@interface WeatherTab ()
@property (retain, nonatomic) IBOutlet UITextField *city_field;
@property (retain, nonatomic) IBOutlet UILabel *longitude;
@property (retain, nonatomic) IBOutlet UILabel *latitude;
@property (retain, nonatomic) IBOutlet UILabel *temperature;
@property (retain, nonatomic) IBOutlet UILabel *wind_speed;
@end

@implementation WeatherTab

// UIViewContoller override
- (void)viewDidLoad {
  [super viewDidLoad];

  // hold some space, otherwise rectangle width becomes 0
  NSString* placeholder = @"                ";
  [_latitude setText:placeholder];
  [_longitude setText:placeholder];
  [_temperature setText:placeholder];
  [_wind_speed setText:placeholder];

  // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

// UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  assert(_city_field == textField);
  const char* city = [textField.text UTF8String];
  if (!std::string(city).empty()) {
    Result result = Weather::get_result(city);
    if (result.is_ok()) {
      [_latitude setText:
          [NSString stringWithUTF8String:result.lattitude().c_str()]
      ];
      [_longitude setText:
          [NSString stringWithUTF8String:result.longitude().c_str()]
      ];
      [_temperature setText:
          [NSString stringWithUTF8String:result.temperature().c_str()]
      ];
      [_wind_speed setText:
          [NSString stringWithUTF8String:result.wind_speed().c_str()]
      ];
    }
    else {
      NSString* message = [
          NSString stringWithUTF8String:result.error_message().c_str()
      ];
      UIAlertView* alert = [
          [UIAlertView alloc]
          initWithTitle:@"Oops :("
          message:message
          delegate:nil
          cancelButtonTitle:@"back"
          otherButtonTitles:nil
      ];
      [alert show];
    }
  }
  [textField resignFirstResponder];
  return NO;
}

- (void)dealloc {
  [_longitude release];
  [_latitude release];
  [_temperature release];
  [_wind_speed release];
  [_city_field release];
  [super dealloc];
}

@end
