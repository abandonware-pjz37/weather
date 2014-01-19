// Copyright (c) 2014, Ruslan Baratov
// All rights reserved.

#import "WeatherTab.h"

#import <UIKit/UILabel.h>
#import <UIKit/UIImageView.h>
#import <UIKit/UIImage.h>
#include "Weather.hpp"

@interface WeatherTab () {
  Weather* weather;
}
@property (retain, nonatomic) IBOutlet UITextField *city_field;
@property (retain, nonatomic) IBOutlet UILabel *longitude;
@property (retain, nonatomic) IBOutlet UILabel *latitude;
@property (retain, nonatomic) IBOutlet UILabel *temperature;
@property (retain, nonatomic) IBOutlet UILabel *wind_speed;
@property (retain, nonatomic) IBOutlet UILabel *description;
@property (retain, nonatomic) IBOutlet UIImageView *icon;
@end

@implementation WeatherTab

// UIViewContoller override
- (void)viewDidLoad {
  [super viewDidLoad];

  // hold some space, otherwise rectangle width becomes 0
  NSString* placeholder = @"                    ";
  [_latitude setText:placeholder];
  [_longitude setText:placeholder];
  [_temperature setText:placeholder];
  [_wind_speed setText:placeholder];
  [_description setText:placeholder];
  _icon.image = [UIImage imageNamed:@"empty"];

  assert(weather == nullptr);
  weather = new Weather;
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
    Result result = weather->get_result(city);
    const Result::Opt<Result::Error>& error = result.error();
    if (error.is_initialized()) {
      NSString* message = [
          NSString stringWithUTF8String:error->error_message.c_str()
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
    else {
      const Result::Opt<Result::Mandatory>& mandatory = result.mandatory();
      assert(mandatory.is_initialized());
      [_latitude setText:
          [NSString stringWithUTF8String:mandatory->lattitude.c_str()]
      ];
      [_longitude setText:
          [NSString stringWithUTF8String:mandatory->longitude.c_str()]
      ];
      [_temperature setText:
          [NSString stringWithUTF8String:mandatory->temperature.c_str()]
      ];
      [_wind_speed setText:
          [NSString stringWithUTF8String:mandatory->wind_speed.c_str()]
      ];
      const Result::Opt<Result::Detailed>& detailed = result.detailed();
      if (detailed.is_initialized()) {
        [_description setText:
            [NSString stringWithUTF8String:detailed->description.c_str()]
        ];
        NSString* image_name = [
            NSString stringWithUTF8String:detailed->icon.c_str()
        ];
        _icon.image = [UIImage imageNamed:image_name];
      }
      else {
        [_description setText:@""];
        _icon.image = [UIImage imageNamed:@"empty"];
      }
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
  [_description release];
  [_icon release];

  assert(weather != nullptr);
  delete weather;
  weather = nullptr;

  [super dealloc];
}

@end
