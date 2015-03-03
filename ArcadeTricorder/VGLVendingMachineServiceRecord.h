//
//  VGLVendingMachineServiceRecord.h
//  ArcadeTricorder
//
//  Created by Thomas DiZoglio on 2/28/15.
//  Copyright (c) 2015 Jim DiZoglio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VGLVendingMachineServiceRecord : NSObject

@property (nonatomic, strong) NSString *merchantID;
@property (assign) NSInteger serviceTime;
@property (nonatomic, strong) NSString *serialNumber;
@property (assign) NSInteger photoTaken;
@property (nonatomic, strong) NSString *serviceNotes;
@property (assign) NSInteger ticketsAdded;
@property (assign) NSInteger ticketsRedeemed;
@property (assign) NSInteger ticketsDispensed;
@property (assign) NSInteger dailyHighScore;
@property (assign) NSInteger numberOfGamesPlayed;
@property (nonatomic, strong) NSString *gameMode;
@property (assign) NSInteger lightConfiguration;
@property (assign) NSInteger creditsAdded;
@property (assign) NSInteger lastScore;

+ (instancetype) parse:(NSDictionary *)fields;

@end
