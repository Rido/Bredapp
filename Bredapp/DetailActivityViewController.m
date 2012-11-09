//
//  DetailActivityViewController.m
//  Bredapp
//
//  Created by Rick Artz on 11/7/12.
//  Copyright (c) 2012 Avans_Groep2. All rights reserved.
//

#import "DetailActivityViewController.h"

@interface DetailActivityViewController ()

@end

@implementation DetailActivityViewController

@synthesize activity;
@synthesize titleLabel,contentLabel,startLabel,adresLabel;

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

- (void)viewDidUnload {
    [self setTitleLabel:nil];
    [self setContentLabel:nil];
    [self setStartLabel:nil];
    [self setAdresLabel:nil];
    [super viewDidUnload];
}

@end
