//
//  VGLAccountModel.h
//  ArcadeTricorder
//
//  Created by Jim DiZoglio on 2/28/15.
//  Copyright (c) 2015 Jim DiZoglio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface VGLAccountModel : NSObject

@property (nonatomic, strong) NSString *merchantID;
@property (nonatomic, strong) NSString *merchantName;

+ (VGLAccountModel *)instance;

- (NSString *)getCurrentUsersMerchatId;

- (void)createUserProfile:(void (^)(BOOL success, NSString *errMessage))completion withCompany:(NSString *)company withPhone:(NSString *)phone andWithHUD:(MBProgressHUD *)hud;

@end
