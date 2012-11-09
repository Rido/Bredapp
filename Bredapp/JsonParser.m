//
//  JsonActivity.m
//  Breda_Inladen
//
//  Created by Rick Doorakkers on 08-10-12.
//  Copyright (c) 2012 Avans_Groep2. All rights reserved.
//

#import "JsonParser.h"
#import "JSONKit.h"
#import "Activity.h"
#import "Category.h"

@implementation JsonParser

@synthesize  myApp, managedObjectContext;

- (id)init {
    self = [super init];
    if (self) {
        myApp = (AppDelegate *) [[UIApplication sharedApplication] delegate];
        self.managedObjectContext = [myApp managedObjectContext];
    }
    
    return self;
}

- (void)categoriesDone {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CategoriesDone" object:self];
}

- (void)loadCategories
{
    bool reloadCategories = true;
    
	NSError* error = nil;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Category"
                                              inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    [fetchRequest setIncludesSubentities:NO];
    
    NSArray *results = [managedObjectContext executeFetchRequest:fetchRequest error:&error];

    if (!error && [results count] > 0)
    {
        Category *latest = [results objectAtIndex:0];
        NSDate *curDate = [[NSDate alloc] init];
        NSTimeInterval distanceBetweenDates = [curDate timeIntervalSinceDate:latest.last_update];
        
        if (distanceBetweenDates < 1209600)
        {
            reloadCategories = false;
        }
        else
        {
            for (NSManagedObject *managedObject in results)
            {
                [managedObjectContext deleteObject:managedObject];
            }
            
            [myApp saveContext];
        }
    }
    
    if (reloadCategories)
    {
        NSURLRequest *theRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.larsvanbeek.nl/BredAppWs/categories"]
                                                    cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                timeoutInterval:10.0];

        NSURLResponse* response = nil;
        NSData * jsonData = [NSURLConnection sendSynchronousRequest:theRequest returningResponse:&response error:&error];
        
        if (error)
        {
            NSLog(@"Error performing request %@", error);
        }
        
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSDictionary *categories = [jsonString objectFromJSONString];
        NSDictionary *currentCategory;
        
        for (NSString *key in categories)
        {
            currentCategory = [categories objectForKey:key];
            Category *category = (Category *) [NSEntityDescription insertNewObjectForEntityForName:@"Category"
                                                                            inManagedObjectContext:[self managedObjectContext]];
            
            category.category_id    = [NSNumber numberWithInt:[[currentCategory objectForKey:@"id"] intValue]];
            category.content        = [currentCategory objectForKey:@"content"];
            category.image_url      = [currentCategory objectForKey:@"image"];
            category.name           = [currentCategory objectForKey:@"name"];
            category.image          = [NSData dataWithContentsOfURL:[NSURL URLWithString:category.image_url]];
            NSLog(@"%@", category.image);
            category.last_update    = [[NSDate alloc] init];
        }
        
        [myApp saveContext];
    }
    
    [self performSelectorOnMainThread:@selector(categoriesDone) withObject:nil waitUntilDone:YES];
}

- (void)activitiesDone {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ActivitiesDone" object:self];
}

- (void)loadActivities
{
    int latestActivity = 0;
	NSError* error = nil;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Activity"
                                              inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"activity_id" ascending:NO];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    NSArray *results = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if ([results count] > 0)
    {
        Activity *latest = [results objectAtIndex:0];
        latestActivity = [latest.activity_id intValue];
    }
    
    NSString *theUrl = [NSString stringWithFormat:@"http://www.larsvanbeek.nl/BredAppWs/activities/%d", latestActivity];
    NSURLRequest *theRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:theUrl]
                                                cachePolicy:NSURLRequestUseProtocolCachePolicy
                                            timeoutInterval:10.0];
	NSURLResponse* response = nil;
    NSData * jsonData = [NSURLConnection sendSynchronousRequest:theRequest returningResponse:&response error:&error];
    
    if (error)
    {
        NSLog(@"Error performing request %@", error);
    }
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSDictionary *activities = [jsonString objectFromJSONString];
    NSDictionary *currentActivity;
    
    for (NSString *key in activities)
    {
        currentActivity = [activities objectForKey:key];
        Activity *activity = (Activity *) [NSEntityDescription insertNewObjectForEntityForName:@"Activity"
                                                                        inManagedObjectContext:[self managedObjectContext]];
        
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"yyyy-MM-dd hh:mm:ss a"];
        
        activity.activity_id    = [NSNumber numberWithInt:[[currentActivity objectForKey:@"id"] intValue]];
        activity.begin          = [df dateFromString:[currentActivity objectForKey:@"begin"]];
        activity.category_id    = [NSNumber numberWithInt:[[currentActivity objectForKey:@"category_id"] intValue]];
        activity.co_lat         = [NSNumber numberWithFloat:[[currentActivity objectForKey:@"co_lat"] floatValue]];
        activity.co_long        = [NSNumber numberWithFloat:[[currentActivity objectForKey:@"co_long"] floatValue]];
        activity.content        = [currentActivity objectForKey:@"content"];
        activity.device_id      = [currentActivity objectForKey:@"device_id"];
        activity.end            = [df dateFromString:[currentActivity objectForKey:@"end"]];
        activity.image_url      = [currentActivity objectForKey:@"image"];
        activity.tags           = [currentActivity objectForKey:@"tags"];
        activity.title          = [currentActivity objectForKey:@"title"];
    }
    
    [myApp saveContext];
    
    [self performSelectorOnMainThread:@selector(activitiesDone) withObject:nil waitUntilDone:YES];
}

@end