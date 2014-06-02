// Copyright (c) 2014, Ruslan Baratov
// All rights reserved.

#import <weather/ui/ios/iphone/AboutTab.h>

@interface AboutTab ()
@property (strong, nonatomic) IBOutlet UITableView *table_view;
- (NSString*)get_url:(NSIndexPath*)index_path;
@end

@implementation AboutTab

- (NSString*)get_url:(NSIndexPath*)index_path {
  assert(index_path.length == 2);

  NSUInteger i1 = [index_path indexAtPosition:0];
  NSUInteger i2 = [index_path indexAtPosition:1];

  switch (i1) {
    case 0: // Weather
      switch (i2) {
        case 0: return @"http://www.github.com/ruslo/weather";
        case 1: return @"http://www.openweathermap.org";
        default: assert(false);
      }
    case 1: // C++ Core
      switch (i2) {
        case 0: return @"http://www.boost.org";
        case 1: return @"http://www.github.com/ruslo/sober";
        case 2: return @"http://www.github.com/cpp-netlib/uri";
        case 3: return @"https://code.google.com/p/googletest";
        case 4: return @"https://github.com/cierelabs/json_spirit";
        default: assert(false);
      }
    case 2: // Build System
      switch (i2) {
        case 0: return @"http://cmake.org";
        default: assert(false);
      }
    case 3: // CMake Tools
      switch (i2) {
        case 0: return @"http://www.github.com/ruslo/hunter";
        case 1: return @"http://www.github.com/ruslo/polly";
        case 2: return @"http://www.github.com/ruslo/sugar";
        default: assert(false);
      }
    default:
      assert(false);
  }
}

// UITableViewController override
- (void)viewDidLoad {
  [super viewDidLoad];
  self.table_view.delegate = self;
}

// UITableViewDelegate
- (void)tableView:(UITableView *)table_view
    didSelectRowAtIndexPath:(NSIndexPath *)index_path {
  assert(table_view == self.table_view);

  NSString* url = [self get_url:index_path];
  assert(url != nullptr);
  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

@end