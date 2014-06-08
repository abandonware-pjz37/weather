// Copyright (c) 2014, Ruslan Baratov
// All rights reserved.

#import "iPhone.h"

#import <UIKit/UIStoryboard.h>
#import "Weather.h"
#import "About.h"

@interface iPhone ()

@end

@implementation iPhone

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

  UIImage* about_image = [UIImage imageNamed:@"about.png"];
  UIImage* weather_image = [UIImage imageNamed:@"weather.png"];

  auto* about_bar = [
      [UITabBarItem alloc]
      initWithTitle:@"about"
      image:about_image
      selectedImage:nullptr
  ];

  auto* weather_bar = [
      [UITabBarItem alloc]
      initWithTitle:@"weather"
      image:weather_image
      selectedImage:nullptr
  ];

  About* about = [
      about_storyboard instantiateViewControllerWithIdentifier:@"About"
  ];

  Weather* weather = [
      weather_storyboard instantiateViewControllerWithIdentifier:@"Weather"
  ];

  [about setTabBarItem:about_bar];
  [weather setTabBarItem:weather_bar];

  NSArray* controllers = [
      [NSArray alloc] initWithObjects:(id)weather, about, nullptr
  ];

  self.viewControllers = controllers;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
