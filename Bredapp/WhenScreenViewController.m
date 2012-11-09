//
//  WhenScreenViewController.m
//  WhenScreenTest
//
//  Created by Lars van Beek on 10/30/12.
//  Copyright (c) 2012 com.wecreatepixels. All rights reserved.
//

#import "WhenScreenViewController.h"

@interface WhenScreenViewController ()

@end

@implementation WhenScreenViewController

@synthesize datePicker;
@synthesize selectedTextField;
@synthesize databaseDateFormat;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
  
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

@end
