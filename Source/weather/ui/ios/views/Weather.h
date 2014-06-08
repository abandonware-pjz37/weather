// Copyright (c) 2014, Ruslan Baratov
// All rights reserved.

#import <MapKit/MKMapView.h>
#import <UIKit/UISearchBar.h>
#import <UIKit/UIViewController.h>

@interface Weather: UIViewController <UISearchBarDelegate, MKMapViewDelegate>
- (void)on_watchdog_counter:(int)counter max:(int)max stop:(bool)stop;
- (void)on_success_longitude:(double)longitude
    latitude:(double)latitude
    temperature:(NSString*)temperature
    description:(NSString*)description
    icon:(NSString*)icon
;
- (void)on_error:(NSString*)message;
@end
