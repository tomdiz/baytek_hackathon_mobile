//
//  VGLVendingMachineServiceRecordModel.h
//  ArcadeTricorder
//
//  Created by Thomas DiZoglio on 3/1/15.
//  Copyright (c) 2015 Jim DiZoglio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface VGLVendingMachineServiceRecordModel : NSObject

@property (nonatomic, strong) NSArray *venderServiceRecords;

+ (VGLVendingMachineServiceRecordModel *)instance;

- (void)postVendingMachineServiceRecord:(void (^)(BOOL success, NSString *errMessage))completion withMerchantId:(NSString *)name withTime:(NSInteger)time withServerNum:(NSString *)serNum withPhotoTaken:(NSInteger)taken withNotes:(NSString *)notes withTixAdded:(NSInteger)ticketsAdded withTixRedeemed:(NSInteger)ticketsRedeemed withTixDispensed:(NSInteger)ticketsDispensed withDailyHighScore:(NSInteger)dailyHighScore withGamesPlayed:(NSInteger)gamesPlayed withGameMode:(NSString *)mode withLightConfig:(NSInteger)lightconfig withCreditsAdded:(NSInteger)creditsAdded withLastScore:(NSInteger)lastScore andWithHUD:(MBProgressHUD *)hud;

- (void)getVendingMachineServiceRecords:(void (^)(BOOL success, NSString *errMessage))completion andWithHUD:(MBProgressHUD *)hud;

@end
