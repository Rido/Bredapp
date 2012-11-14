//
//  ImageCache.h
//  T&S Zeeland
//
//  Created by Rick Doorakkers on 10-11-12.
//  Copyright (c) 2012 Tim_Online. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageCache : NSObject

@property (nonatomic, retain) NSCache *imgCache;


#pragma mark - Methods

+ (ImageCache*)sharedImageCache;
- (void) AddImage:(NSString *)imageURL: (UIImage *)image;
- (UIImage*) GetImage:(NSString *)imageURL;
- (BOOL) DoesExist:(NSString *)imageURL;

@end