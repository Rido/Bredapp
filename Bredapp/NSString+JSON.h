//
//  NSString+JSON.h
//  
//
//  Created by Sergio on 22/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <CoreLocation/CoreLocation.h>

@interface NSString (JSON) 

- (CLLocation *)newGeocodeAddress;

@end