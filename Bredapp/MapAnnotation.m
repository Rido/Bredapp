//
//  MapAnnotation.m
//  GeoCoder
//
//  Created by Frank Jüstel on 21.12.11.
//  Copyright (c) 2011 JSM Arts Webservices GbR. All rights reserved.
//

#import "MapAnnotation.h"

@implementation MapAnnotation

@synthesize title = _title;
@synthesize subtitle = _subtitle;
@synthesize coordinate = _coordinate;

- (id) initWithTitle: (NSString *) title subtitle: (NSString *) subtitle coordinate: (CLLocationCoordinate2D) coordinate
{
    self = [super init];
    if (self) {
        self.title = title;
        self.subtitle = subtitle;
        self.coordinate = coordinate;
    }
    return self;
}
@end
