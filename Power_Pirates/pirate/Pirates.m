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
    //prepare query string
    NSString *query = [NSString stringWithFormat:@"update piraten set leben = '%d', level = '%d', pegel = '%d'", self.lifes, self.level, self.alcoholLevel];
    
    //Execute query
    [self.dbManager executeQuery:query];
    
    if (self.dbManager.affectedRows != 0) {
        NSLog(@"Query was executed successfully. Affected rows = %d", self.dbManager.affectedRows);
    }else{
        NSLog(@"Could not execute the query.");
    }
}
-(void)loadData{
    //From query
    NSString *query = @"select * from piraten";
    
    //Get the results
    NSArray *results = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    self.name = [[results objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"name"]];
    self.lifes = (int)[[results objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"lebens"]];
    self.level = (int)[[results objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"level"]];
    self.alcoholLevel = (int)[[results objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"pegel"]];
}
@end
