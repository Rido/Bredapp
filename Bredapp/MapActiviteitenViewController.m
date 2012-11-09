//
//  MapActiviteitenViewController.m
//  Bredapp
//
//  Created by Rick Artz on 11/8/12.
//  Copyright (c) 2012 Avans_Groep2. All rights reserved.
//

#import "MapActiviteitenViewController.h"
#import <MapKit/MapKit.h>
#import "ActivityAnnotation.h"
#import "Activity.h"

#define METERS_PER_MILE 1609.344

@interface MapActiviteitenViewController ()

@end

@implementation MapActiviteitenViewController

@synthesize mapview;
@synthesize myApp;
@synthesize managedObjectContext;
@synthesize fetchedResultsController = _fetchedResultsController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (NSFetchedResultsController *)fetchedResultsController {
    
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    myApp = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    self.managedObjectContext = [myApp managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Activity" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc]
                              initWithKey:@"begin" ascending:NO];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    
    NSFetchedResultsController *theFetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                        managedObjectContext:managedObjectContext sectionNameKeyPath:nil
                                                   cacheName:@"Root"];
    self.fetchedResultsController = theFetchedResultsController;
    _fetchedResultsController.delegate = self;
    
    return _fetchedResultsController;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    NSError *error;
	if (![[self fetchedResultsController] performFetch:&error]) {
		// Update to handle the error appropriately.
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		exit(-1);  // Fail
	}
    
    [mapview setUserTrackingMode:MKUserTrackingModeFollowWithHeading animated:YES];
    
    // Load activities into array for annotations.
    NSArray *activities = [_fetchedResultsController fetchedObjects];
    
    NSUInteger count = [activities count];
    for (NSUInteger i = 0; i < count; i++) {
        Activity *info = [activities objectAtIndex: i];
        
        //  location for activity.
        CLLocationCoordinate2D location;
        location.latitude = [info.co_lat doubleValue];
        location.longitude = [info.co_long doubleValue];
        // Add the annotation to our map view
        ActivityAnnotation *annotation = [[ActivityAnnotation alloc] initWithTitle:info.title andCoordinate:location];
        [self.mapview addAnnotation:annotation];
        //[annotation release];
    }
    
    
    /*
     Activity *info = [activities objectForKey:1];
     NSLog(@"Activity latitude: %@", info.co_lat);
     NSLog(@"Activity longitude: %@", info.co_long);
     
     //  location for activity.
     CLLocationCoordinate2D location;
     location.latitude = [info.co_lat doubleValue];
     location.longitude = [info.co_long doubleValue];
     // Add the annotation to our map view
     ActivityAnnotation *annotation = [[ActivityAnnotation alloc] initWithTitle:info.title andCoordinate:location];
     [self.mapview addAnnotation:annotation];
     [annotation release];
     */
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
}

- (void)viewDidUnload {
    [self setMapview:nil];
    [super viewDidUnload];
}
@end
