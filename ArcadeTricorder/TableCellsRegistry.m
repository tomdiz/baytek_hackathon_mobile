//
//  TableCellsRegistry.m
//  EmuBayTek
//
//  Created by Dario Fiumicello on 13/02/15.
//  Copyright (c) 2015 DQuid S.r.l. All rights reserved.
//

#import "TableCellsRegistry.h"

@implementation TableCellsRegistry

@synthesize registry;
@synthesize registryStatistics;

+ (TableCellsRegistry *)instance
{
    static dispatch_once_t pred;
    static TableCellsRegistry *shared = nil;
    
    dispatch_once(&pred, ^{
        shared = [[TableCellsRegistry alloc] init];
    });
    return shared;
}

-(id)init {
    self = [super init];
    if (self) {
        registry = [NSMutableArray arrayWithArray:
        @[
          @{
              @"selectorName"   : @"getMajGameVer",
              @"type"           : CELL_DETAIL,
              @"label"          : @"Game Major Version",
              @"callbackSel"    : @"onMajGameVerReceived:",
              },
          @{
              @"selectorName"   : @"getMinGameVer",
              @"type"           : CELL_DETAIL,
              @"label"          : @"Game Minor Version",
              @"callbackSel"    : @"onMinGameVerReceived:",
              },
//          @{
//              @"selectorName"   : @"getPHSubminGameVer",
//              @"type"           : CELL_DETAIL,
//              @"label"          : @"Game Submin Ver",
//              @"callbackSel"    : @"onPHSubminGameVerReceived:",
//              @"onlyFor"        : @"PH"
//              },
          @{
              @"selectorName"   : @"getMajAuxVer",
              @"type"           : CELL_DETAIL,
              @"label"          : @"Aux Board Maj Ver",
              @"callbackSel"    : @"onMajAuxVerReceived:",
              @"notFor"        : @"PH"
              },
//          @{
//              @"selectorName"   : @"getMinAuxVer",
//              @"type"           : CELL_DETAIL,
//              @"label"          : @"Aux Board Min Ver",
//              @"callbackSel"    : @"onMinAuxVerReceived:",
//              @"notFor"        : @"PH"
//              },
//          @{
//              @"selectorName"   : @"getPHMajAuxVer",
//              @"type"           : CELL_DETAIL,
//              @"label"          : @"PrizeHub Maj Aux Ver",
//              @"callbackSel"    : @"onPHMajAuxVerReceived:",
//              @"onlyFor"        : @"PH"
//              },
//          @{
//              @"selectorName"   : @"getPHMinAuxVer",
//              @"type"           : CELL_DETAIL,
//              @"label"          : @"PrizeHub Min Aux Ver",
//              @"callbackSel"    : @"onPHMinAuxVerReceived:",
//              @"onlyFor"        : @"PH"
//              },
          @{
              @"selectorName"   : @"playSound",
              @"type"           : CELL_DETAIL,
              @"label"          : @"Play Sound",
              @"callbackSel"    : @"onPlaySoundACKReceived",
              @"notFor"        : @"PH"
              },
//          @{
//              @"selectorName"   : @"getLastScoreLSB",
//              @"type"           : CELL_DETAIL,
//              @"label"          : @"Last Score LSB",
//              @"callbackSel"    : @"onLastScoreLSBReceived:",
//              @"notFor"        : @"PH"
//              },
//          @{
//              @"selectorName"   : @"getLastScoreMSB",
//              @"type"           : CELL_DETAIL,
//              @"label"          : @"Last Score MSB",
//              @"callbackSel"    : @"onLastScoreMSBReceived:",
//              @"notFor"        : @"PH"
//              },
          @{
              @"selectorName"   : @"setLightsWithCodeAsNSNumber:",
              @"type"           : CELL_TEXTFIELD,
              @"label"          : @"Set Light",
              @"callbackSel"    : @"onLightsACKReceived:",
              @"notFor"        : @"PH"
              },
          @{
              @"selectorName"   : @"getGameMode",
              @"type"           : CELL_DETAIL,
              @"label"          : @"Game Mode",
              @"callbackSel"    : @"onGameModeReceived:",
              @"notFor"        : @"PH"
              },
          @{
              @"selectorName"   : @"toggleInputWithBitkaskAsNSNumber:",
              @"type"           : CELL_TEXTFIELD,
              @"label"          : @"Toggle Input",
              @"callbackSel"    : @"onToggleInputACKReceived:",
              @"notFor"        : @"PH"
              },
          @{
              @"selectorName"   : @"addCreditsAsNSNumber:",
              @"type"           : CELL_TEXTFIELD,
              @"label"          : @"Add Credits",
              @"callbackSel"    : @"onAddCreditsACKReceived:",
              @"notFor"        : @"PH"
              },
          @{
              @"selectorName"   : @"dispenseTicketsAsNSNumber:",
              @"type"           : CELL_TEXTFIELD,
              @"label"          : @"Dispense Tickets",
              @"callbackSel"    : @"onDispenseTicketsACKReceived:",
              @"notFor"        : @"PH"
              },
//          @{
//              @"selectorName"   : @"phAddTicketsAsNSNumber:",
//              @"type"           : CELL_TEXTFIELD,
//              @"label"          : @"Add Tickets",
//              @"callbackSel"    : @"onPHAddTicketsACKReceived:",
//              @"onlyFor"        : @"PH"
//              },
//          @{
//              @"selectorName"   : @"getNoOfPlayedGamesLSB",
//              @"type"           : CELL_DETAIL,
//              @"label"          : @"# Played Games LSB",
//              @"callbackSel"    : @"onNoOfPlayedGamesLSBReceived:",
//              @"notFor"        : @"PH"
//              },
//          @{
//              @"selectorName"   : @"getNoOfPlayedGamesMSB",
//              @"type"           : CELL_DETAIL,
//              @"label"          : @"# Played Games MSB",
//              @"callbackSel"    : @"onNoOfPlayedGamesMSBReceived:",
//              @"notFor"        : @"PH"
//              },
//          @{
//              @"selectorName"   : @"getNoOfDispensedTicketsLSB",
//              @"type"           : CELL_DETAIL,
//              @"label"          : @"# Disp. Tickets LSB",
//              @"callbackSel"    : @"onNoOfDispensedTicketsLSBReceived:",
//              @"notFor"        : @"PH"
//              },
//          @{
//              @"selectorName"   : @"getNoOfDispensedTicketsMSB",
//              @"type"           : CELL_DETAIL,
//              @"label"          : @"# Disp. Tickets MSB",
//              @"callbackSel"    : @"onNoOfDispensedTicketsMSBReceived:",
//              @"notFor"        : @"PH"
//              },
//          @{
//              @"selectorName"   : @"getFBCurrentDailyHighScore",
//              @"type"           : CELL_DETAIL,
//              @"label"          : @"Current HighScore",
//              @"callbackSel"    : @"onFBCurrentDailyHighScoreReceived:",
//              @"onlyFor"        : @"FB"
//              },
//          @{
//              @"selectorName"   : @"getPHTotalAddedTicketsLSB",
//              @"type"           : CELL_DETAIL,
//              @"label"          : @"Tot added tickets LSB",
//              @"callbackSel"    : @"onPHTotalAddedTicketsLSBReceived:",
//              @"onlyFor"        : @"PH"
//              },
//          @{
//              @"selectorName"   : @"getPHTotalAddedTicketsMLSB",
//              @"type"           : CELL_DETAIL,
//              @"label"          : @"Tot added tickets MLSB",
//              @"callbackSel"    : @"onPHTotalAddedTicketsMLSBReceived:",
//              @"onlyFor"        : @"PH"
//              },
//          @{
//              @"selectorName"   : @"getPHTotalAddedTicketsMSB",
//              @"type"           : CELL_DETAIL,
//              @"label"          : @"Tot added tickets MSB",
//              @"callbackSel"    : @"onPHTotalAddedTicketsMSBReceived:",
//              @"onlyFor"        : @"PH"
//              },
//          @{
//              @"selectorName"   : @"getPHTotalRedeemedTicketsLSB",
//              @"type"           : CELL_DETAIL,
//              @"label"          : @"Tot redeemed tkt LSB",
//              @"callbackSel"    : @"onPHTotalRedeemedTicketsLSBReceived:",
//              @"onlyFor"        : @"PH"
//              },
//          @{
//              @"selectorName"   : @"getPHTotalRedeemedTicketsMLSB",
//              @"type"           : CELL_DETAIL,
//              @"label"          : @"Tot redeemed tkt MLSB",
//              @"callbackSel"    : @"onPHTotalRedeemedTicketsMLSBReceived:",
//              @"onlyFor"        : @"PH"
//              },
//          @{
//              @"selectorName"   : @"getPHTotalRedeemedTicketsMSB",
//              @"type"           : CELL_DETAIL,
//              @"label"          : @"Tot redeemed tkt MSB",
//              @"callbackSel"    : @"onPHTotalRedeemedTicketsMSBReceived:",
//              @"onlyFor"        : @"PH"
//              },
//          @{
//              @"selectorName"   : @"getPHTotalPrintedTicketsMSB",
//              @"type"           : CELL_DETAIL,
//              @"label"          : @"Tot printed tkt. MSB",
//              @"callbackSel"    : @"onPHTotalPrintedTicketsMSBReceived:",
//              @"onlyFor"        : @"PH"
//              },
//          @{
//              @"selectorName"   : @"getPHTotalPrintedTicketsLSB",
//              @"type"           : CELL_DETAIL,
//              @"label"          : @"Tot printed tkt LSB",
//              @"callbackSel"    : @"onPHTotalPrintedTicketsLSBReceived:",
//              @"onlyFor"        : @"PH"
//              },
//          @{
//              @"selectorName"   : @"getPHNumberOfVendSucceededForLocationAsNSNumber:",
//              @"type"           : CELL_TEXTFIELD,
//              @"label"          : @"# Vend Succ for Location",
//              @"callbackSel"    : @"onPHNumberOfVendSucceededReceived:forLocation:",
//              @"onlyFor"        : @"PH"
//              },
//          @{
//              @"selectorName"   : @"getPHNumberOfVendFailureForLocationAsNSNumber:",
//              @"type"           : CELL_TEXTFIELD,
//              @"label"          : @"# Vend Fail for Location",
//              @"callbackSel"    : @"onPHNumberOfVendFailedReceived:forLocation:",
//              @"onlyFor"        : @"PH"
//              },
          @{
              @"selectorName"   : @"clearAllCredits",
              @"type"           : CELL_DETAIL,
              @"label"          : @"Clear All Credits",
              @"callbackSel"    : @"onClearAllCreditsACKReceived",
              @"notFor"        : @"PH"
              },
//          @{
//              @"type"       : CELL_DETAIL
//              },
//          @{
//              @"type"       : CELL_TEXTFIELD
//              }
          ]];
        
        
        registryStatistics = [NSMutableArray arrayWithArray:
                              @[
                                @{
                                    @"selectorName"   : @"getLastScoreLSB",
                                    @"type"           : CELL_DETAIL,
                                    @"label"          : @"Last Score LSB",
                                    @"callbackSel"    : @"onLastScoreLSBReceived:",
                                    @"notFor"        : @"PH"
                                    },
                                @{
                                    @"selectorName"   : @"getLastScoreMSB",
                                    @"type"           : CELL_DETAIL,
                                    @"label"          : @"Last Score MSB",
                                    @"callbackSel"    : @"onLastScoreMSBReceived:",
                                    @"notFor"        : @"PH"
                                    },
//                                @{
//                                    @"selectorName"   : @"phAddTicketsAsNSNumber:",
//                                    @"type"           : CELL_TEXTFIELD,
//                                    @"label"          : @"Add Tickets",
//                                    @"callbackSel"    : @"onPHAddTicketsACKReceived:",
//                                    @"onlyFor"        : @"PH"
//                                    },
                                @{
                                    @"selectorName"   : @"getNoOfPlayedGamesLSB",
                                    @"type"           : CELL_DETAIL,
                                    @"label"          : @"# Played Games LSB",
                                    @"callbackSel"    : @"onNoOfPlayedGamesLSBReceived:",
                                    @"notFor"        : @"PH"
                                    },
                                @{
                                    @"selectorName"   : @"getNoOfPlayedGamesMSB",
                                    @"type"           : CELL_DETAIL,
                                    @"label"          : @"# Played Games MSB",
                                    @"callbackSel"    : @"onNoOfPlayedGamesMSBReceived:",
                                    @"notFor"        : @"PH"
                                    },
                                @{
                                    @"selectorName"   : @"getNoOfDispensedTicketsLSB",
                                    @"type"           : CELL_DETAIL,
                                    @"label"          : @"# Disp. Tickets LSB",
                                    @"callbackSel"    : @"onNoOfDispensedTicketsLSBReceived:",
                                    @"notFor"        : @"PH"
                                    },
                                @{
                                    @"selectorName"   : @"getNoOfDispensedTicketsMSB",
                                    @"type"           : CELL_DETAIL,
                                    @"label"          : @"# Disp. Tickets MSB",
                                    @"callbackSel"    : @"onNoOfDispensedTicketsMSBReceived:",
                                    @"notFor"        : @"PH"
                                    },
                                @{
                                    @"selectorName"   : @"getFBCurrentDailyHighScore",
                                    @"type"           : CELL_DETAIL,
                                    @"label"          : @"Current HighScore",
                                    @"callbackSel"    : @"onFBCurrentDailyHighScoreReceived:",
                                    @"onlyFor"        : @"FB"
                                    },
//                                @{
//                                    @"selectorName"   : @"getPHTotalAddedTicketsLSB",
//                                    @"type"           : CELL_DETAIL,
//                                    @"label"          : @"Tot added tickets LSB",
//                                    @"callbackSel"    : @"onPHTotalAddedTicketsLSBReceived:",
//                                    @"onlyFor"        : @"PH"
//                                    },
//                                @{
//                                    @"selectorName"   : @"getPHTotalAddedTicketsMLSB",
//                                    @"type"           : CELL_DETAIL,
//                                    @"label"          : @"Tot added tickets MLSB",
//                                    @"callbackSel"    : @"onPHTotalAddedTicketsMLSBReceived:",
//                                    @"onlyFor"        : @"PH"
//                                    },
//                                @{
//                                    @"selectorName"   : @"getPHTotalAddedTicketsMSB",
//                                    @"type"           : CELL_DETAIL,
//                                    @"label"          : @"Tot added tickets MSB",
//                                    @"callbackSel"    : @"onPHTotalAddedTicketsMSBReceived:",
//                                    @"onlyFor"        : @"PH"
//                                    },
//                                @{
//                                    @"selectorName"   : @"getPHTotalRedeemedTicketsLSB",
//                                    @"type"           : CELL_DETAIL,
//                                    @"label"          : @"Tot redeemed tkt LSB",
//                                    @"callbackSel"    : @"onPHTotalRedeemedTicketsLSBReceived:",
//                                    @"onlyFor"        : @"PH"
//                                    },
//                                @{
//                                    @"selectorName"   : @"getPHTotalRedeemedTicketsMLSB",
//                                    @"type"           : CELL_DETAIL,
//                                    @"label"          : @"Tot redeemed tkt MLSB",
//                                    @"callbackSel"    : @"onPHTotalRedeemedTicketsMLSBReceived:",
//                                    @"onlyFor"        : @"PH"
//                                    },
//                                @{
//                                    @"selectorName"   : @"getPHTotalRedeemedTicketsMSB",
//                                    @"type"           : CELL_DETAIL,
//                                    @"label"          : @"Tot redeemed tkt MSB",
//                                    @"callbackSel"    : @"onPHTotalRedeemedTicketsMSBReceived:",
//                                    @"onlyFor"        : @"PH"
//                                    },
//                                @{
//                                    @"selectorName"   : @"getPHTotalPrintedTicketsMSB",
//                                    @"type"           : CELL_DETAIL,
//                                    @"label"          : @"Tot printed tkt. MSB",
//                                    @"callbackSel"    : @"onPHTotalPrintedTicketsMSBReceived:",
//                                    @"onlyFor"        : @"PH"
//                                    },
//                                @{
//                                    @"selectorName"   : @"getPHTotalPrintedTicketsLSB",
//                                    @"type"           : CELL_DETAIL,
//                                    @"label"          : @"Tot printed tkt LSB",
//                                    @"callbackSel"    : @"onPHTotalPrintedTicketsLSBReceived:",
//                                    @"onlyFor"        : @"PH"
//                                    },
//                                @{
//                                    @"selectorName"   : @"getPHNumberOfVendSucceededForLocationAsNSNumber:",
//                                    @"type"           : CELL_TEXTFIELD,
//                                    @"label"          : @"# Vend Succ for Location",
//                                    @"callbackSel"    : @"onPHNumberOfVendSucceededReceived:forLocation:",
//                                    @"onlyFor"        : @"PH"
//                                    },
//                                @{
//                                    @"selectorName"   : @"getPHNumberOfVendFailureForLocationAsNSNumber:",
//                                    @"type"           : CELL_TEXTFIELD,
//                                    @"label"          : @"# Vend Fail for Location",
//                                    @"callbackSel"    : @"onPHNumberOfVendFailedReceived:forLocation:",
//                                    @"onlyFor"        : @"PH"
//                                    },
                                //          @{
                                //              @"type"       : CELL_DETAIL
                                //              },
                                //          @{
                                //              @"type"       : CELL_TEXTFIELD
                                //              }
                                ]];
        
        for (int i=0; i<[registry count]; i++) {
            registry[i] = [NSMutableDictionary dictionaryWithDictionary:registry[i]];
        }
        
        for (int i=0; i<[registryStatistics count]; i++) {
            registryStatistics[i] = [NSMutableDictionary dictionaryWithDictionary:registryStatistics[i]];
        }
    }
    return self;
}

- (UITableViewCell*) getCellForCallbackSelName:(NSString*)callbackSelectorName mode:(NSInteger)mode {
    
    if (mode == kDQModeStatistics) {
        for (NSDictionary* d in CELLS_STATISTICS_REGISTRY) {
            if ([[d objectForKey:@"callbackSel"] isEqualToString:callbackSelectorName]) {
                UITableViewCell* cell = [d objectForKey:@"cell"];
                return cell;
            }
        }
    }
    else if (mode == kDQModeDiagnostics) {
        for (NSDictionary* d in CELLS_REGISTRY) {
            if ([[d objectForKey:@"callbackSel"] isEqualToString:callbackSelectorName]) {
                UITableViewCell* cell = [d objectForKey:@"cell"];
                return cell;
            }
        }
    }
    
    return nil;
}

@end
