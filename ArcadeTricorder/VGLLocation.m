//
//  VGLLocation.m
//  ArcadeTricorder
//
//  Created by Thomas DiZoglio on 2/28/15.
//  Copyright (c) 2015 Jim DiZoglio. All rights reserved.
//

#import "VGLLocation.h"

@implementation VGLLocation

+ (instancetype) parse:(NSDictionary *)fields {
    
    NSLog(@"fields = %@", fields);
    VGLLocation *location = [VGLLocation new];

    location.name = fields[@"locationName"];
    location.notes = fields[@"notes"];
    location.merchantId = fields[@"merchantId"];
    float latitude = [fields[@"latitude"] floatValue];
    float longitude = [fields[@"longitude"] floatValue];
    location.location = CLLocationCoordinate2DMake(latitude, longitude);
    
    return location;
}

@end
