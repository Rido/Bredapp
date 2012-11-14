//
//  SortActivity.m
//  Bredapp
//
//  Created by Leroy Meijer on 11/14/12.
//  Copyright (c) 2012 Avans_Groep2. All rights reserved.
//

#import "SortActivity.h"
#import "Activity.h"

@implementation SortActivity

@synthesize  myApp, managedObjectContext;

- (id)init {
    self = [super init];
    if (self) {
        myApp = (AppDelegate *) [[UIApplication sharedApplication] delegate];
        self.managedObjectContext = [myApp managedObjectContext];
    }
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    int degrees = locationManager.location.coordinate.latitude;
    double decimal = fabs(locationManager.location.coordinate.latitude - degrees);
    int minutes = decimal * 60;
    double seconds = decimal * 3600 - minutes * 60;
    NSString *lat = [NSString stringWithFormat:@"%d° %d' %1.4f\"",
                     degrees, minutes, seconds];
    
    degrees = locationManager.location.coordinate.longitude;
    decimal = fabs(locationManager.location.coordinate.longitude - degrees);
    minutes = decimal * 60;
    seconds = decimal * 3600 - minutes * 60;
    NSString *longt = [NSString stringWithFormat:@"%d° %d' %1.4f\"",
                       degrees, minutes, seconds];

  
    NSLog(@"Lat: %@", lat);
    NSLog(@"Long: %@", longt);
    [locationManager startUpdatingLocation];
    
    return self;
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    int degrees = newLocation.coordinate.latitude;
    double decimal = fabs(newLocation.coordinate.latitude - degrees);
    int minutes = decimal * 60;
    double seconds = decimal * 3600 - minutes * 60;
    NSString *lat = [NSString stringWithFormat:@"%d° %d' %1.4f\"",
                     degrees, minutes, seconds];

    degrees = newLocation.coordinate.longitude;
    decimal = fabs(newLocation.coordinate.longitude - degrees);
    minutes = decimal * 60;
    seconds = decimal * 3600 - minutes * 60;
    NSString *longt = [NSString stringWithFormat:@"%d° %d' %1.4f\"",
                       degrees, minutes, seconds];
    
    NSLog(@"Lat: %@", lat);
    NSLog(@"Long: %@", longt);

}

- (void)sortDistanceActivity
{
    NSError *error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Institution"];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Activity"
                                              inManagedObjectContext:managedObjectContext];
    
    [fetchRequest setEntity:entity];
    
    NSArray *queryResults = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    
    for(Activity *cur in queryResults)
    {
       // Bereken meters cur.co_long        
        
        //actLoc.coordinate.latitude = [cur.co_lat doubleValue];
        //actLoc.coordinate.longitude = cur.co_long;
        //CLLocationDistance distance = [coords getDistanceFrom:actLoc];
        //cur.distance = ;
        

        CLLocationCoordinate2D coord;
        coord.longitude = (CLLocationDegrees)[cur.co_lat doubleValue];
        coord.latitude = (CLLocationDegrees)[cur.co_long doubleValue];
        
        CLLocation *actLoc = [[CLLocation alloc] initWithLatitude:coord.latitude longitude:coord.longitude];
        
        
        CLLocationDistance dist = [locationManager.location distanceFromLocation:actLoc];
        
        
        NSLog(@"DIST: %f", dist); // Wrong formatting may show wrong value!
    }
    
    [myApp saveContext];
    NSLog(@"klaar met sorteren");
}

@end
