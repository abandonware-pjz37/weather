// Copyright (c) 2014, Ruslan Baratov
// All rights reserved.

#import "iPad.hpp"

#import "About.hpp"
#import "Weather.hpp"

@interface iPad ()

@end

@implementation iPad

- (id)initWithNibName:(NSString *)nibNameOrNil
    bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  auto* about_storyboard = [
      UIStoryboard storyboardWithName:@"About" bundle:nullptr
  ];
  auto* weather_storyboard = [
      UIStoryboard storyboardWithName:@"Weather" bundle:nullptr
  ];

  About* about = [
      about_storyboard instantiateViewControllerWithIdentifier:@"About"
  ];

  Weather* weather = [
      weather_storyboard instantiateViewControllerWithIdentifier:@"Weather"
  ];

  NSArray* controllers = [
      [NSArray alloc] initWithObjects:(id)about, weather, nullptr
  ];

  self.viewControllers = controllers;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
