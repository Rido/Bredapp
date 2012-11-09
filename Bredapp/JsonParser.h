//
//  JsonActivity.h
//  Breda_Inladen
//
//  Created by Rick Doorakkers on 08-10-12.
//  Copyright (c) 2012 Avans_Groep2. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface JsonParser : NSObject
{
    NSMutableData *receivedData;
    NSURLConnection *connection;
}

@property (nonatomic, strong) AppDelegate *myApp;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

- (void)loadCategories;
- (void)loadActivities;

@end
