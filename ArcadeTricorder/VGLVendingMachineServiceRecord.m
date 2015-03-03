//
//  VGLVendingMachineServiceRecord.m
//  ArcadeTricorder
//
//  Created by Thomas DiZoglio on 2/28/15.
//  Copyright (c) 2015 Jim DiZoglio. All rights reserved.
//

#import "VGLVendingMachineServiceRecord.h"

@implementation VGLVendingMachineServiceRecord

+ (instancetype) parse:(NSDictionary *)fields {
    
    NSLog(@"fields = %@", fields);
    VGLVendingMachineServiceRecord *servicerecord = [VGLVendingMachineServiceRecord new];
    
    servicerecord.merchantID = fields[@"merchantID"];
    servicerecord.serviceTime = [fields[@"serviceTime"] integerValue];
    servicerecord.serialNumber = fields[@"serialNumber"];
    servicerecord.photoTaken = [fields[@"photoTaken"] integerValue];
    servicerecord.serviceNotes = fields[@"serviceNotes"];
    servicerecord.ticketsAdded = [fields[@"ticketsAdded"] integerValue];
    servicerecord.ticketsRedeemed = [fields[@"ticketsRedeemed"] integerValue];
    servicerecord.ticketsDispensed = [fields[@"ticketsDispensed"] integerValue];
    servicerecord.dailyHighScore = [fields[@"dailyHighScore"] integerValue];
    servicerecord.numberOfGamesPlayed = [fields[@"numberOfGamesPlayed"] integerValue];
    servicerecord.gameMode = fields[@"gameMode"];
    servicerecord.lightConfiguration = [fields[@"lightConfiguration"] integerValue];
    servicerecord.creditsAdded = [fields[@"creditsAdded"] integerValue];
    servicerecord.lastScore = [fields[@"lastScore"] integerValue];
    
    return servicerecord;
}

@end
