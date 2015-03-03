//
//  VGLVendingMachineServiceRecordModel.m
//  ArcadeTricorder
//
//  Created by Thomas DiZoglio on 3/1/15.
//  Copyright (c) 2015 Jim DiZoglio. All rights reserved.
//

#import "VGLVendingMachineServiceRecordModel.h"
#import "VGLVendingMachineServiceRecord.h"
#import "VGLAccountModel.h"
#import "VGLData.h"

@implementation VGLVendingMachineServiceRecordModel

+ (VGLVendingMachineServiceRecordModel *)instance {
    
    static VGLVendingMachineServiceRecordModel *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _sharedClient = [VGLVendingMachineServiceRecordModel alloc];
    });
    
    return _sharedClient;
}

- (void)postVendingMachineServiceRecord:(void (^)(BOOL success, NSString *errMessage))completion withMerchantId:(NSString *)name withTime:(NSInteger)time withServerNum:(NSString *)serNum withPhotoTaken:(NSInteger)taken withNotes:(NSString *)notes withTixAdded:(NSInteger)ticketsAdded withTixRedeemed:(NSInteger)ticketsRedeemed withTixDispensed:(NSInteger)ticketsDispensed withDailyHighScore:(NSInteger)dailyHighScore withGamesPlayed:(NSInteger)gamesPlayed withGameMode:(NSString *)mode withLightConfig:(NSInteger)lightconfig withCreditsAdded:(NSInteger)creditsAdded withLastScore:(NSInteger)lastScore andWithHUD:(MBProgressHUD *)hud {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [hud setProgress:45.00/360.00];

        NSDictionary *params = @{@"merchantID" : name, @"serviceTime" : [NSNumber numberWithInteger:time], @"serialNumber" : serNum, @"photoTaken" : [NSNumber numberWithInteger:taken], @"serviceNotes" : notes, @"ticketsAdded" : [NSNumber numberWithInteger:ticketsAdded], @"ticketsRedeemed" : [NSNumber numberWithInteger:ticketsRedeemed], @"ticketsDispensed" : [NSNumber numberWithInteger:ticketsDispensed], @"dailyHighScore" : [NSNumber numberWithInteger:dailyHighScore], @"numberOfGamesPlayed" : [NSNumber numberWithInteger:gamesPlayed], @"gameMode" : mode, @"lightConfiguration" : [NSNumber numberWithInteger:lightconfig], @"creditsAdded" : [NSNumber numberWithInteger:creditsAdded], @"lastScore" : [NSNumber numberWithInteger:lastScore] };
        
        NSString *path = [NSString stringWithFormat:@"%@://%@/vending_machine_service_records", VGLData.kapi_protocol, VGLData.kapi_domain];
        
        NSLog(@"Path: %@", path);
        
        NSDictionary *result;
        @try {
            
            result = [VGLData dictionaryWithContentsOfURL:[NSURL URLWithString:path] methodName:@"POST" stringParameters:params];
        }
        @catch (NSException *exception) {
            
            NSLog(@"Posting service record failed with error = %@", exception.description);
            // Complete
            dispatch_async(dispatch_get_main_queue(), ^{
                
                completion(NO, exception.description);
            });
            return;
        }
        
        [hud setProgress:180.00/360.00];
        
        NSLog(@"record result: %@", result);
        
        [hud setProgress:270.00/360.00];
        
        // Complete
        dispatch_async(dispatch_get_main_queue(), ^{
            
            completion(YES, nil);
        });
    });
}

- (void)getVendingMachineServiceRecords:(void (^)(BOOL success, NSString *errMessage))completion andWithHUD:(MBProgressHUD *)hud {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [hud setProgress:45.00/360.00];
        
        NSString *path = [NSString stringWithFormat:@"%@://%@/vendingmachineservicerecords", VGLData.kapi_protocol, VGLData.kapi_domain];
        
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
            
            NSLog(@"Downloading vender service records failed with error = %@", exception.description);
            // Complete
            dispatch_async(dispatch_get_main_queue(), ^{
                
                completion(NO, @"Downloading Locations Failed");
            });
            return;
        }
        
        NSLog(@"Vender serice records: %@", result);
        
        [hud setProgress:180.00/360.00];
        
        NSMutableArray *newServiceRecords = [NSMutableArray new];
        for (NSDictionary *record in result) {
            
            NSLog(@"record = %@", record);
            VGLVendingMachineServiceRecord *recordParsed = [VGLVendingMachineServiceRecord parse:record];
            [newServiceRecords addObject:recordParsed];
        }
        
        _venderServiceRecords = [newServiceRecords copy];
        
        [hud setProgress:270.00/360.00];
        
        // Complete
        dispatch_async(dispatch_get_main_queue(), ^{
            
            completion(YES, nil);
        });
    });
}

@end
