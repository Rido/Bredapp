//
//  MapActiviteitenViewController.h
//  Bredapp
//
//  Created by Rick Artz on 11/8/12.
//  Copyright (c) 2012 Avans_Groep2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "AppDelegate.h"
#import "ActivityAnnotation.h"

@interface MapActiviteitenViewController : UIViewController <MKMapViewDelegate>


@property (retain, nonatomic) IBOutlet MKMapView *mapview;
@property (nonatomic, strong) AppDelegate *myApp;
@property (nonatomic,strong) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) NSArray *activities;
@property (nonatomic) NSUInteger *selectedInArray;
@property (nonatomic, strong) ActivityAnnotation *annotation;

@end
