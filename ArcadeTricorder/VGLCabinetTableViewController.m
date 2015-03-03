//
//  VGLCabinetTableViewController.m
//  ArcadeTricorder
//
//  Created by Jim DiZoglio on 2/28/15.
//  Copyright (c) 2015 Jim DiZoglio. All rights reserved.
//

#import "VGLCabinetTableViewController.h"
#import "VGLCabinetProfileTableViewCell.h"
#import "VGLCabinetDiagnosticsTableViewCell.h"
#import "VGLCabinetServiceTableViewCell.h"
#import "VGLDQDiagnosticsViewController.h"
#import "TableCellsRegistry.h"

@interface VGLCabinetTableViewController () <UIPickerViewDataSource, UIPickerViewDelegate, VGLCabinetProfileTableViewCellDelegate>

@property (nonatomic, strong) IBOutlet UIPickerView *picker;
@property (nonatomic, strong) NSMutableArray *pickerMachineTypeData;
@property (nonatomic, strong) NSMutableArray *pickerMachineNameData;
@property (nonatomic, strong) NSMutableArray *pickerMachinePickerData;

@property (nonatomic, strong) NSString *selectedMachineInfo;
@property (nonatomic, assign) NSInteger machineTag;

@end

@implementation VGLCabinetTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // Initialize Data
    self.pickerMachineTypeData = [[NSMutableArray alloc] initWithArray:@[@"Alley Bowlers", @"Kiddie Games", @"Merchandisers", @"Pay Value", @"Bar Pieces", @"Quick Play", @"Prize Hub", @"Video Redemption"]];
    
    self.picker.showsSelectionIndicator = YES;
    self.picker.dataSource = self;
    self.picker.delegate = self;
    [self.picker setHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        VGLCabinetProfileTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VGLCabinetProfileTableViewCell"];
//        VGLLocationModel *storeInfo = [self.storeLocationsArray objectAtIndex:indexPath.row];
//        [cell.storeName setText:storeInfo.name];
        
        if (self.machineTag == 200) {
            cell.machineType.text = self.selectedMachineInfo;
        }
        else if (self.machineTag == 201) {
            cell.objectName.text = self.selectedMachineInfo;
        }
        self.pickerMachineNameData = [cell getMachinesNames:cell.machineType.text];
        cell.machineType.delegate = cell;
        cell.objectName.delegate = cell;
        cell.serialNumber.delegate = cell;
        cell.machineID.delegate = cell;
        cell.delegate = self;
        
        return cell;
    }
    else if (indexPath.section == 1) {
        VGLCabinetDiagnosticsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VGLCabinetDiagnosticsTableViewCell"];
        
        return cell;
    }
    else {
        VGLCabinetServiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VGLCabinetServiceTableViewCell"];
        
        return cell;
    }
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"VGLShowStatisticsSegue"]) {
        VGLDQDiagnosticsViewController *vc = [segue destinationViewController];
        vc.mode = kDQModeStatistics;
    }
    else if ([[segue identifier] isEqualToString:@"VGLShowDiagnosticsSegue"]) {
        VGLDQDiagnosticsViewController *vc = [segue destinationViewController];
        vc.mode = kDQModeDiagnostics;
    }
    
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.pickerMachinePickerData.count;
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *yourSelectedTitle = [self.pickerMachinePickerData objectAtIndex:[self.picker selectedRowInComponent:0]];
    NSLog(@"Picked value: %@", yourSelectedTitle);
    self.selectedMachineInfo = yourSelectedTitle;
    [self.tableView reloadData];
    
    return self.pickerMachinePickerData[row];
}

- (void)didBeginTextEdit:(NSInteger)tag {
    
    self.machineTag = tag;
    if (tag == 200) {
        self.pickerMachinePickerData = self.pickerMachineTypeData;
    }
    else if (tag == 201) {
        self.pickerMachinePickerData = self.pickerMachineNameData;
    }
    
    [self.picker setHidden:NO];
    [self.picker reloadAllComponents];
    //[self.tableView reloadData];
}

- (void)didEndTextEdit:(NSInteger)tag {
    if ((tag != 200) && (tag != 201)) {
        self.pickerMachinePickerData = nil;
        [self.picker setHidden:YES];
        [self.tableView reloadData];
    }
}

@end
