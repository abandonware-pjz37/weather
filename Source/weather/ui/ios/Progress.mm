// Copyright (c) 2014, Ruslan Baratov
// All rights reserved.

#import <weather/ui/ios/Progress.hpp>

#import <UIKit/UIActivityIndicatorView.h>
#import <UIKit/UILabel.h>

@interface Progress ()
@property (weak, nonatomic) UIActivityIndicatorView *activity_indicator;
@property (weak, nonatomic) UILabel *progress_text;
@end

@implementation Progress

- (id)init_activity:(UIActivityIndicatorView*)activity_indicator
    progress:(UILabel*)progress_text {
  self = [super init];
  if (self == nullptr) {
    return self;
  }
  _activity_indicator = activity_indicator;
  _progress_text = progress_text;
  return self;
}

- (void)clear {
  self.progress_text.hidden = YES;
  [self.activity_indicator stopAnimating];
}

- (void)update:(NSString*)message {
  self.progress_text.hidden = NO;
  self.progress_text.text = message;
  [self.activity_indicator startAnimating];

  // Update magic: http://stackoverflow.com/a/6363989/2288008
  // Run main loop once to process UILabel text update
  [[NSRunLoop currentRunLoop]
      runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantPast]
  ];
}

@end
