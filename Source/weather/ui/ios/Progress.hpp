// Copyright (c) 2014, Ruslan Baratov
// All rights reserved.

#import <objc/NSObject.h>

@class UIActivityIndicatorView;
@class UILabel;

@interface Progress: NSObject
- (id)init_activity:(UIActivityIndicatorView*)activity_indicator
    progress:(UILabel*)progress_text;
- (void)clear;
- (void)update:(NSString*)message;
@end