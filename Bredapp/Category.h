//
//  Category.h
//  Breda_Inladen
//
//  Created by Rick Doorakkers on 30-10-12.
//  Copyright (c) 2012 Avans_Groep2. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Category : NSManagedObject

@property (nonatomic, retain) NSNumber * category_id;
@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSData * image;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * image_url;

@end
