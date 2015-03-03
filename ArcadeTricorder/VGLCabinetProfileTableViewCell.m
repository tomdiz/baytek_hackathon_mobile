//
//  VGLCabinetProfile.m
//  ArcadeTricorder
//
//  Created by Jim DiZoglio on 2/28/15.
//  Copyright (c) 2015 Jim DiZoglio. All rights reserved.
//

#import "VGLCabinetProfileTableViewCell.h"
#import "VGLVendingMachineServiceRecordModel.h"
#import "VGLAccountModel.h"
#import "MBProgressHUD.h"

@interface VGLCabinetProfileTableViewCell ()

@property (nonatomic, strong) NSMutableArray *pickerMachineKiddieData;
@property (nonatomic, strong) NSMutableArray *pickerMachineAlleyBowlerData;
@property (nonatomic, strong) NSMutableArray *pickerMachineMerchandizerData;
@property (nonatomic, strong) NSMutableArray *pickerMachinePlayValueData;
@property (nonatomic, strong) NSMutableArray *pickerMachineBarPiecesData;
@property (nonatomic, strong) NSMutableArray *pickerMachineQuickPlayData;
@property (nonatomic, strong) NSMutableArray *pickerMachinePrizeHubData;
@property (nonatomic, strong) NSMutableArray *pickerMachineVideoRedemptionData;

@end

@implementation VGLCabinetProfileTableViewCell


- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self.delegate didBeginTextEdit:textField.tag];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self.delegate didEndTextEdit:textField.tag];
}

- (NSMutableArray *)getMachinesNames:(NSString *)machineType {
    if ([machineType isEqualToString:@"Alley Bowlers"]) {
        return [[NSMutableArray alloc] initWithArray:@[@"The Grand Fun Alley", @"Goal Rush", @"Fireball Fury", @"Alley Ooop", @"Chameleon Paradize"]];
    }
    else if ([machineType isEqualToString:@"Kiddie Games"]) {
        return [[NSMutableArray alloc] initWithArray:@[@"Beach Bounce", @"Arctic Chomp", @"Pig Out", @"Swish", @"Chameleon Paradize"]];
    }
    else if ([machineType isEqualToString:@"Merchandisers"]) {
        return [[NSMutableArray alloc] initWithArray:@[@"Road Trip", @"Bike Rally"]];
    }
    else if ([machineType isEqualToString:@"Pay Value"]) {
        return [[NSMutableArray alloc] initWithArray:@[@"Sink It", @"Connect 4", @"Connect 4 - Deluxe", @"Cannonball Blast", @"Horse Play"]];
    }
    else if ([machineType isEqualToString:@"Bar Pieces"]) {
        return [[NSMutableArray alloc] initWithArray:@[@"Beer Pong", @"Beer Ball"]];
    }
    else if ([machineType isEqualToString:@"Quick Play"]) {
        return [[NSMutableArray alloc] initWithArray:@[@"Full Tilt", @"Ticket Monster", @"Dissy Chicken", @"Crank It Revolution", @"Crank It", @"Big Bass Wheel"]];
    }
    else if ([machineType isEqualToString:@"Prize Hub"]) {
        return [[NSMutableArray alloc] initWithArray:@[@"Prize Hub", @"Evolve"]];
    }
    else if ([machineType isEqualToString:@"Video Redemption"]) {
        return [[NSMutableArray alloc] initWithArray:@[@"Hopstar", @"Flappy Bird"]];
    }
    return nil;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.superview animated:NO];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.labelText = @"Posting Vender Service Record...";
    hud.dimBackground = YES;
    [hud setProgress:12.0/360.0];

    NSString *merchantId = [[VGLAccountModel instance] getCurrentUsersMerchatId];
    if (merchantId == nil) {
        
        merchantId = [[NSUserDefaults standardUserDefaults] objectForKey:@"users_merchantId"];
    }
    
    [[VGLVendingMachineServiceRecordModel instance] postVendingMachineServiceRecord:^(BOOL success, NSString *errMessage){
        
        [MBProgressHUD hideAllHUDsForView:self.superview animated:YES];

        if (!success) {
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Posting Vender Service Record Error"
                                                                message:errMessage
                                                               delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
            [alertView show];
        }
        
    }  withMerchantId:merchantId
        withTime:[[NSDate date] timeIntervalSince1970]
        withServerNum:self.serialNumber.text
        withPhotoTaken:0
        withNotes:@"Stadard Service check"
        withTixAdded:40
        withTixRedeemed:10
        withTixDispensed:0
        withDailyHighScore:200000
        withGamesPlayed:60
        withGameMode:@"attact mode"
        withLightConfig:2
        withCreditsAdded:4
        withLastScore:5000
        andWithHUD:hud
     ];
}

@end
