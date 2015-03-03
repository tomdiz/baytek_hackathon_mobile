//
//  VGLCabinetModel.h
//  ArcadeTricorder
//
//  Created by Jim DiZoglio on 2/28/15.
//  Copyright (c) 2015 Jim DiZoglio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VGLCabinetModel : NSObject

// Machine connection information
@property (nonatomic, strong) NSString *serialNumber;
@property (nonatomic, strong) NSString *machineType;
@property (nonatomic, strong) NSString *objectName;
@property (nonatomic, strong) NSString *machineID;
@property (nonatomic, strong) NSString *notes;

// Cabinet Information
@property (assign) NSInteger gameMinorVersion;
@property (assign) NSInteger gameMajorVersion;
@property (assign) NSInteger embeddedAuxBoardMinor;
@property (assign) NSInteger embeddedAuxBoardMajor;

// Machine service information
@property (assign) NSInteger numberPhotos;
@property (assign) NSInteger lastScore;
@property (assign) NSInteger currentLightConfiguration;
@property (assign) NSInteger currentGameMode;
@property (assign) NSInteger currentCredits;
@property (assign) NSInteger numberGamesPlayed;
@property (assign) NSInteger totalNumberTicketsAdded;
@property (assign) NSInteger totalNumberTicketsRedeemed;
@property (assign) NSInteger totalNumberTicketsPrinted;
@property (assign) NSInteger totalNumberSuccessVends;
@property (assign) NSInteger totalNumberErrorVends;
@property (assign) NSInteger numberVendRows;

// Service information
@property (nonatomic, strong) NSString *lastServiceDate;
@property (nonatomic, strong) NSString *status;

@end
