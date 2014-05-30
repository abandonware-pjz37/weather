// Copyright (c) 2014, Ruslan Baratov
// All rights reserved.

#import <weather/ui/ios/iphone/WeatherTab.h>

#import <MapKit/MapKit.h> // MKMapView
#import <UIKit/UIImageView.h>
#import <UIKit/UILabel.h>
#import <UIKit/UISearchBar.h>
#import <weather/ui/ios/Annotation.hpp>
#import <weather/ui/ios/EngineWrapper.hpp>
#import <weather/ui/ios/Progress.hpp>
#import <weather/ui/ios/SearchBar.hpp>

#include <boost/log/sinks.hpp>
#include <boost/utility/empty_deleter.hpp>
#include <boost/log/utility/setup.hpp>
#include <weather/DelegateBase.hpp>
#include <sober/log/attributes.hpp> // log::severity

@interface WeatherTab () {
  weather::ui::ios::EngineWrapper* engine;
}
- (void)init_logging;
- (void)start_search;

@property (nonatomic) Annotation* annotation;
@property (nonatomic) Progress* progress;
@property (weak, nonatomic) IBOutlet SearchBar *search_bar;
@property (weak, nonatomic) IBOutlet MKMapView *map_view;
@property (weak, nonatomic) IBOutlet
    UIActivityIndicatorView *activity_indicator;
@property (weak, nonatomic) IBOutlet UILabel *progress_text;
@end

@implementation WeatherTab

- (void)init_logging {
  // Init boost.log
  boost::log::add_common_attributes();

  namespace sinks = boost::log::sinks;
  using Sink = sinks::synchronous_sink<sinks::text_ostream_backend>;

  auto sink = boost::make_shared<Sink>();
  sink->locked_backend()->add_stream(
      boost::shared_ptr<std::ostream>(&std::cout, boost::empty_deleter())
  );
  sink->set_formatter(&sober::log::formatter);
  sink->set_filter(sober::log::severity != sober::log::Severity::DEBUG);

  boost::log::core::get()->add_sink(sink);
}

- (void)start_search {
  [self.progress clear];

  const std::string city = [self.search_bar.text UTF8String];
  if (city.empty()) {
    return;
  }

  engine->run(city.c_str());
}

// Called from WeatherTabDelegate
- (void)on_watchdog_counter:(int)counter max:(int)max stop:(bool)stop {
  if (stop) {
    [self.progress clear];
    [self on_error:@"Timeout reached"];
    return;
  }

  NSString* message = [NSString stringWithFormat:@"%d/%d", counter, max];
  [self.progress update:message];
}

- (void)on_success_longitude:(double)longitude
    latitude:(double)latitude
    temperature:(NSString*)temperature
    description:(NSString*)description
    icon:(NSString*)icon {
  [self.progress clear];

  if (self.annotation != nullptr) {
    [self.map_view removeAnnotation:self.annotation];
    self.annotation = nullptr;
  }

  assert(self.annotation == nullptr);
  self.annotation = [
      [Annotation alloc]
          init_with_longitude:longitude
          latitude:latitude
          temperature:temperature
          description:description icon:icon
  ];
  assert(self.annotation != nullptr);

  MKCoordinateRegion region = self.map_view.region;
  region.center = self.annotation.coordinate;

  [UIView
      animateWithDuration:0.8f
      delay:0.0f
      options:UIViewAnimationCurveEaseOut
      animations:^{
        [self.map_view setRegion:region];
      }
      completion:^(BOOL finished) {
        if (!finished) {
          return;
        }
        [self.map_view addAnnotation:self.annotation];
        [self.map_view selectAnnotation:self.annotation animated:YES];
      }
  ];
}

- (void)on_error:(NSString*)message {
  [self.progress clear];

  UIAlertView* alert = [
      [UIAlertView alloc]
      initWithTitle:@"Oops :("
      message:message
      delegate:nullptr
      cancelButtonTitle:@"back"
      otherButtonTitles:nullptr
  ];
  [alert show];
}

// UIViewContoller override
- (void)viewDidLoad {
  [super viewDidLoad];

  [self init_logging];

  assert(engine == nullptr);
  engine = new weather::ui::ios::EngineWrapper(self);

  _search_bar.delegate = self;
  _map_view.delegate = self;
  self.annotation = nullptr;

  self.progress = [
      [Progress alloc]
          init_activity:self.activity_indicator
          progress:self.progress_text
  ];
  assert(self.progress != nullptr);
  [self.progress clear];
}

// MKMapViewDelegate
- (MKAnnotationView*)mapView:(MKMapView*)map_view
    viewForAnnotation:(id<MKAnnotation>)annotation {
  assert(map_view == self.map_view);
  assert(annotation == self.annotation);

  NSString* reuse_id = self.annotation.icon;

  MKAnnotationView* view =
      [self.map_view dequeueReusableAnnotationViewWithIdentifier:reuse_id]
  ;

  if (view == nullptr) {
    // Create new one
    MKPinAnnotationView* pin_view = [
        [MKPinAnnotationView alloc]
            initWithAnnotation:annotation
            reuseIdentifier:reuse_id
    ];
    pin_view.enabled = YES;
    pin_view.pinColor = MKPinAnnotationColorGreen;
    pin_view.animatesDrop = YES;
    pin_view.canShowCallout = YES;
    UIImage* image = [UIImage imageNamed:reuse_id];
    UIImageView* image_view = [[UIImageView alloc] initWithImage:image];
    pin_view.leftCalloutAccessoryView = image_view;
    view = pin_view;
  }

  assert(view != nullptr);
  return view;
}

// UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
  assert(_search_bar == searchBar);
  [self start_search];
  [_search_bar first_responder:NO];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
  assert(_search_bar == searchBar);
  [_search_bar first_responder:NO];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
  assert(_search_bar == searchBar);
  [_search_bar first_responder:YES];
  return YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
  assert(_search_bar == searchBar);
  [_search_bar first_responder:YES];
}

- (void)dealloc {
  assert(engine != nullptr);
  delete engine;
  engine = nullptr;
}

@end
