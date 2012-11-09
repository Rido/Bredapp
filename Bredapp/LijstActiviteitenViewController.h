//
//  LijstActiviteitenViewController.h
//  Bredapp
//
//  Created by Rick Artz on 11/5/12.
//  Copyright (c) 2012 Avans_Groep2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface LijstActiviteitenViewController : UITableViewController

@property (nonatomic, strong) AppDelegate *myApp;
@property (nonatomic,strong) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

@end
