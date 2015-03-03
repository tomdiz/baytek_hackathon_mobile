//
//  DetailCellView
//  DQuidApp
//
//  Created by Dario Fiumicello on 07/10/14.
//  Copyright (c) 2014 DQuid S.r.l. All rights reserved.
//

#import "TextFieldCellView.h"

@implementation TextFieldCellView

@synthesize nameLabel,textField,cellData,protocol;

-(void) initializeWithCellData:(NSMutableDictionary*)aCellData andBayTekRequestProtocol:(DQBayTekRequestProtocol*) aProtocol {
    cellData = aCellData;
    protocol = aProtocol;
    textField.text = nil;
    [textField setDelegate:self];
}

-(BOOL) textFieldShouldReturn:(UITextField *)aTextField{
    int value = [aTextField.text intValue];
    
    if (value<0 || value > 255) return NO;
    
    [aTextField resignFirstResponder];
    SEL sel = NSSelectorFromString([cellData objectForKeyedSubscript:@"selectorName"]);
    if (sel != nil && [protocol respondsToSelector:sel]) {
        if ([protocol performSelector:sel withObject:[NSNumber numberWithInt:value]]) {
        } else {
        }
    }
    return YES;
}

@end
