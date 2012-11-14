//
//  CLLocation+Additions.m
//  
//
//  Created by Sergio on 13/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CLLocation+Geocodereverse.h"
#import "JSONKit.h"

@implementation CLLocation (Geocodereverse)

- (NSString *)forwardGeocodeWithLanguage:(NSString *)language
{
	NSString *gUrl = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?latlng=%.10f,%.10f&language=%@&sensor=false", self.coordinate.latitude, self.coordinate.longitude, language];

    gUrl = [gUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
	NSString *infoData = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:gUrl] 
                                                        encoding:NSUTF8StringEncoding
                                                           error:nil];
	
	NSString *value = @"";
	
	if ((infoData == nil) || 
		([infoData isEqualToString:@"[]"])) 
	{
		return value;
	} 
	else 
	{
		NSDictionary *jsonObject = [infoData objectFromJSONString]; 
		
        if (jsonObject == nil)
            return @"";
        
		NSDictionary *dict = [(NSDictionary *)jsonObject objectForKey:@"results"];

		for (id key in dict)
		{
			value = [NSString stringWithFormat:@"%@", [key objectForKey:@"formatted_address"]];
			break;
		}
	}	
	
	return value;
}

@end