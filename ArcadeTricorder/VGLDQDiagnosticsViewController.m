//
//  ViewController.m
//  EmuBayTek
//
//  Created by Dario Fiumicello on 12/02/15.
//  Copyright (c) 2015 DQuid S.r.l. All rights reserved.
//

#import "VGLDQDiagnosticsViewController.h"
#import "BayTekProtocol.h"
#import "TableCellsRegistry.h"
#import "TextFieldCellView.h"
#import "MBProgressHUD.h"
#import "DQObjectServerData.h"

@interface VGLDQDiagnosticsViewController ()

@property int theMachineID;

@end

@implementation VGLDQDiagnosticsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _theBayTekRequestProtocol = [[DQBayTekRequestProtocol alloc] initWithMachineID:(Byte)0 andDQuidIOSerialNumber:DQUIDIO_SERIAL_NUMBER andResponseDelegate:self];
    [_theBayTekRequestProtocol connect];
    
}

- (void) viewDidAppear:(BOOL)animated {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.detailsLabelText = [NSString stringWithFormat:@"Connecting to %@",DQUIDIO_SERIAL_NUMBER];
    [hud show:YES];
}

-(void) machineIDSelected:(id)sender {
    // Ugly hack for prizehub
    _theMachineID = 0;
    if (_theMachineID == 2) _theMachineID = PRIZE_HUB;
    [_theBayTekRequestProtocol setMachineID:_theMachineID];
    [_tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - DQBayTekResponseDelegate methods

-(void) onMachineIDReceived:(Byte) machineID {
    [DQObjectServerData postByteToDQuidServer:machineID propertyName:@"machineID" object:_theBayTekRequestProtocol.dqobject isRead:YES delegate:nil];
    
    [self machineIDSelected:0];
}

-(void) onMajGameVerReceived:(Byte) majVer {
    [DQObjectServerData postByteToDQuidServer:majVer propertyName:@"majGameVer" object:_theBayTekRequestProtocol.dqobject isRead:YES delegate:nil];
    UITableViewCell* cell = [[TableCellsRegistry instance] getCellForCallbackSelName:NSStringFromSelector(_cmd) mode:self.mode];
    [[cell detailTextLabel] setText:[NSString stringWithFormat:@"0x%02x",majVer]];
}

-(void) onMinGameVerReceived:(Byte) minVer {
    [DQObjectServerData postByteToDQuidServer:minVer propertyName:@"minGameVer" object:_theBayTekRequestProtocol.dqobject isRead:YES delegate:nil];
    UITableViewCell* cell = [[TableCellsRegistry instance] getCellForCallbackSelName:NSStringFromSelector(_cmd) mode:self.mode];
    [[cell detailTextLabel] setText:[NSString stringWithFormat:@"0x%02x",minVer]];
}

-(void) onPHSubminGameVerReceived:(Byte) phSubminVer {
    [DQObjectServerData postByteToDQuidServer:phSubminVer propertyName:@"pHSubminGameVer" object:_theBayTekRequestProtocol.dqobject isRead:YES delegate:nil];
    UITableViewCell* cell = [[TableCellsRegistry instance] getCellForCallbackSelName:NSStringFromSelector(_cmd) mode:self.mode];
    [[cell detailTextLabel] setText:[NSString stringWithFormat:@"0x%02x",phSubminVer]];
}

-(void) onMajAuxVerReceived:(Byte) majAuxVer {
    [DQObjectServerData postByteToDQuidServer:majAuxVer propertyName:@"majAuxVer" object:_theBayTekRequestProtocol.dqobject isRead:YES delegate:nil];
    UITableViewCell* cell = [[TableCellsRegistry instance] getCellForCallbackSelName:NSStringFromSelector(_cmd) mode:self.mode];
    [[cell detailTextLabel] setText:[NSString stringWithFormat:@"0x%02x",majAuxVer]];
}

-(void) onMinAuxVerReceived:(Byte) minAuxVer {
    [DQObjectServerData postByteToDQuidServer:minAuxVer propertyName:@"minAuxVer" object:_theBayTekRequestProtocol.dqobject isRead:YES delegate:nil];
    UITableViewCell* cell = [[TableCellsRegistry instance] getCellForCallbackSelName:NSStringFromSelector(_cmd) mode:self.mode];
    [[cell detailTextLabel] setText:[NSString stringWithFormat:@"0x%02x",minAuxVer]];
}

-(void) onPHMajAuxVerReceived:(Byte) phMajAuxVer {
    [DQObjectServerData postByteToDQuidServer:phMajAuxVer propertyName:@"pHMajAuxVer" object:_theBayTekRequestProtocol.dqobject isRead:YES delegate:nil];
    UITableViewCell* cell = [[TableCellsRegistry instance] getCellForCallbackSelName:NSStringFromSelector(_cmd) mode:self.mode];
    [[cell detailTextLabel] setText:[NSString stringWithFormat:@"0x%02x",phMajAuxVer]];
}

-(void) onPHMinAuxVerReceived:(Byte) phMinAuxVer {
    [DQObjectServerData postByteToDQuidServer:phMinAuxVer propertyName:@"pHMinAuxVer" object:_theBayTekRequestProtocol.dqobject isRead:YES delegate:nil];
    UITableViewCell* cell = [[TableCellsRegistry instance] getCellForCallbackSelName:NSStringFromSelector(_cmd) mode:self.mode];
    [[cell detailTextLabel] setText:[NSString stringWithFormat:@"0x%02x",phMinAuxVer]];
}

-(void) onPlaySoundACKReceived {
    [DQObjectServerData postByteToDQuidServer:1 propertyName:@"playSound" object:_theBayTekRequestProtocol.dqobject isRead:YES delegate:nil];
    UITableViewCell* cell = [[TableCellsRegistry instance] getCellForCallbackSelName:NSStringFromSelector(_cmd) mode:self.mode];
    [[cell detailTextLabel] setText:@"ACK!"];
}

-(void) onLastScoreLSBReceived:(Byte) lastScoreLSB {
    [DQObjectServerData postByteToDQuidServer:lastScoreLSB propertyName:@"lastScoreLSB" object:_theBayTekRequestProtocol.dqobject isRead:YES delegate:nil];
    UITableViewCell* cell = [[TableCellsRegistry instance] getCellForCallbackSelName:NSStringFromSelector(_cmd) mode:self.mode];
    [[cell detailTextLabel] setText:[NSString stringWithFormat:@"0x%02x",lastScoreLSB]];
}

-(void) onLastScoreMSBReceived:(Byte) lastScoreMSB {
    [DQObjectServerData postByteToDQuidServer:lastScoreMSB propertyName:@"lastScoreMSB" object:_theBayTekRequestProtocol.dqobject isRead:YES delegate:nil];
    UITableViewCell* cell = [[TableCellsRegistry instance] getCellForCallbackSelName:NSStringFromSelector(_cmd) mode:self.mode];
    [[cell detailTextLabel] setText:[NSString stringWithFormat:@"0x%02x",lastScoreMSB]];
}

-(void) onLightsACKReceived:(Byte) lightCode {
    [DQObjectServerData postByteToDQuidServer:lightCode propertyName:@"lights" object:_theBayTekRequestProtocol.dqobject isRead:YES delegate:nil];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = [NSString stringWithFormat:@"Lights ACK for 0x%02x!",lightCode];
    [hud show:YES];
    [hud hide:YES afterDelay:2.f];
}

-(void) onGameModeReceived:(Byte) gameMode {
    [DQObjectServerData postByteToDQuidServer:gameMode propertyName:@"gameMode" object:_theBayTekRequestProtocol.dqobject isRead:YES delegate:nil];
    UITableViewCell* cell = [[TableCellsRegistry instance] getCellForCallbackSelName:NSStringFromSelector(_cmd) mode:self.mode];
    [[cell detailTextLabel] setText:gameMode==0?@"Attract":@"Game"];
}

-(void) onToggleInputACKReceived:(Byte) inputBitmask {
    [DQObjectServerData postByteToDQuidServer:inputBitmask propertyName:@"toggleInput" object:_theBayTekRequestProtocol.dqobject isRead:YES delegate:nil];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = [NSString stringWithFormat:@"Bitmask: %d%d%d%d%d%d%d%d",inputBitmask>>7,inputBitmask>>6&0x01,inputBitmask>>5&0x01,inputBitmask>>4&0x01,inputBitmask>>3&0x01,inputBitmask>>2&0x01,inputBitmask>>1&0x01,inputBitmask&0x01];
    [hud show:YES];
    [hud hide:YES afterDelay:3.f];
}

-(void) onAddCreditsACKReceived:(Byte) noOfCredits {
    [DQObjectServerData postByteToDQuidServer:noOfCredits propertyName:@"addCredits" object:_theBayTekRequestProtocol.dqobject isRead:YES delegate:nil];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = [NSString stringWithFormat:@"Added %u credits!",noOfCredits];
    [hud show:YES];
    [hud hide:YES afterDelay:2.f];
}

-(void) onClearAllCreditsACKReceived {
    [DQObjectServerData postByteToDQuidServer:1 propertyName:@"clearAllCredits" object:_theBayTekRequestProtocol.dqobject isRead:YES delegate:nil];
    UITableViewCell* cell = [[TableCellsRegistry instance] getCellForCallbackSelName:NSStringFromSelector(_cmd) mode:self.mode];
    [[cell detailTextLabel] setText:@"ACK"];
}

-(void) onDispenseTicketsACKReceived:(Byte) noOfTickets {
    [DQObjectServerData postByteToDQuidServer:noOfTickets propertyName:@"dispenseTickets" object:_theBayTekRequestProtocol.dqobject isRead:YES delegate:nil];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = [NSString stringWithFormat:@"Dispensed %u tickets!",noOfTickets];
    [hud show:YES];
    [hud hide:YES afterDelay:2.f];
}

-(void) onPHAddTicketsACKReceived:(Byte) noOfTickets {
    [DQObjectServerData postByteToDQuidServer:noOfTickets propertyName:@"phAddTickets" object:_theBayTekRequestProtocol.dqobject isRead:YES delegate:nil];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = [NSString stringWithFormat:@"Added %u tickets!",noOfTickets];
    [hud show:YES];
    [hud hide:YES afterDelay:2.f];
}

-(void) onNoOfPlayedGamesLSBReceived:(Byte) noOfPlayedGamesLSB {
    [DQObjectServerData postByteToDQuidServer:noOfPlayedGamesLSB propertyName:@"noOfPlayedGamesLSB" object:_theBayTekRequestProtocol.dqobject isRead:YES delegate:nil];
    UITableViewCell* cell = [[TableCellsRegistry instance] getCellForCallbackSelName:NSStringFromSelector(_cmd) mode:self.mode];
    [[cell detailTextLabel] setText:[NSString stringWithFormat:@"0x%02x",noOfPlayedGamesLSB]];
}

-(void) onNoOfPlayedGamesMSBReceived:(Byte) noOfPlayedGamesMSB {
    [DQObjectServerData postByteToDQuidServer:noOfPlayedGamesMSB propertyName:@"noOfPlayedGamesMSB" object:_theBayTekRequestProtocol.dqobject isRead:YES delegate:nil];
    UITableViewCell* cell = [[TableCellsRegistry instance] getCellForCallbackSelName:NSStringFromSelector(_cmd) mode:self.mode];
    [[cell detailTextLabel] setText:[NSString stringWithFormat:@"0x%02x",noOfPlayedGamesMSB]];
}

-(void) onNoOfDispensedTicketsLSBReceived:(Byte) noOfDispensedTicketsLSB {
    [DQObjectServerData postByteToDQuidServer:noOfDispensedTicketsLSB propertyName:@"noOfDispensedTicketsLSB" object:_theBayTekRequestProtocol.dqobject isRead:YES delegate:nil];
    UITableViewCell* cell = [[TableCellsRegistry instance] getCellForCallbackSelName:NSStringFromSelector(_cmd) mode:self.mode];
    [[cell detailTextLabel] setText:[NSString stringWithFormat:@"0x%02x",noOfDispensedTicketsLSB]];
}

-(void) onNoOfDispensedTicketsMSBReceived:(Byte) noOfDispensedTicketsMSB {
    [DQObjectServerData postByteToDQuidServer:noOfDispensedTicketsMSB propertyName:@"noOfDispensedTicketsMSB" object:_theBayTekRequestProtocol.dqobject isRead:YES delegate:nil];
    UITableViewCell* cell = [[TableCellsRegistry instance] getCellForCallbackSelName:NSStringFromSelector(_cmd) mode:self.mode];
    [[cell detailTextLabel] setText:[NSString stringWithFormat:@"0x%02x",noOfDispensedTicketsMSB]];
}

-(void) onFBCurrentDailyHighScoreReceived:(Byte) currentDailyHighscore {
    [DQObjectServerData postByteToDQuidServer:currentDailyHighscore propertyName:@"fBCurrentDailyHighScore" object:_theBayTekRequestProtocol.dqobject isRead:YES delegate:nil];
    UITableViewCell* cell = [[TableCellsRegistry instance] getCellForCallbackSelName:NSStringFromSelector(_cmd) mode:self.mode];
    [[cell detailTextLabel] setText:[NSString stringWithFormat:@"%d",currentDailyHighscore]];
}

-(void) onPHTotalAddedTicketsLSBReceived:(Byte) noOfAddedTicketsLSB {
    [DQObjectServerData postByteToDQuidServer:noOfAddedTicketsLSB propertyName:@"pHTotalAddedTicketsLSB" object:_theBayTekRequestProtocol.dqobject isRead:YES delegate:nil];
    UITableViewCell* cell = [[TableCellsRegistry instance] getCellForCallbackSelName:NSStringFromSelector(_cmd) mode:self.mode];
    [[cell detailTextLabel] setText:[NSString stringWithFormat:@"0x%02x",noOfAddedTicketsLSB]];
}

-(void) onPHTotalAddedTicketsMLSBReceived:(Byte) noOfAddedTicketsMLSB {
    [DQObjectServerData postByteToDQuidServer:noOfAddedTicketsMLSB propertyName:@"pHTotalAddedTicketsMLSB" object:_theBayTekRequestProtocol.dqobject isRead:YES delegate:nil];
    UITableViewCell* cell = [[TableCellsRegistry instance] getCellForCallbackSelName:NSStringFromSelector(_cmd) mode:self.mode];
    [[cell detailTextLabel] setText:[NSString stringWithFormat:@"0x%02x",noOfAddedTicketsMLSB]];
}

-(void) onPHTotalAddedTicketsMSBReceived:(Byte) noOfAddedTicketsMSB {
    [DQObjectServerData postByteToDQuidServer:noOfAddedTicketsMSB propertyName:@"pHTotalAddedTicketsMSB" object:_theBayTekRequestProtocol.dqobject isRead:YES delegate:nil];
    UITableViewCell* cell = [[TableCellsRegistry instance] getCellForCallbackSelName:NSStringFromSelector(_cmd) mode:self.mode];
    [[cell detailTextLabel] setText:[NSString stringWithFormat:@"0x%02x",noOfAddedTicketsMSB]];
}

-(void) onPHTotalRedeemedTicketsLSBReceived:(Byte) noOfRedeemedTicketsLSB {
    [DQObjectServerData postByteToDQuidServer:noOfRedeemedTicketsLSB propertyName:@"pHTotalRedeemedTicketsLSB" object:_theBayTekRequestProtocol.dqobject isRead:YES delegate:nil];
    UITableViewCell* cell = [[TableCellsRegistry instance] getCellForCallbackSelName:NSStringFromSelector(_cmd) mode:self.mode];
    [[cell detailTextLabel] setText:[NSString stringWithFormat:@"0x%02x",noOfRedeemedTicketsLSB]];
}

-(void) onPHTotalRedeemedTicketsMLSBReceived:(Byte) noOfRedeemedTicketsMLSB {
    [DQObjectServerData postByteToDQuidServer:noOfRedeemedTicketsMLSB propertyName:@"pHTotalRedeemedTicketsMLSB" object:_theBayTekRequestProtocol.dqobject isRead:YES delegate:nil];
    UITableViewCell* cell = [[TableCellsRegistry instance] getCellForCallbackSelName:NSStringFromSelector(_cmd) mode:self.mode];
    [[cell detailTextLabel] setText:[NSString stringWithFormat:@"0x%02x",noOfRedeemedTicketsMLSB]];
}

-(void) onPHTotalRedeemedTicketsMSBReceived:(Byte) noOfRedeemedTicketsMSB {
    [DQObjectServerData postByteToDQuidServer:noOfRedeemedTicketsMSB propertyName:@"pHTotalRedeemedTicketsMSB" object:_theBayTekRequestProtocol.dqobject isRead:YES delegate:nil];
    UITableViewCell* cell = [[TableCellsRegistry instance] getCellForCallbackSelName:NSStringFromSelector(_cmd) mode:self.mode];
    [[cell detailTextLabel] setText:[NSString stringWithFormat:@"0x%02x",noOfRedeemedTicketsMSB]];
}

-(void) onPHTotalPrintedTicketsMSBReceived:(Byte) noOfPrintedTicketsMSB {
    [DQObjectServerData postByteToDQuidServer:noOfPrintedTicketsMSB propertyName:@"pHTotalPrintedTicketsMSB" object:_theBayTekRequestProtocol.dqobject isRead:YES delegate:nil];
    UITableViewCell* cell = [[TableCellsRegistry instance] getCellForCallbackSelName:NSStringFromSelector(_cmd) mode:self.mode];
    [[cell detailTextLabel] setText:[NSString stringWithFormat:@"0x%02x",noOfPrintedTicketsMSB]];
}

-(void) onPHTotalPrintedTicketsLSBReceived:(Byte) noOfPrintedTicketsLSB {
    [DQObjectServerData postByteToDQuidServer:noOfPrintedTicketsLSB propertyName:@"pHTotalPrintedTicketsLSB" object:_theBayTekRequestProtocol.dqobject isRead:YES delegate:nil];
    UITableViewCell* cell = [[TableCellsRegistry instance] getCellForCallbackSelName:NSStringFromSelector(_cmd) mode:self.mode];
    [[cell detailTextLabel] setText:[NSString stringWithFormat:@"0x%02x",noOfPrintedTicketsLSB]];
}

-(void) onPHNumberOfVendSucceededReceived:(Byte)noOfVendSucceeded forLocation:(Byte)location {
    NSMutableData *data = [NSMutableData new];
    [data appendBytes:&noOfVendSucceeded length:1];
    [data appendBytes:&location length:1];
    [DQObjectServerData postNSDataToDQuidServer:data propertyName:@"pHNumberOfVendSuccForLocation" object:_theBayTekRequestProtocol.dqobject isRead:YES delegate:nil];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = [NSString stringWithFormat:@"Succeeded Vends @ %u: %u",location,noOfVendSucceeded];
    [hud show:YES];
    [hud hide:YES afterDelay:2.f];
}

-(void) onPHNumberOfVendFailedReceived:(Byte)noOfVendFailed forLocation:(Byte)location {
    NSMutableData *data = [NSMutableData new];
    [data appendBytes:&noOfVendFailed length:1];
    [data appendBytes:&location length:1];
    [DQObjectServerData postNSDataToDQuidServer:data propertyName:@"pHNumberOfVendFailureForLocation" object:_theBayTekRequestProtocol.dqobject isRead:YES delegate:nil];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = [NSString stringWithFormat:@"Failed Vends @ %u: %u",location,noOfVendFailed];
    [hud show:YES];
    [hud hide:YES afterDelay:2.f];
}



-(void) onInvalidCommandReceived:(NSError*) e {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = [NSString stringWithFormat:@"Error!"];
    hud.detailsLabelText = [e localizedDescription];
    [hud show:YES];
    [hud hide:YES afterDelay:2.f];
}

-(void) onConnectionEstablished {
    [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
}

-(void) onDisconnection {
    [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
    
    [self.tableView reloadData];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Disconnected!"
                                                    message:@"Reconnect?"
                                                   delegate:self
                                          cancelButtonTitle:@"No"
                                          otherButtonTitles:@"Yes", nil];
    [alert setDelegate:self];
    [alert show];
}

#pragma mark - UITableViewDataSource

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.mode == kDQModeStatistics) {
        return [CELLS_STATISTICS_REGISTRY count];
    }
    else {
        return [CELLS_REGISTRY count];
    }
    
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableDictionary *cellInfo;
    
    if (self.mode == kDQModeStatistics) {
        cellInfo = CELLS_STATISTICS_REGISTRY[[indexPath row]];
    }
    else {
        cellInfo = CELLS_REGISTRY[[indexPath row]];
    }
    
    UITableViewCell *cell = nil;
    
    if ([[cellInfo objectForKey:@"type"] isEqualToString:CELL_DETAIL]) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"detailCell" forIndexPath:indexPath];
        [cellInfo setObject:cell forKey:@"cell"];
        cell.textLabel.text = [cellInfo objectForKey:@"label"];
        
        cell.detailTextLabel.text = @"Click to request";
        cell.userInteractionEnabled = cell.textLabel.enabled = cell.detailTextLabel.enabled = [self shouldEnableCell:cellInfo];
    } else if ([[cellInfo objectForKey:@"type"] isEqualToString:CELL_TEXTFIELD]) {
        TextFieldCellView *tfCell = (TextFieldCellView*)[tableView dequeueReusableCellWithIdentifier:@"textFieldCell" forIndexPath:indexPath];
        [tfCell initializeWithCellData:cellInfo andBayTekRequestProtocol:_theBayTekRequestProtocol];
        tfCell.nameLabel.text = [cellInfo objectForKey:@"label"];
        tfCell.cellData = cellInfo;
        tfCell.nameLabel.enabled = tfCell.userInteractionEnabled = tfCell.textField.userInteractionEnabled = [self shouldEnableCell:cellInfo];
        cell = tfCell;
        [cellInfo setObject:cell forKey:@"cell"];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableDictionary *cellInfo;
    
    if (self.mode == kDQModeStatistics) {
        cellInfo = CELLS_STATISTICS_REGISTRY[[indexPath item]];
    }
    else {
        cellInfo = CELLS_REGISTRY[[indexPath item]];
    }
    
    if ([[cellInfo objectForKey:@"type"] isEqualToString:CELL_DETAIL]) {
        UITableViewCell* cell = [cellInfo objectForKey:@"cell"];
        SEL sel = NSSelectorFromString([cellInfo objectForKeyedSubscript:@"selectorName"]);
        if (sel != nil && [_theBayTekRequestProtocol respondsToSelector:sel]) {
            if ([_theBayTekRequestProtocol performSelector:sel]) {
                [[cell detailTextLabel] setText:@"Requesting..."];
            } else {
                
            }
        }
    }
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        //[_theBayTekRequestProtocol disconnect];
        [_theBayTekRequestProtocol connect];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.detailsLabelText = [NSString stringWithFormat:@"Connecting to %@",DQUIDIO_SERIAL_NUMBER];
        [hud show:YES];
    }
}

#pragma mark - Helpers
-(BOOL) shouldEnableCell:(NSDictionary*) cellInfo {
    return !(([[cellInfo objectForKey:@"onlyFor"] isEqualToString:@"PH"] && _theMachineID != PRIZE_HUB) ||
             ([[cellInfo objectForKey:@"notFor"] isEqualToString:@"PH"] && _theMachineID == PRIZE_HUB) ||
             ([[cellInfo objectForKey:@"onlyFor"] isEqualToString:@"FB"] && _theMachineID != FLAPPY_BIRD) ||
             ![_theBayTekRequestProtocol isConnected]);
}
@end
