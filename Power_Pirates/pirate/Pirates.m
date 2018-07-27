//
//  Pirates.m
//  Power_Pirates
//
//  Created by Codecamp on 23.07.18.
//  Copyright © 2018 Codecamp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Pirates.h"
#import "DBManager.h"
#import "TypeDef.h"

@interface Pirates()
@property (nonatomic, strong) DBManager *dbManager;
@end

@implementation Pirates
-(void)saveData{
    DBManager *dbManager = [[DBManager alloc] init];    // Test
    dbManager = [dbManager initWithDatabaseFilename:@"piratendb.sql"];
    [dbManager savePirates:self.lifes newLvl:self.level newAlcLvl:self.alcoholLevel];
}
-(void)loadData{
    DBManager *dbManager = [[DBManager alloc] init];    // Test
    dbManager = [dbManager initWithDatabaseFilename:@"piratendb.sql"];
    
    //Get the results
    NSArray *results = [dbManager readPirates];
    self.name = [[results objectAtIndex:0] objectAtIndex:P_NAME];
    NSString *readLifes = [[results objectAtIndex:0] objectAtIndex:P_LIFE];
    self.lifes = [readLifes intValue];
    NSString *readLevel = [[results objectAtIndex:0] objectAtIndex:P_LVL];
    self.level = [readLevel intValue];
    NSString *readAlc = [[results objectAtIndex:0] objectAtIndex:P_ALCLVL];
    self.alcoholLevel = [readAlc intValue];
    NSString *readDes = [[results objectAtIndex:0] objectAtIndex:P_BED];
    self.ffdesires = [readDes intValue];
}
-(void)looseLife{
    self.lifes = self.lifes - 1;
    [self.dbManager updatePirateField:P_LIFEDB newAmount:self.lifes];
    [self loadData];
}
-(void)gainLevel{
    self.level = self.level + 1;
    [self.dbManager updatePirateField:P_LVLDB newAmount:self.lifes];
}
-(void)gainAlcLevel{
    self.alcoholLevel = self.alcoholLevel + 1;
    [self.dbManager updatePirateField:P_ALCLVLDB newAmount:self.lifes];
}
-(void)resetAlcLevel{
    self.alcoholLevel = 0;
    [self.dbManager updatePirateField:P_ALCLVLDB newAmount:self.lifes];
}
-(void)gainEP{
    self.ffdesires = self.ffdesires + 1;
    [self.dbManager updatePirateField:P_BEDDB newAmount:self.ffdesires];
    [self checkLevelUp];
}
-(void)checkLevelUp{
    /*if(self.ffdesires > LVL2 && self.ffdesires < LVL3){
        
    }else if (self.ffdesires > LVL2 && self.ffdesires < LVL3)*/
}
@end
