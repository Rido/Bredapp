//
//  FileUploadEngine.h
//  Bredapp
//
//  Created by Rick Doorakkers on 14-11-12.
//  Copyright (c) 2012 Avans_Groep2. All rights reserved.
//

#import "MKNetworkEngine.h"

@interface FileUploadEngine : MKNetworkEngine

-(MKNetworkOperation *) postDataToServer:(NSMutableDictionary *)params path:(NSString *)path;

@end
