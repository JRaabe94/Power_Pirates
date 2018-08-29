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
//Can be used for the developers, if they want to change something, were no function exists for. with saveData, the whole object ist stored in the database
-(void)saveData{
    DBManager *dbManager = [[DBManager alloc] init];
    dbManager = [dbManager initWithDatabaseFilename:@"piratendb.sql"];
    [dbManager savePirates:self.lifes newLvl:self.level newAlcLvl:self.alcoholLevel];
}
//loads all attributes from the db to the storage object
-(void)loadData{
    DBManager *dbManager = [[DBManager alloc] init];
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
}
-(void)gainLevel{
    self.level = self.level + 1;
    [self.dbManager updatePirateField:P_LVLDB newAmount:self.level];
}
-(void)gainAlcLevel{
    self.alcoholLevel = self.alcoholLevel + 1;
    [self.dbManager updatePirateField:P_ALCLVLDB newAmount:self.alcoholLevel];
    [self checkIfDrunk];
}
-(void)resetAlcLevel{
    self.alcoholLevel = 0;
    [self.dbManager updatePirateField:P_ALCLVLDB newAmount:self.alcoholLevel];
}
-(void)gainEP{
    self.ffdesires = self.ffdesires + 1;
    [self checkLevelUp];
    [self.dbManager updatePirateField:P_BEDDB newAmount:self.ffdesires];
}

//check if the player level is between the level limits
-(void)checkLevelUp{
    int currentLevel = self.level;
    if(self.ffdesires > LVL2 && self.ffdesires < LVL3){
        self.level = 2;
    }else if (self.ffdesires > LVL3 && self.ffdesires < LVL4){
        self.level = 3;
    }else if (self.ffdesires > LVL4 && self.ffdesires < LVL5){
        self.level = 4;
    }else if (self.ffdesires > LVL5 && self.ffdesires != LVL5){
        self.level = 5;
    }
    if(currentLevel < self.level){
        [self.dbManager updatePirateField:P_LVLDB newAmount:self.level];
    }
}
-(BOOL)checkIfDrunk{
    if(self.alcoholLevel >= DRUNK){
        return YES;
    }else{
        return NO;
    }
}
@end
