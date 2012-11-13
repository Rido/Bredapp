//
//  ToevoegenVoorbeeldViewController.m
//  Bredapp
//
//  Created by Rick Artz on 11/8/12.
//  Copyright (c) 2012 Avans_Groep2. All rights reserved.
//

#import "ToevoegenVoorbeeldViewController.h"
#import "SHK.h"

@interface ToevoegenVoorbeeldViewController ()

@end

@implementation ToevoegenVoorbeeldViewController

@synthesize activity;
@synthesize category;
@synthesize titleLabel;
@synthesize datetimeTextView;
@synthesize whereTextView;
@synthesize descriptionTextView;

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
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    titleLabel.text = activity.title;
    datetimeTextView.text = [formatter stringFromDate:activity.begin];
    whereTextView.text = activity.adres;
    descriptionTextView.text = activity.content;
    
}

- (IBAction)delen:(id)sender {
    // Create the item to share (in this example, a url)
    NSURL *url = [NSURL URLWithString:@"http://getsharekit.com"];
    SHKItem *item = [SHKItem URL:url title:@"ShareKit is Awesome!" contentType:SHKURLContentTypeWebpage];
    
    // Get the ShareKit action sheet
    SHKActionSheet *actionSheet = [SHKActionSheet actionSheetForItem:item];
    
    // ShareKit detects top view controller (the one intended to present ShareKit UI) automatically,
    // but sometimes it may not find one. To be safe, set it explicitly
    [SHK setRootViewController:self];
    
    // Display the action sheet
    [actionSheet showFromToolbar:self.navigationController.toolbar];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSLog(@"Klaar!");
}

- (void)dealloc {
    [super dealloc];
}
@end
