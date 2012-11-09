//
//  CLLocation+Additions.h
// 
//
//  Created by Sergio on 13/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface CLLocation (Geocodereverse)

- (NSString *)forwardGeocodeWithLanguage:(NSString *)language;

@end