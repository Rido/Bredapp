//
//  ToevoegenWanneerViewController.m
//  Bredapp
//
//  Created by Leroy Meijer on 11/8/12.
//  Copyright (c) 2012 Avans_Groep2. All rights reserved.
//

#import "ToevoegenWanneerViewController.h"
#import "ToevoegenVoorbeeldViewController.h"
#import "Activity.h"

@interface ToevoegenWanneerViewController ()

@end

@implementation ToevoegenWanneerViewController
@synthesize datePicker;
@synthesize selectedTextField;
@synthesize databaseDateFormat;
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

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    // Huidige datum
    NSDate *currentDate = [[NSDate alloc] init];
    
    // Geselecteerde textfield instellen
    selectedTextField = textField;
    
    // Datepicker instellen
    datePicker = [[UIDatePicker alloc] init];
    datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    
    // Minimum en maximum date instellen
    datePicker.minimumDate = currentDate;
    datePicker.maximumDate = [currentDate dateByAddingTimeInterval:86400];
    
    [datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    [textField setInputView:datePicker];
}

- (void) datePickerValueChanged:(id)sender
{
    // Date format voor weergave in tekstveld
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"EEEE d MMMM HH:mm"];
    
    NSString *newDateString = [outputFormatter stringFromDate:datePicker.date];
    
    // Date format voor database
    NSDateFormatter *databaseOutputFormatter = [[NSDateFormatter alloc] init];
    [databaseOutputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    databaseDateFormat = [databaseOutputFormatter stringFromDate:datePicker.date];
    
    // Datum weergeven in tekstveld
    selectedTextField.text = newDateString;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"toVoorbeeld"]) {

        ToevoegenVoorbeeldViewController *vc = [segue destinationViewController];
        vc.activity = activity;
        vc.category = category;
        
    }
}

@end
