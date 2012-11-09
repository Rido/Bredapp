//
//  CustomNavBar.m
//  Bredapp
//
//  Created by Rick Doorakkers on 09-11-12.
//  Copyright (c) 2012 Avans_Groep2. All rights reserved.
//

#import "CustomNavBar.h"

@implementation CustomNavBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    UIImage *image = [UIImage imageNamed:@"navbar.png"];
    [image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}

@end
