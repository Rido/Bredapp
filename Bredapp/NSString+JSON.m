//
//  NSString+JSON.m
//  
//
//  Created by Sergio on 22/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "NSString+JSON.h"

@implementation NSString (JSON)

- (CLLocation *)newGeocodeAddress
{
    CLLocation *location = nil;

	NSString *gUrl = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?address=%@&sensor=false", self];
	gUrl = [gUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

	NSString *infoData = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:gUrl] 
														 encoding:NSUTF8StringEncoding 
															error:nil];
    
	if ((infoData == nil) || 
		([infoData isEqualToString:@"[]"])) 
	{
		return location;
	} 
	else 
	{
		
		NSDictionary *jsonObject = [infoData objectFromJSONString]; 
        
        if (jsonObject == nil)
            return nil;
        
		NSDictionary *dict = [(NSDictionary *)jsonObject objectForKey:@"results"];
		
		for (id key in dict)
		{
			NSDictionary *value = [[key objectForKey:@"geometry"] valueForKey:@"location"];

			location = [[CLLocation alloc] initWithLatitude:[[value valueForKey:@"lat"] doubleValue]
												  longitude:[[value valueForKey:@"lng"] doubleValue]];
			break;
		}
	}	
	
	return location;
}

@end
