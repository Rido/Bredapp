//
//  SplashViewController.h
//  Breda_Inladen
//
//  Created by Rick Doorakkers on 28-09-12.
//  Copyright (c) 2012 Avans_Groep2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SplashViewController : UIViewController

@property (nonatomic,strong) NSManagedObjectContext* managedObjectContext;
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) IBOutlet UILabel *statusLabel;

@end
