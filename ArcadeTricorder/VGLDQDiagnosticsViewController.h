//
//  ViewController.h
//  EmuBayTek
//
//  Created by Dario Fiumicello on 12/02/15.
//  Copyright (c) 2015 DQuid S.r.l. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DQBayTekRequestProtocol.h"
#import "DQBayTekResponseDelegate.h"

@interface VGLDQDiagnosticsViewController : UIViewController <DQBayTekResponseDelegate, UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) DQBayTekRequestProtocol* theBayTekRequestProtocol;
@property (nonatomic, assign) NSInteger mode;

@property (nonatomic, strong) IBOutlet UITableView* tableView;

@end

