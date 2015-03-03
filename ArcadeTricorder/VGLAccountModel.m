//
//  VGLAccountModel.m
//  ArcadeTricorder
//
//  Created by Jim DiZoglio on 2/28/15.
//  Copyright (c) 2015 Jim DiZoglio. All rights reserved.
//

#import "VGLAccountModel.h"
#import "VGLData.h"

@implementation VGLAccountModel

+ (VGLAccountModel *)instance {
    
    static VGLAccountModel *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _sharedClient = [VGLAccountModel alloc];
    });
    
    return _sharedClient;
}

- (NSString *)getCurrentUsersMerchatId {
    
    return _merchantID;
}

- (void)createUserProfile:(void (^)(BOOL success, NSString *errMessage))completion withCompany:(NSString *)company withPhone:(NSString *)phone andWithHUD:(MBProgressHUD *)hud {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [hud setProgress:45.00/360.00];
        
        NSDictionary *params = @{@"company" : company, @"phone" : phone };
        
        NSString *path = [NSString stringWithFormat:@"%@://%@/users", VGLData.kapi_protocol, VGLData.kapi_domain];
        
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
        
        [hud setProgress:180.00/360.00];
        
        NSLog(@"user result: %@", result);
        
        // Check for error first
        NSString *merchantId = [result objectForKey:@"merchantID"];
        if (merchantId == nil) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                completion(NO, @"merchantId failed to be returned by server.");
            });
            return;
        }
        
        _merchantID = merchantId;
        
        [[NSUserDefaults standardUserDefaults] setObject:merchantId forKey:@"users_merchantId"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [hud setProgress:270.00/360.00];
        
        // Complete
        dispatch_async(dispatch_get_main_queue(), ^{
            
            completion(YES, nil);
        });
    });
}

@end
