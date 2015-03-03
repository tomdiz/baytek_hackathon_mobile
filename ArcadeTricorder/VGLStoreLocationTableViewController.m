//
//  VGLStoreLocationTableViewController.m
//  ArcadeTricorder
//
//  Created by Jim DiZoglio on 2/28/15.
//  Copyright (c) 2015 Jim DiZoglio. All rights reserved.
//

#import "VGLStoreLocationTableViewController.h"
#import "VGLAddLocationViewController.h"
#import "VGLInventoryTableViewController.h"
#import "MBProgressHUD.h"
#import "VGLStoreLocationTableViewCell.h"
#import "VGLLocationModel.h"

@interface VGLStoreLocationTableViewController () <VGLAddLocationViewControllerDelegate>

@property (nonatomic, strong) NSArray *storeLocationsArray;

@end

@implementation VGLStoreLocationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:NO];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.labelText = @"Getting Locations...";
    hud.dimBackground = YES;
    [hud setProgress:12.0/360.0];
    
    [[VGLLocationModel instance] getLocations:^(BOOL success, NSString *errMessage){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        if (!success) {
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Getting Locations Error"
                                                                message:errMessage
                                                               delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
            [alertView show];
        }
        else {
            
            self.storeLocationsArray = [[VGLLocationModel instance] locations];
            [self.tableView reloadData];
        }
        
    } andWithHUD:hud];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.storeLocationsArray count];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"VGLAddStoreSegue"]) {
        VGLAddLocationViewController *vc = [segue destinationViewController];
        vc.delegate = self;
    }
    else if ([[segue identifier] isEqualToString:@"VGLViewStoreInformationSegue"]) {
        VGLInventoryTableViewController *vc = [segue destinationViewController];
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        vc.storeInfo = [self.storeLocationsArray objectAtIndex:indexPath.row];
    }
}

- (void) storeLocationAdded:(VGLLocationModel*) newStoreLocation {
//    [self.storeLocationsArray addObject:newStoreLocation];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self.storeLocationsArray count]-1 inSection:1];
    [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition: UITableViewScrollPositionNone];
    
    [self performSegueWithIdentifier:@"VGLViewStoreInformationSegue" sender:self];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VGLStoreLocationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VGLStoreLocationTableViewCell"];
    
    VGLLocation *storeInfo = [self.storeLocationsArray objectAtIndex:indexPath.row];
    [cell.storeName setText:storeInfo.name];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
