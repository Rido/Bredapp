//
//  LijstActiviteitenViewController.m
//  Bredapp
//
//  Created by Rick Artz on 11/5/12.
//  Copyright (c) 2012 Avans_Groep2. All rights reserved.
//

#import "LijstActiviteitenViewController.h"
#import "Activity.h"
#import "Category.h"
#import "DetailActivityViewController.h"
#import "ActivityCell.h"

@interface LijstActiviteitenViewController ()

@end

@implementation LijstActiviteitenViewController{
}

@synthesize myApp;
@synthesize managedObjectContext;
@synthesize fetchedResultsController = _fetchedResultsController;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // nil
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

- (IBAction)sortingChanged:(UISegmentedControl *)sender {
    
    if(sender.selectedSegmentIndex == 0) {
       /* NSArray *allObjects = [_fetchedResultsController fetchedObjects];
                NSSortDescriptor *sortNameDescriptor =
        [[NSSortDescriptor alloc] initWithKey:@"distance"
                                     ascending:YES];
        
        NSArray *sortDescriptors = [[NSArray alloc]
                                     initWithObjects:sortNameDescriptor, nil];
        
        // items is a synthesized ivar that we use as the table view
        // data source.
        [self.tableView setDataSource:[allObjects sortedArrayUsingDescriptors:sortDescriptors]];
        [self.tableView reloadData];
        //NSLog(@"Activiteiten: %@", sortedArray);
        */
        NSLog(@"Sorteren op tijd");
    } else if (sender.selectedSegmentIndex == 1) {
        
        // Sorteren op afstand
        NSLog(@"Sorteren op afstand");
        
    } else {
        
        // Sorteren op categorie
        NSLog(@"Sorteren op categorie");
        
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSError *error;
	if (![[self fetchedResultsController] performFetch:&error]) {
		// Update to handle the error appropriately.
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		exit(-1);  // Fail
	}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    id  sectionInfo =
    [[_fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (void)configureCell:(ActivityCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    Activity *info = [_fetchedResultsController objectAtIndexPath:indexPath];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE d MMMM HH:mm"];
    
    cell.title.text = info.title;
    cell.start.text = [dateFormatter stringFromDate:info.begin];
    cell.distance.text = [info.distance stringValue];
    cell.category.image = [UIImage imageWithData:info.fkactivity2category.image];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"cell";
    
    ActivityCell *cell = (ActivityCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Set up the cell...
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"goToDetails"]) {
        DetailActivityViewController *destinationVC = segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        Activity *selectedActivity = [_fetchedResultsController objectAtIndexPath:indexPath];
        destinationVC.activity = selectedActivity;
    }
    if ([segue.identifier isEqualToString:@"goToMap"]) {
        // do shit here?
    }
}

- (void)viewDidUnload {
    self.fetchedResultsController = nil;
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller is about to start sending change notifications, so prepare the table view for updates.
    [self.tableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.tableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray
                                               arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray
                                               arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id )sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller has sent all current change notifications, so tell the table view to process all updates.
    [self.tableView endUpdates];
}

@end
