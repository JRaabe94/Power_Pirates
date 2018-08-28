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
//Can be used for the developers, if they want to change something, were no function exists for. with saveData, the whole object ist stored in the database
-(void)saveData{
    //Iterate over all supplie items
    for(int i = 0; i < self.supplies.count; i++){
        DBManager *dbManager = [[DBManager alloc] init];
        dbManager = [dbManager initWithDatabaseFilename:@"piratendb.sql"];
        
        //Get the attribute values
        NSString *column = (NSString*)[[self.supplies objectAtIndex:i] objectAtIndex:NAME];
        const char *newColumn =[column UTF8String];
        int newAmount = [self getAmount:i];
        
        [dbManager saveStorage:newAmount newColumn:newColumn];
    }
}

//loads all attributes from the db to the storage object
-(void)loadData{
    DBManager *dbManager = [[DBManager alloc] init];
    dbManager = [dbManager initWithDatabaseFilename:@"piratendb.sql"];
    
    //Get the results
    self.supplies = [[dbManager readStorage] copy];
    NSString *readMoney = [[self.supplies objectAtIndex:MONEY] objectAtIndex:AMOUNT];
    self.currentMoney = [readMoney intValue];
}
-(NSString *)buy:(int)selectedItem{
    if(selectedItem>=0 && selectedItem <=(MAX_SUPPLIES-1)){
        //read in the costs for the good
        int costs = [self getCosts:selectedItem];
        
        //read the current amount
        int amount = [self getAmount:selectedItem];
        
        //check if the player has enough money
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
-(NSString *)give:(int)selectedItem{
    if(selectedItem>=0 && selectedItem <=(MAX_SUPPLIES-1)){     //check if the selectedItem value is a valid number
        int amount = [self getAmount:selectedItem];
        amount = amount + 1;
        
        //if the given item was Money, add it in the self.currentMoney property
        if(selectedItem == MONEY){
            self.currentMoney = self.currentMoney + 1;
        }
        [self update:selectedItem amount:amount];
    }
    return @"Objekt nicht gefunden!";
}
-(NSString *)sell:(int)selectedItem{
    //read the costs of the item
    int costs = [self getCosts:selectedItem];
    
    //read the amount of the item
    int amount = [self getAmount:selectedItem];
    
    if(selectedItem>=0 && selectedItem <=(MAX_SUPPLIES-1) && amount > 0){
        self.currentMoney = self.currentMoney + (0.5*costs);
        amount = amount - 1;
        [self update:selectedItem amount:amount];
        return @"Verkauf erfolgreich!";
    }else{
        return @"Verkauf nicht erfolgreich!";
    }
}
-(NSString *)useItem:(int)selectedItem{
    int amount = [self getAmount:selectedItem];
    if(selectedItem>=0 && selectedItem <=(MAX_SUPPLIES-1)){
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

//returns the costs of the item
-(int)getCosts:(int)selectedItem{
    NSString *readCosts = [[self.supplies objectAtIndex:selectedItem] objectAtIndex:PRICE];
    return [readCosts intValue];
}

//returns the amount of the item
-(int)getAmount:(int)selectedItem{
    NSString *readAmount = [[self.supplies objectAtIndex:selectedItem] objectAtIndex:AMOUNT];
    return [readAmount intValue];
}

//method to update the changes directly
-(void)update:(int)selectedItem amount:(int)amount{
    DBManager *dbManager = [[DBManager alloc] init];
    dbManager = [dbManager initWithDatabaseFilename:@"piratendb.sql"];

    [dbManager updateStorageField:(selectedItem+1) newAmount:amount];
    [dbManager updateStorageField:(MONEY+1) newAmount:self.currentMoney];
    [self loadData];
}

@end
