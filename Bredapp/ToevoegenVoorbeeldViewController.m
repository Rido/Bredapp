//
//  ToevoegenVoorbeeldViewController.m
//  Bredapp
//
//  Created by Rick Artz on 11/8/12.
//  Copyright (c) 2012 Avans_Groep2. All rights reserved.
//

#import "ToevoegenVoorbeeldViewController.h"

@interface ToevoegenVoorbeeldViewController ()

@end

@implementation ToevoegenVoorbeeldViewController
@synthesize activity;
@synthesize category;

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
    [_titel release];
    [_wanneer release];
    [_title release];
    [_when release];
    [_where release];
    [_activityTitle release];
    [_where release];
    [_when release];
    [_content release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setTitel:nil];
    [self setWanneer:nil];
    [self setTitle:nil];
    [self setWhen:nil];
    [self setWhere:nil];
    [self setActivityTitle:nil];
    [self setWhere:nil];
    [self setWhen:nil];
    [self setContent:nil];
    [super viewDidUnload];
}
@end
