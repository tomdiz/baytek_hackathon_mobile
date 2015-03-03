//
//  VGLCabinetProfile.h
//  ArcadeTricorder
//
//  Created by Jim DiZoglio on 2/28/15.
//  Copyright (c) 2015 Jim DiZoglio. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VGLCabinetProfileTableViewCellDelegate <NSObject>

- (void)didBeginTextEdit:(NSInteger)tag;
- (void)didEndTextEdit:(NSInteger)tag;

@end

@interface VGLCabinetProfileTableViewCell : UITableViewCell <UITextFieldDelegate>

@property (nonatomic, strong) IBOutlet UITextField *serialNumber;
@property (nonatomic, strong) IBOutlet UITextField *machineType;
@property (nonatomic, strong) IBOutlet UITextField *objectName;
@property (nonatomic, strong) IBOutlet UITextField *machineID;

@property (nonatomic, weak) id <VGLCabinetProfileTableViewCellDelegate> delegate;

- (NSMutableArray *)getMachinesNames:(NSString *)machineType;

@end
