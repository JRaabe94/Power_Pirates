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

- (void)insertDesire:(int)desireId withStartDate:(NSString *)start andExpiryDate:(NSString *)end;

- (NSArray *)readDesires;

- (NSArray *)readPirates;

- (NSArray *)readStorage;

- (void)savePirates:(int)newLifes newLvl:(int)newLvl newAlcLvl:(int)newAlcLvl;

- (void)saveStorage:(int)newAmount newColumn:(const char *) newColumn;

-(void)updateField:(NSString *)dbName fieldID:(int)fieldID newAmount:(int)newAmount;

- (void)newPlayerDatas:(NSString *) pirateName;

- (BOOL)checkPlayerExisting;

-(void)cleanDatabase;

@end

#endif /* DBManager_h */
