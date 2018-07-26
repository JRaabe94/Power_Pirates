//
//  Storage.m
//  Power_Pirates
//
//  Created by Codecamp on 23.07.18.
//  Copyright © 2018 Codecamp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBManager.h"
#import "Storage.h"
#import "TypeDef.h"

@interface Storage()
@property int currentMoney;
@property int moneyIndex;
@end

@implementation Storage
-(void)saveData{
    //Iterate over all supplie items
    for(int i = 0; i < self.supplies.count; i++){
        DBManager *dbManager = [[DBManager alloc] init];    // Test
        dbManager = [dbManager initWithDatabaseFilename:@"piratendb.sql"];
        
        //Get the attribute values
        NSString *column = (NSString*)[[self.supplies objectAtIndex:i] objectAtIndex:NAME];
        const char *newColumn =[column UTF8String];
        int newAmount = (int)[[self.supplies objectAtIndex:i] objectAtIndex:AMOUNT];
        
        [dbManager saveStorage:newAmount newColumn:newColumn];
    }
}
-(void)loadData{
    DBManager *dbManager = [[DBManager alloc] init];    // Test
    dbManager = [dbManager initWithDatabaseFilename:@"piratendb.sql"];
    
    //Get the results
    NSArray *results = [dbManager readStorage];
    NSString *readMoney = [[results objectAtIndex:MONEY] objectAtIndex:AMOUNT];
    self.currentMoney = [readMoney intValue];
    NSLog(@"AKTUELLER GELDBETRAG:");
    NSLog(@"%d", self.currentMoney);
}
-(NSString *)buy:(NSString *)selectedItem{
    int costs = 0;
    int amount = 0;
    for(int i = 0; i < self.supplies.count; i++){
        if((NSString*)[[self.supplies objectAtIndex:i] objectAtIndex:NAME] == selectedItem){
            costs = (int)[[self.supplies objectAtIndex:i] objectAtIndex:PRICE];
            amount = (int)[[self.supplies objectAtIndex:i] objectAtIndex:AMOUNT];
            if(costs != 0 && self.currentMoney != 0 && self.currentMoney >= costs){
                self.currentMoney = self.currentMoney - costs;
                amount = amount + 1;
                [[self.supplies objectAtIndex:self.moneyIndex] setValue: [NSNumber numberWithInt:((int)self.currentMoney)] forKey:@"anzahl"];
                [[self.supplies objectAtIndex:i] setValue: [NSNumber numberWithInt:((int)amount)] forKey:@"anzahl"];
                return @"Kauf erfolgreich!";
            }else{
                return @"Kauf nicht erfolgreich, nicht genug Geld!";
            }
        }
    }
    return @"Objekt nicht gefunden!";
}
-(NSString *)sell:(NSString *)selectedItem{
    int costs = 0;
    int amount = 0;
    int itemIndex = 0;
    for(int i = 0; i < self.supplies.count; i++){
        if((NSString*)[[self.supplies objectAtIndex:i] objectAtIndex:NAME] == selectedItem){
            costs = (int)[[self.supplies objectAtIndex:i] objectAtIndex:PRICE];
            amount = (int)[[self.supplies objectAtIndex:i] objectAtIndex:AMOUNT];
            self.currentMoney = self.currentMoney + (0.5*costs);
            amount = amount - 1;
            [[self.supplies objectAtIndex:self.moneyIndex] setValue: [NSNumber numberWithInt:((int)self.currentMoney)] forKey:@"anzahl"];
            [[self.supplies objectAtIndex:itemIndex] setValue: [NSNumber numberWithInt:((int)amount)] forKey:@"anzahl"];
            return @"Verkauf erfolgreich!";
        }
    }
    return @"Objekt nicht gefunden!";
}
-(NSString *)useItem:(NSString *)selectedItem{
    int amount = 0;
    for(int i = 0; i < self.supplies.count; i++){
        if((NSString*)[[self.supplies objectAtIndex:i] objectAtIndex:NAME] == selectedItem){
            amount = (int)[[self.supplies objectAtIndex:i] objectAtIndex:AMOUNT];
            if(amount > 1){
                amount = amount - 1;
                [[self.supplies objectAtIndex:i] setValue: [NSNumber numberWithInt:((int)amount)] forKey:@"anzahl"];
                return @"Erolfgreich benutzt!";
            }else{
                return @"Nicht genug Objekte dieser Art!";
            }
        }
    }
    return @"Objekt nicht gefunden!";
}
@end
