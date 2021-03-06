//
//  ToevoegenWanneerViewController.m
//  Bredapp
//
//  Created by Leroy Meijer on 11/8/12.
//  Copyright (c) 2012 Avans_Groep2. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "ToevoegenWanneerViewController.h"
#import "ToevoegenVoorbeeldViewController.h"

@interface ToevoegenWanneerViewController ()

@end

@implementation ToevoegenWanneerViewController
@synthesize datePicker;
@synthesize datePickerEndDate;
@synthesize selectedTextField;
@synthesize databaseDateFormat;
@synthesize activity;
@synthesize beginField;
@synthesize endField;
@synthesize theNewDateString;

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

    // Datepicker voor het endfield instellen
    datePickerEndDate = [[UIDatePicker alloc] init];
    datePickerEndDate.datePickerMode = UIDatePickerModeDateAndTime;
    
    [self.beginField.layer setBackgroundColor: [[UIColor whiteColor] CGColor]];
    [self.beginField.layer setBorderColor: [[UIColor blackColor] CGColor]];
    [self.beginField.layer setBorderWidth: 1.0];
    [self.beginField.layer setCornerRadius:8.0f];
    [self.beginField.layer setMasksToBounds:YES];
    [self.beginField.layer setShadowRadius:0.0f];
    self.beginField.borderStyle = UITextBorderStyleLine;
    
    [self.endField.layer setBackgroundColor: [[UIColor whiteColor] CGColor]];
    [self.endField.layer setBorderColor: [[UIColor blackColor] CGColor]];
    [self.endField.layer setBorderWidth: 1.0];
    [self.endField.layer setCornerRadius:8.0f];
    [self.endField.layer setMasksToBounds:YES];
    [self.endField.layer setShadowRadius:0.0f];
    self.endField.borderStyle = UITextBorderStyleLine;
    
    // Datepicker eerst onzichtbaar maken
    datePickerEndDate.alpha = 0;
    
    // Onzichtbare datepicker aan endDate veld koppelen
    [endField setInputView:datePickerEndDate];
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
    
    [beginField setInputView:datePicker];
}

- (void) datePickerValueChanged:(id)sender
{
    // Date format voor weergave in tekstveld
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"EEEE d MMMM HH:mm"];
    
    if (selectedTextField == beginField)
    {
        // Date string vullen met beginField datum
        theNewDateString = [outputFormatter stringFromDate:datePicker.date];
        
        activity.begin = datePicker.date;
        
        // Te selecteren datums voor endField op basis van begin date
        datePickerEndDate.minimumDate = datePicker.date;
        datePickerEndDate.maximumDate = [datePicker.date dateByAddingTimeInterval:86400];
        
        // Datepicker voor endField weer zichtbaar maken
        datePickerEndDate.alpha = 1;
        
        [datePickerEndDate addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
        
        [endField setInputView:datePickerEndDate];
        
    }
    else if (selectedTextField == endField)
    {
        // Date string vullen met endField datum
        theNewDateString = [outputFormatter stringFromDate:datePickerEndDate.date];
        
        activity.end = datePickerEndDate.date;
    }
    
    // Datum weergeven in tekstveld
    selectedTextField.text = theNewDateString;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"toVoorbeeld"]) {       
        
        ToevoegenVoorbeeldViewController *vc = [segue destinationViewController];
        vc.activity = activity;
    }
}

@end
