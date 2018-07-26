//
//  DBManager.h
//  Power_Pirates
//
//  Created by Codecamp on 24.07.18.
//  Copyright © 2018 Codecamp. All rights reserved.
//

#ifndef DBManager_h
#define DBManager_h

@interface DBManager : NSObject

-(instancetype)initWithDatabaseFilename:(NSString *)dbFilename;

@property (nonatomic, strong) NSMutableArray *arrColumnNames;

@property (nonatomic) int affectedRows;

@property (nonatomic) long long lastInsertedRowID;

-(NSArray *)loadDataFromDB:(NSString *)query;

- (void)executeQuery:(NSString *)query;

- (void)insertDesire:(int)desireId withTimer:(NSString *)time;

- (NSArray *)readDesires;

- (NSArray *)readPirates;

- (void)savePirates:(int)newLifes newLvl:(int)newLvl newAlcLvl:(int)newAlcLvl;;

- (void)newPlayerDatas:(NSString *)pirateName;

- (BOOL)checkPlayerExisting;

@end

#endif /* DBManager_h */
