//
//  WhenScreenViewController.h
//  WhenScreenTest
//
//  Created by Lars van Beek on 10/30/12.
//  Copyright (c) 2012 com.wecreatepixels. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WhenScreenViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *beginField;
@property (strong, nonatomic) IBOutlet UITextField *endField;

@property (nonatomic, retain) UIDatePicker *datePicker;

@property (strong, nonatomic) UITextField *selectedTextField;

@property (nonatomic, retain) NSString *databaseDateFormat;

@end
