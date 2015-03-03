//
//  VGLAddLocationViewController.h
//  ArcadeTricorder
//
//  Created by Jim DiZoglio on 2/28/15.
//  Copyright (c) 2015 Jim DiZoglio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VGLLocationModel.h"

@protocol VGLAddLocationViewControllerDelegate <NSObject>

- (void) storeLocationAdded:(VGLLocationModel*) newStoreLocation;

@end

@interface VGLAddLocationViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextView *notes;

@property (weak, nonatomic) id <VGLAddLocationViewControllerDelegate> delegate;

- (IBAction)addStoreLocation:(id)sender;

@end
