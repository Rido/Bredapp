//
//  ToevoegenWanneerViewController.h
//  Bredapp
//
//  Created by Leroy Meijer on 11/8/12.
//  Copyright (c) 2012 Avans_Groep2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Activity.h"
#import "Category.h"

@interface ToevoegenWanneerViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *beginField;
@property (strong, nonatomic) IBOutlet UITextField *endField;
@property (nonatomic, retain) UIDatePicker *datePicker;

@property (strong, nonatomic) UITextField *selectedTextField;

@property (nonatomic, retain) NSString *databaseDateFormat;

@property (strong, nonatomic) Activity *activity;

@end
