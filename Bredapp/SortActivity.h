//
//  SortActivity.h
//  Bredapp
//
//  Created by Leroy Meijer on 11/14/12.
//  Copyright (c) 2012 Avans_Groep2. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import <CoreLocation/CoreLocation.h>

@interface SortActivity : NSObject<CLLocationManagerDelegate>{
    CLLocationManager *locationManager;
}

@property (nonatomic, strong) AppDelegate *myApp;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;


- (void)sortDistanceActivity;

@end
