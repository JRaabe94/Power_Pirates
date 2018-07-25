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

@interface Storage()
@property int currentMoney;
@property int moneyIndex;
@end

@implementation Storage
-(void)saveData{
    //Iterate over all supplie items
    for(int i = 0; i < self.supplies.count; i++){
        //Get the attribute values
        NSString *column = (NSString*)[[self.supplies objectAtIndex:i] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"name"]];
        const char *newColumn =[column UTF8String];
        int newAmount = (int)[[self.supplies objectAtIndex:i] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"anzahl"]];
        
        //prepare query string
        NSString *query = [NSString stringWithFormat:@"update lager set anzahl = '%d' where name = '%s'", newAmount, newColumn];
        
        //Execute query
        [self.dbManager executeQuery:query];
        
        if (self.dbManager.affectedRows != 0) {
            NSLog(@"Query was executed successfully. Affected rows = %d", self.dbManager.affectedRows);
        }else{
            NSLog(@"Could not execute the query.");
        }
    }
    
}
-(void)loadData{
    //From query
    NSString *query = @"select * from piraten";
    
    //Get the results
    self.supplies = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    NSString *moneyField = @"Geld";
    self.currentMoney = 0;
    self.moneyIndex = 0;
    for(int i = 0; i < self.supplies.count; i++){
        if((NSString*)[[self.supplies objectAtIndex:i] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"name"]] == moneyField){
            self.currentMoney = (int)[[self.supplies objectAtIndex:i] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"anzahl"]];
            self.moneyIndex = i;
        }
    }
}
-(NSString *)buy:(NSString *)selectedItem{
    int costs = 0;
    int amount = 0;
    for(int i = 0; i < self.supplies.count; i++){
        if((NSString*)[[self.supplies objectAtIndex:i] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"name"]] == selectedItem){
            costs = (int)[[self.supplies objectAtIndex:i] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"preis"]];
            amount = (int)[[self.supplies objectAtIndex:i] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"anzahl"]];
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
        if((NSString*)[[self.supplies objectAtIndex:i] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"name"]] == selectedItem){
            costs = (int)[[self.supplies objectAtIndex:i] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"preis"]];
            amount = (int)[[self.supplies objectAtIndex:i] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"anzahl"]];
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
        if((NSString*)[[self.supplies objectAtIndex:i] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"name"]] == selectedItem){
            amount = (int)[[self.supplies objectAtIndex:i] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"anzahl"]];
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
