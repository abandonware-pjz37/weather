// Copyright (c) 2014, Ruslan Baratov
// All rights reserved.

#import <UIKit/UIViewController.h>
#import <UIKit/UISearchBar.h>

@interface WeatherTab: UIViewController <UISearchBarDelegate>
- (void)on_watchdog_counter:(int)counter max:(int)max stop:(bool)stop;
- (void)on_success_longitude:(double)longitude
    latitude:(double)latitude
    temperature:(NSString*)temperature
    description:(NSString*)description
    icon:(NSString*)icon
;
- (void)on_error:(NSString*)message;
@end
