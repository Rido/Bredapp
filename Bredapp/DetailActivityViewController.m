//
//  DetailActivityViewController.m
//  Bredapp
//
//  Created by Rick Artz on 11/7/12.
//  Copyright (c) 2012 Avans_Groep2. All rights reserved.
//

#import "DetailActivityViewController.h"
#import "SHK.h"

@interface DetailActivityViewController ()

@end

@implementation DetailActivityViewController

@synthesize activity, titleLabel,contentLabel,startLabel,adresLabel;

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
	// Do any additional setup after loading the view.
    titleLabel.text = [activity title];
    adresLabel.text = @"Grote Markt 1";
    contentLabel.text = [activity content];
    startLabel.text = @"2012 23 november, 1700 uur";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)delen:(id)sender {
    UIImage *image = [UIImage imageNamed:@"Default.png"];
    
    NSString *title = [NSString stringWithFormat:@"%@\n", titleLabel.text];
    NSString *date = [NSString stringWithFormat:@"%@\n", startLabel.text];
    NSString *where = [NSString stringWithFormat:@"%@\n", adresLabel.text];
    NSString *description = [NSString stringWithFormat:@"%@\n", contentLabel.text];
    NSString *content = title;
    
    content = [content stringByAppendingString:date];
    content = [content stringByAppendingString:where];
    content = [content stringByAppendingString:description];
    SHKItem *item = [SHKItem image:image title:content];
    
    // Get the ShareKit action sheet
    SHKActionSheet *actionSheet = [SHKActionSheet actionSheetForItem:item];
    
    // ShareKit detects top view controller (the one intended to present ShareKit UI) automatically,
    // but sometimes it may not find one. To be safe, set it explicitly
    [SHK setRootViewController:self];
    
    // Display the action sheet
    [actionSheet showFromToolbar:self.navigationController.toolbar];
}


- (void)viewDidUnload {
    [self setTitleLabel:nil];
    [self setContentLabel:nil];
    [self setStartLabel:nil];
    [self setAdresLabel:nil];
    [super viewDidUnload];
}

- (void)dealloc {
    [super dealloc];
}
@end
