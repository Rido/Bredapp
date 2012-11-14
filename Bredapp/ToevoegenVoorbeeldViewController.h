//
//  ToevoegenVoorbeeldViewController.h
//  Bredapp
//
//  Created by Rick Artz on 11/8/12.
//  Copyright (c) 2012 Avans_Groep2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Category.h"
#import "Activity.h"
#import "TempActivity.h"
#import "FileUploadEngine.h"
#import "MBProgressHUD.h"

@interface ToevoegenVoorbeeldViewController : UIViewController <MBProgressHUDDelegate>
{
    MBProgressHUD *HUD;
}

@property (nonatomic, strong) AppDelegate *myApp;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@property (retain, nonatomic) IBOutlet UILabel *titleLabel;
@property (retain, nonatomic) IBOutlet UITextView *datetimeTextView;
@property (retain, nonatomic) IBOutlet UITextView *whereTextView;
@property (retain, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (retain, nonatomic) IBOutlet UIImageView *activityImage;

@property (strong, nonatomic) TempActivity *activity;
@property (strong, nonatomic) Category *category;

@property (strong, nonatomic) FileUploadEngine *flUploadEngine;
@property (strong, nonatomic) MKNetworkOperation *flOperation;

@end
