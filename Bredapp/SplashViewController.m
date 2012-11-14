//
//  SplashViewController.m
//  Breda_Inladen
//
//  Created by Rick Doorakkers on 28-09-12.
//  Copyright (c) 2012 Avans_Groep2. All rights reserved.
//

#import "SplashViewController.h"
#import "IsIphone5.h"
#import "SortActivity.h"
#import "JsonParser.h"
#import "Activity.h"
#import "Category.h"

@interface SplashViewController ()

@end

@implementation SplashViewController

@synthesize managedObjectContext;
@synthesize backgroundImage, activityIndicator, statusLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (isPhone568)
    {
        UIImage *newImage = [UIImage imageNamed:@"Default-568h@2x"];
        [backgroundImage setImage:newImage];
        [backgroundImage setContentMode:UIViewContentModeScaleAspectFit];
    }
    
    statusLabel.text = @"Categorieen verwerken";
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receivedUpdateNotification:)
                                                 name:@"CategoriesDone"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receivedUpdateNotification:)
                                                 name:@"ActivitiesDone"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receivedUpdateNotification:)
                                                 name:@"JsonError"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receivedUpdateNotification:)
                                                 name:@"SortingDone"
                                               object:nil];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        // webservice
        JsonParser *_jsonActivity = [[JsonParser alloc] init];
        [_jsonActivity loadCategories];
        [_jsonActivity loadActivities];
        
        SortActivity *_sort = [[SortActivity alloc] init];
        [_sort sortDistanceActivity];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SortingDone" object:self];
        });
    });
}

- (void) receivedUpdateNotification:(NSNotification *) notification
{
    if ([[notification name] isEqualToString:@"CategoriesDone"])
    {
        statusLabel.text = @"Activiteiten verwerken";
    }
    else if ([[notification name] isEqualToString:@"ActivitiesDone"])
    {
        statusLabel.text = @"Data verwerken";
    }
    else if ([[notification name] isEqualToString:@"SortingDone"])
    {
        statusLabel.text = @"Data is verwerkt";
        [self performSegueWithIdentifier:@"doneLoading" sender:self];
    }
    else if ([[notification name] isEqualToString:@"JsonError"])
    {
        statusLabel.text = @"Fout bij verwerken data";
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

@end
