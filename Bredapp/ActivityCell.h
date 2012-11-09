//
//  ActivityCell.h
//  Bredapp
//
//  Created by Rick Artz on 11/8/12.
//  Copyright (c) 2012 Avans_Groep2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UILabel *title;
@property (retain, nonatomic) IBOutlet UILabel *start;
@property (retain, nonatomic) IBOutlet UILabel *distance;
@property (retain, nonatomic) IBOutlet UIImageView *category;

@end
