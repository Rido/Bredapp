//
//  MapAnnotation.h
//  GeoCoder
//
//  Created by Frank Jüstel on 21.12.11.
//  Copyright (c) 2011 JSM Arts Webservices GbR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MapAnnotation : NSObject <MKAnnotation>

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

- (id) initWithTitle: (NSString *) title subtitle: (NSString *) subtitle coordinate: (CLLocationCoordinate2D) coordinate;

@end
