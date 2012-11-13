//
//  Activity.h
//  Breda_Inladen
//
//  Created by Rick Doorakkers on 30-10-12.
//  Copyright (c) 2012 Avans_Groep2. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Category;

@interface Activity : NSManagedObject

@property (nonatomic, retain) NSNumber *activity_id;
@property (nonatomic, retain) NSDate *begin;
@property (nonatomic, retain) NSNumber *category_id;
@property (nonatomic, retain) NSNumber *co_lat;
@property (nonatomic, retain) NSNumber *co_long;
@property (nonatomic, retain) NSString *adres;
@property (nonatomic, retain) NSString *content;
@property (nonatomic, retain) NSString *device_id;
@property (nonatomic, retain) NSDate *end;
@property (nonatomic, retain) NSData *image;
@property (nonatomic, retain) NSString *tags;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *image_url;
@property (nonatomic, retain) Category *fkactivity2category;

@end
