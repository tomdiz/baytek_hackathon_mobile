//
//  DetailCellView.h
//  EmuBayTek
//
//  Created by Dario Fiumicello on 07/10/14.
//  Copyright (c) 2014 DQuid S.r.l. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DQBayTekRequestProtocol.h"

@interface TextFieldCellView : UITableViewCell <UITextFieldDelegate>

@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UITextField *textField;

@property (nonatomic,strong) NSMutableDictionary* cellData;
@property (nonatomic,strong) DQBayTekRequestProtocol* protocol;

-(void) initializeWithCellData:(NSMutableDictionary*)aCellData andBayTekRequestProtocol:(DQBayTekRequestProtocol*) aProtocol;

@end
