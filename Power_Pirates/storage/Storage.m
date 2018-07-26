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
//Maybe Deprecated
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
    self.supplies = [[dbManager readStorage] copy];
    NSString *readMoney = [[self.supplies objectAtIndex:MONEY] objectAtIndex:AMOUNT];
    self.currentMoney = [readMoney intValue];
}
-(NSString *)buy:(int)selectedItem{
    int costs = 0;
    int amount = 0;
    NSLog(@"---------BUY-----------");
    if(selectedItem>=0 && selectedItem <=(MAX_SUPPLIES-1)){
        NSString *readCosts = [[self.supplies objectAtIndex:selectedItem] objectAtIndex:PRICE];
        costs = [readCosts intValue];
        NSString *readAmount = [[self.supplies objectAtIndex:selectedItem] objectAtIndex:AMOUNT];
        amount = [readAmount intValue];
        if(costs != 0 && self.currentMoney != 0 && self.currentMoney >= costs){
            self.currentMoney = self.currentMoney - costs;
            amount = amount + 1;
            [self update:selectedItem amount:amount];
            return @"Kauf erfolgreich!";
        }else{
            return @"Kauf nicht erfolgreich, nicht genug Geld!";
        }
    }
    return @"Objekt nicht gefunden!";
}
-(NSString *)sell:(int)selectedItem{
    int costs = 0;
    int amount = 0;
    if(selectedItem>=0 && selectedItem <=(MAX_SUPPLIES-1)){
        NSString *readCosts = [[self.supplies objectAtIndex:selectedItem] objectAtIndex:PRICE];
        costs = [readCosts intValue];
        NSString *readAmount = [[self.supplies objectAtIndex:selectedItem] objectAtIndex:AMOUNT];
        amount = [readAmount intValue];
        self.currentMoney = self.currentMoney + (0.5*costs);
        amount = amount - 1;
        [self update:selectedItem amount:amount];
        return @"Verkauf erfolgreich!";
    }else{
        return @"Verkauf nicht erfolgreich!";
    }
}
-(NSString *)useItem:(int)selectedItem{
    int amount = 0;
    if(selectedItem>=0 && selectedItem <=(MAX_SUPPLIES-1)){
        NSString *readAmount = [[self.supplies objectAtIndex:selectedItem] objectAtIndex:AMOUNT];
        amount = [readAmount intValue];
        if(amount > 0){
            amount = amount - 1;
            [self update:selectedItem amount:amount];
            return @"Erolfgreich benutzt!";
        }else{
            return @"Nicht genug Objekte dieser Art!";
        }
    }
    return @"Objekt nicht gefunden!";
}
-(void)update:(int)selectedItem amount:(int)amount{
    DBManager *dbManager = [[DBManager alloc] init];
    dbManager = [dbManager initWithDatabaseFilename:@"piratendb.sql"];

    [dbManager updateField:@"lager" fieldID:(selectedItem+1) newAmount:amount];
    [dbManager updateField:@"lager" fieldID:(MONEY+1) newAmount:self.currentMoney];
    [self loadData];
}
@end
