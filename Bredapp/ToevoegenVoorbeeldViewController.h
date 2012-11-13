//
//  ToevoegenVoorbeeldViewController.h
//  Bredapp
//
//  Created by Rick Artz on 11/8/12.
//  Copyright (c) 2012 Avans_Groep2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Category.h"
#import "Activity.h"

@interface ToevoegenVoorbeeldViewController : UIViewController

@property (retain, nonatomic) IBOutlet UILabel *titleLabel;
@property (retain, nonatomic) IBOutlet UITextView *datetimeTextView;
@property (retain, nonatomic) IBOutlet UITextView *whereTextView;
@property (retain, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (retain, nonatomic) IBOutlet UIImageView *activityImage;

@property (strong, nonatomic) Activity *activity;
@property (strong, nonatomic) Category *category;

@end
