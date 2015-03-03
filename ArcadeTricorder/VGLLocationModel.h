//
//  LocationModel.h
//  ArcadeTricorder
//
//  Created by Jim DiZoglio on 2/28/15.
//  Copyright (c) 2015 Jim DiZoglio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"
#import "VGLLocation.h"

@interface VGLLocationModel : NSObject

@property (nonatomic, strong) NSArray *locations;

+ (VGLLocationModel *)instance;

- (void)postLocation:(void (^)(BOOL success, NSString *errMessage))completion withLocationName:(NSString *)name withNotes:(NSString *)notes withLat:(float)lat withLong:(float)lng andWithHUD:(MBProgressHUD *)hud;
- (void)getLocations:(void (^)(BOOL success, NSString *errMessage))completion andWithHUD:(MBProgressHUD *)hud;

@end