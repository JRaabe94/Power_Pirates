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

@end

#endif /* DBManager_h */
