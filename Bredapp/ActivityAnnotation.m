//
//  ActivityAnnotation.m
//  Bredapp
//
//  Created by Rick Artz on 11/8/12.
//  Copyright (c) 2012 Avans_Groep2. All rights reserved.
//

#import "ActivityAnnotation.h"

@implementation ActivityAnnotation

@synthesize title, subTitle, coordinate;
@synthesize activityInArray;

- (id)initWithTitle:(NSString *)theTitle andSubTitle:(NSString *)theSubTitle andTheCoordinate:(CLLocationCoordinate2D)c2d andTheActivityInArray:(NSUInteger*)theActivityInArray;{
	[super init];
    title = theTitle;
    subTitle = theSubTitle;
    coordinate = c2d;
    activityInArray = theActivityInArray;
	return self;
}

- (NSString *)title {
    return title;
}

- (NSString *)subTitle {
    return subTitle;
}

@end