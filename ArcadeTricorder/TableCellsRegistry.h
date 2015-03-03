//
//  TableCellsRegistry.h
//  EmuBayTek
//
//  Created by Dario Fiumicello on 13/02/15.
//  Copyright (c) 2015 DQuid S.r.l. All rights reserved.
//

#import <Foundation/Foundation.h>

#define CELLS_REGISTRY [[TableCellsRegistry instance] registry]
#define CELLS_STATISTICS_REGISTRY [[TableCellsRegistry instance] registryStatistics]

#define CELL_DETAIL     @"DETAIL"
#define CELL_TEXTFIELD  @"TEXTFIELD"

#define kDQModeDiagnostics 100
#define kDQModeStatistics 101

@class UITableViewCell;

@interface TableCellsRegistry : NSObject

@property(nonatomic,strong) NSMutableArray* registry;
@property(nonatomic,strong) NSMutableArray* registryStatistics;

+ (TableCellsRegistry *) instance;

- (UITableViewCell*) getCellForCallbackSelName:(NSString*)callbackSelectorName mode:(NSInteger)mode;

@end
