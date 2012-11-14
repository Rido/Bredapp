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
    
    return self;
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
        
        cur.distance = [NSNumber numberWithInt:5];
    }
    
    [myApp saveContext];
    NSLog(@"klaar met sorteren");
}

@end
