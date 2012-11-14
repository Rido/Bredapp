//
//  FileUploadEngine.m
//  Bredapp
//
//  Created by Rick Doorakkers on 14-11-12.
//  Copyright (c) 2012 Avans_Groep2. All rights reserved.
//

#import "FileUploadEngine.h"

@implementation FileUploadEngine

-(MKNetworkOperation *) postDataToServer:(NSMutableDictionary *)params path:(NSString *)path {
    
    MKNetworkOperation *op = [self operationWithPath:path
                                              params:params
                                          httpMethod:@"POST"
                                                 ssl:NO];
    return op;
}

@end
