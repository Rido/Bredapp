//
//  IsIphone5.h
//  Breda_Inladen
//
//  Created by Rick Doorakkers on 28-09-12.
//  Copyright (c) 2012 Avans_Groep2. All rights reserved.
//

#ifndef IsIphone5_h
#define IsIphone5_h

#define isPhone568 ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && [UIScreen mainScreen].bounds.size.height == 568)
#define iPhone568ImageNamed(image) (isPhone568 ? [NSString stringWithFormat:@"%@-568h", image] : image)
#define iPhone568Image(image) ([UIImage imageNamed:iPhone568ImageNamed(image)])

#endif
