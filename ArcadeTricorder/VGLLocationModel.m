//
//  LocationModel.m
//  ArcadeTricorder
//
//  Created by Jim DiZoglio on 2/28/15.
//  Copyright (c) 2015 Jim DiZoglio. All rights reserved.
//

#import "VGLLocationModel.h"
#import "VGLData.h"
#import "VGLAccountModel.h"

@implementation VGLLocationModel

+ (VGLLocationModel *)instance {
    
    static VGLLocationModel *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _sharedClient = [VGLLocationModel alloc];
    });
    
    return _sharedClient;
}

- (void)postLocation:(void (^)(BOOL success, NSString *errMessage))completion withLocationName:(NSString *)name withNotes:(NSString *)notes withLat:(float)lat withLong:(float)lng andWithHUD:(MBProgressHUD *)hud; {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        //[hud setProgress:45.00/360.00];
        
        NSDictionary *params = @{@"locationName" : name, @"notes" : notes, @"latitude" : [NSNumber numberWithFloat:lat], @"longitude" : [NSNumber numberWithFloat:lng] };
        
        NSString *path = [NSString stringWithFormat:@"%@://%@/locations", VGLData.kapi_protocol, VGLData.kapi_domain];
        
        NSLog(@"Path: %@", path);
        
        NSDictionary *result;
        @try {
            
            result = [VGLData dictionaryWithContentsOfURL:[NSURL URLWithString:path] methodName:@"POST" stringParameters:params];
        }
        @catch (NSException *exception) {
            
            NSLog(@"Downloading messages failed with error = %@", exception.description);
            // Complete
            dispatch_async(dispatch_get_main_queue(), ^{
                
                completion(NO, exception.description);
            });
            return;
        }
        
        //[hud setProgress:180.00/360.00];
        
        NSLog(@"user result: %@", result);
        
        //[hud setProgress:270.00/360.00];
        
        // Complete
        dispatch_async(dispatch_get_main_queue(), ^{
            
            completion(YES, nil);
        });
    });
}

- (void)getLocations:(void (^)(BOOL success, NSString *errMessage))completion andWithHUD:(MBProgressHUD *)hud {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [hud setProgress:45.00/360.00];
        
        NSString *path = [NSString stringWithFormat:@"%@://%@/locations", VGLData.kapi_protocol, VGLData.kapi_domain];
        
        NSLog(@"Path: %@", path);
        
        NSMutableDictionary *params  = [NSMutableDictionary new];
        NSString *merchantId = [[VGLAccountModel instance] getCurrentUsersMerchatId];
        if (merchantId == nil) {
            
            NSString *localMID = [[NSUserDefaults standardUserDefaults] objectForKey:@"users_merchantId"];
            [params setValue:localMID forKey:@"merchantId"];
        }
        else {
            
            [params setValue:merchantId forKey:@"merchantId"];
        }
        
        NSArray *result;
        @try {
            
            result = [VGLData arrayWithContentsOfURL:[NSURL URLWithString:path] methodName:@"GET" stringParameters:params];
        }
        @catch (NSException *exception) {
            
            NSLog(@"Downloading messages failed with error = %@", exception.description);
            // Complete
            dispatch_async(dispatch_get_main_queue(), ^{
                
                completion(NO, @"Downloading Locations Failed");
            });
            return;
        }
        
        NSLog(@"Locations: %@", result);
        
        [hud setProgress:180.00/360.00];
        
        NSMutableArray *newLocations = [NSMutableArray new];
        for (NSDictionary *location in result) {
            
            NSLog(@"location = %@", location);
            VGLLocation *locationParsed = [VGLLocation parse:location];
            [newLocations addObject:locationParsed];
        }
        
        _locations = [newLocations copy];
        
        [hud setProgress:270.00/360.00];
        
        // Complete
        dispatch_async(dispatch_get_main_queue(), ^{
            
            completion(YES, nil);
        });
    });
}

@end
