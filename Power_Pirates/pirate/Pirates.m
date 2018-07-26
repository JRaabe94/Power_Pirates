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
    //self.name = [[results objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"name"]];
    self.name = [[results objectAtIndex:0] objectAtIndex:1];
    NSString *readLifes = [[results objectAtIndex:0] objectAtIndex:2];
    self.lifes = [readLifes intValue];
    NSString *readLevel = [[results objectAtIndex:0] objectAtIndex:3];
    self.level = [readLevel intValue];
    NSString *readAlc = [[results objectAtIndex:0] objectAtIndex:4];
    self.alcoholLevel = [readAlc intValue];
    NSLog(@"Name des Piraten:");
    NSLog(@"%@", self.name);
    NSLog(@"Leben des Piraten:");
    NSLog(@"%d", self.lifes);
    NSLog(@"Level des Piraten:");
    NSLog(@"%d", self.level);
    NSLog(@"Pegel des Piraten:");
    NSLog(@"%d", self.alcoholLevel);
}
-(void)looseLife{
    self.lifes = self.lifes - 1;
}
-(void)gainLevel{
    self.level = self.level + 1;
}
-(void)gainAlcLevel{
    self.alcoholLevel = self.alcoholLevel + 1;
}
-(void)resetAlcLevel{
    self.alcoholLevel = 0;
}
@end
