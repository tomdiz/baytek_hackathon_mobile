//
//  VGLLocation.h
//  ArcadeTricorder
//
//  Created by Thomas DiZoglio on 2/28/15.
//  Copyright (c) 2015 Jim DiZoglio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface VGLLocation : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *notes;
@property (nonatomic, strong) NSString *merchantId;
@property (assign) CLLocationCoordinate2D location;

+ (instancetype) parse:(NSDictionary *)fields;

@end
