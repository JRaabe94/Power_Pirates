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

- (void)insertDesire:(NSInteger)desireId withStartDate:(NSString *)start andExpiryDate:(NSString *)end;

- (void)deleteDesire:(NSString *)startDate;

- (NSArray *)readDesires;

- (NSArray *)readPirates;

- (NSArray *)readStorage;

- (void)savePirates:(int)newLifes newLvl:(int)newLvl newAlcLvl:(int)newAlcLvl;

- (void)saveStorage:(int)newAmount newColumn:(const char *) newColumn;

-(void)updateStorageField:(int)fieldID newAmount:(int)newAmount;

-(void)updatePirateField:(NSString*)fieldName newAmount:(int)newAmount;

- (void)newPlayerDatas:(NSString *) pirateName;

- (BOOL)checkIfPlayerExists;

-(void)cleanDatabase;

@end

#endif /* DBManager_h */
