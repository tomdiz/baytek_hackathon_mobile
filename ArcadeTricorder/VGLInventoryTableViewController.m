//
//  VGLInventoryTableViewController.m
//  ArcadeTricorder
//
//  Created by Jim DiZoglio on 2/28/15.
//  Copyright (c) 2015 Jim DiZoglio. All rights reserved.
//

#import "VGLInventoryTableViewController.h"
#import "VGLCabinetModel.h"
#import "VGLInventoryTableViewCell.h"

@interface VGLInventoryTableViewController ()

@property (nonatomic, strong) NSMutableArray *cabinetsArray;

@end

@implementation VGLInventoryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self.navigationItem setTitle:self.storeInfo.name];
    
    
    self.cabinetsArray = [[NSMutableArray alloc] init];
    
    VGLCabinetModel *machineTest = [[VGLCabinetModel alloc] init];
    machineTest.serialNumber = @"1L080B50230";
    machineTest.machineID = @"REDMAN 0001";
    machineTest.machineType = @"Quick Play";
    machineTest.objectName = @"Ticket Monster";
    machineTest.lastServiceDate = @"2/15/2015";
    machineTest.status = @"Pass";
    [self.cabinetsArray addObject:machineTest];
    
    VGLCabinetModel *machineTest2 = [[VGLCabinetModel alloc] init];
    machineTest2.serialNumber = @"1B180H53230";
    machineTest2.machineID = @"REDMAN 0002";
    machineTest2.machineType = @"Quick Play";
    machineTest2.objectName = @"Ticket Monster";
    machineTest2.lastServiceDate = @"2/15/2015";
    machineTest2.status = @"Pass";
    [self.cabinetsArray addObject:machineTest2];
    
    VGLCabinetModel *machineTest3 = [[VGLCabinetModel alloc] init];
    machineTest3.serialNumber = @"1J080D22236";
    machineTest3.machineID = @"REDMAN 0003";
    machineTest3.machineType = @"Quick Play";
    machineTest3.objectName = @"Dizzy Chicken";
    machineTest3.lastServiceDate = @"2/10/2015";
    machineTest3.status = @"Fail";
    [self.cabinetsArray addObject:machineTest3];
    
    VGLCabinetModel *machineTest4 = [[VGLCabinetModel alloc] init];
    machineTest4.serialNumber = @"1C080C11111";
    machineTest4.machineID = @"REDMAN 0004";
    machineTest4.machineType = @"Prize Hub";
    machineTest4.objectName = @"Prize Hub";
    machineTest4.lastServiceDate = @"2/15/2015";
    machineTest4.status = @"Pass";
    [self.cabinetsArray addObject:machineTest4];
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

    return [self.cabinetsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VGLInventoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VGLInventoryTableViewCell"];
    
    VGLCabinetModel *cabinetInfo = [self.cabinetsArray objectAtIndex:indexPath.row];
    [cell.machineName setText:cabinetInfo.objectName];
    [cell.lastServiceDate setText:cabinetInfo.lastServiceDate];
    [cell.machineStatus setText:cabinetInfo.status];
    
    if ([cabinetInfo.objectName isEqualToString:@"Dizzy Chicken"]) {
        cell.gameImage.image = [UIImage imageNamed:@"GameDetailWeb_DizzyChicken.jpg"];
    }
    else if ([cabinetInfo.objectName isEqualToString:@"Ticket Monster"]) {
        cell.gameImage.image = [UIImage imageNamed:@"GameDetailWeb_TicketMonster.jpg"];
    }
    else if ([cabinetInfo.objectName isEqualToString:@"Prize Hub"]) {
        cell.gameImage.image = [UIImage imageNamed:@"GameDetailWeb_PHM.jpg"];
    }
    else if ([cabinetInfo.objectName isEqualToString:@"Pig Out"]) {
        cell.gameImage.image = [UIImage imageNamed:@"GameDetailWeb_PigOut.jpg"];
    }
    else if ([cabinetInfo.objectName isEqualToString:@"Sink It"]) {
        cell.gameImage.image = [UIImage imageNamed:@"GameDetailWeb_SinkIt_Combo.jpg"];
    }
    
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
