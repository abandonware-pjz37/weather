// Copyright (c) 2014, Ruslan Baratov
// All rights reserved.

#import "SearchBar.hpp"

@implementation SearchBar

- (void)first_responder:(BOOL)is_first_responder {
  BOOL show_cancel = is_first_responder && (self.text.length == 0);
  [self setShowsCancelButton:show_cancel animated:YES];
  if (!is_first_responder) {
    [self resignFirstResponder];
  }
}

@end
