//
//  DetailActivityViewController.h
//  Bredapp
//
//  Created by Rick Artz on 11/7/12.
//  Copyright (c) 2012 Avans_Groep2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Activity.h"

@interface DetailActivityViewController : UIViewController

@property (nonatomic, strong) Activity *activity;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UITextView *contentLabel;
@property (strong, nonatomic) IBOutlet UITextView *startLabel;
@property (strong, nonatomic) IBOutlet UITextView *adresLabel;
@property (strong, nonatomic) IBOutlet UITextView *endLabel;

@end
