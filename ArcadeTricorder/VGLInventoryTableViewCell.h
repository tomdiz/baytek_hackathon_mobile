//
//  VGLInventoryTableViewCell.h
//  ArcadeTricorder
//
//  Created by Jim DiZoglio on 2/28/15.
//  Copyright (c) 2015 Jim DiZoglio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VGLInventoryTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *machineName;
@property (weak, nonatomic) IBOutlet UIImageView *gameImage;
@property (weak, nonatomic) IBOutlet UILabel *machineStatus;
@property (weak, nonatomic) IBOutlet UILabel *lastServiceDate;

@end
