//
//  ActivityAnnotation.h
//  Bredapp
//
//  Created by Rick Artz on 11/8/12.
//  Copyright (c) 2012 Avans_Groep2. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface ActivityAnnotation : NSObject <MKAnnotation> {
    
	NSString *title;
    NSString *subTitle;
    NSUInteger *activityInArray;
	CLLocationCoordinate2D coordinate;
    
}

@property (nonatomic, retain) NSString *title, *subTitle;
@property (nonatomic) NSUInteger *activityInArray;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

- (id)initWithTitle:(NSString *)theTitle andSubTitle:(NSString *)theSubTitle andTheCoordinate:(CLLocationCoordinate2D)c2d andTheActivityInArray:(NSUInteger *)theActivityInArray;

@end