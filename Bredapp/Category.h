//
//  Category.h
//  Bredapp
//
//  Created by Rick Doorakkers on 09-11-12.
//  Copyright (c) 2012 Avans_Groep2. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Category : NSManagedObject

@property (nonatomic, retain) NSNumber * category_id;
@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSData * image;
@property (nonatomic, retain) NSString * image_url;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * last_update;

@end
