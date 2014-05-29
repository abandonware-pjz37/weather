// Copyright (c) 2014, Ruslan Baratov
// All rights reserved.

#import <MapKit/MKMapView.h> // MKAnnotation

@interface Annotation: NSObject <MKAnnotation>
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, readonly, copy) NSString* title;
@property (nonatomic, readonly, copy) NSString* subtitle;
@property (nonatomic, readonly, copy) NSString* icon;

- (id)init_with_longitude:(double)longitude
    latitude:(double)latitude
    temperature:(NSString*)temperature
    description:(NSString*)description
    icon:(NSString*)icon
;
@end
