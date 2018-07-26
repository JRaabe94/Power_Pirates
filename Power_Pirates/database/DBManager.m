//
//  DBManager.m
//  Power_Pirates
//
//  Created by Codecamp on 24.07.18.
//  Copyright © 2018 Codecamp. All rights reserved.
//
#import <sqlite3.h>
#import <Foundation/Foundation.h>
#import "DBManager.h"
#import "TypeDef.h"

@interface DBManager()

@property (nonatomic, strong) NSString *documentsDirectory;
@property (nonatomic, strong) NSString *databaseFilename;
@property (nonatomic, strong) NSMutableArray *arrResults;

-(void)runQuery:(const char *)query isQueryExecutable:(BOOL)queryExecutable;
-(void)copyDatabaseIntoDocumentsDirectory;
-(void)generatePirate:(NSString *)pirateName;
-(void)generateStorage;

@end

@implementation DBManager
-(instancetype)initWithDatabaseFilename:(NSString *)dbFilename{
    self = [super init];
    if(self){
        //Set the documents directory path to the documentsDirectory property
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        self.documentsDirectory = [paths objectAtIndex:0];
        
        //Keep the database filename
        self.databaseFilename = dbFilename;
        
        //Copy the database file into the documents directory if necessary
        [self copyDatabaseIntoDocumentsDirectory];
                                                             
    }
    return self;
}

-(void)copyDatabaseIntoDocumentsDirectory{
    // Check if the database file exists in the documents directory.
    NSString *destinationPath = [self.documentsDirectory stringByAppendingPathComponent:self.databaseFilename];
    if (![[NSFileManager defaultManager] fileExistsAtPath:destinationPath]) {
        // The database file does not exist in the documents directory, so copy it from the main bundle now.
        NSString *sourcePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:self.databaseFilename];
        NSError *error;
        [[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:destinationPath error:&error];
        
        // Check if any error occurred during copying and display it.
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
        }
    }
}

-(void)runQuery:(const char *)query isQueryExecutable:(BOOL)queryExecutable{
    // Create a sqlite object.
    sqlite3 *sqlite3Database;
    
    // Set the database file path.
    NSString *databasePath = [self.documentsDirectory stringByAppendingPathComponent:self.databaseFilename];
    
    // Initialize the results array.
    if (self.arrResults != nil) {
        [self.arrResults removeAllObjects];
        self.arrResults = nil;
    }
    self.arrResults = [[NSMutableArray alloc] init];
    
    // Initialize the column names array.
    if (self.arrColumnNames != nil) {
        [self.arrColumnNames removeAllObjects];
        self.arrColumnNames = nil;
    }
    self.arrColumnNames = [[NSMutableArray alloc] init];
    
    
    // Open the database.
    BOOL openDatabaseResult = sqlite3_open([databasePath UTF8String], &sqlite3Database);
    if(openDatabaseResult == SQLITE_OK) {
        // Declare a sqlite3_stmt object in which will be stored the query after having been compiled into a SQLite statement.
        sqlite3_stmt *compiledStatement;
        
        // Load all data from database to memory.
        BOOL prepareStatementResult = sqlite3_prepare_v2(sqlite3Database, query, -1, &compiledStatement, NULL);
        if(prepareStatementResult == SQLITE_OK) {
            // Check if the query is non-executable.
            if (!queryExecutable){
                // In this case data must be loaded from the database.
                
                // Declare an array to keep the data for each fetched row.
                NSMutableArray *arrDataRow;
                
                // Loop through the results and add them to the results array row by row.
                while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
                    // Initialize the mutable array that will contain the data of a fetched row.
                    arrDataRow = [[NSMutableArray alloc] init];
                    
                    // Get the total number of columns.
                    int totalColumns = sqlite3_column_count(compiledStatement);
                    
                    // Go through all columns and fetch each column data.
                    for (int i=0; i<totalColumns; i++){
                        // Convert the column data to text (characters).
                        char *dbDataAsChars = (char *)sqlite3_column_text(compiledStatement, i);
                        
                        // If there are contents in the currenct column (field) then add them to the current row array.
                        if (dbDataAsChars != NULL) {
                            // Convert the characters to string.
                            [arrDataRow addObject:[NSString  stringWithUTF8String:dbDataAsChars]];
                        }
                        
                        // Keep the current column name.
                        if (self.arrColumnNames.count != totalColumns) {
                            dbDataAsChars = (char *)sqlite3_column_name(compiledStatement, i);
                            [self.arrColumnNames addObject:[NSString stringWithUTF8String:dbDataAsChars]];
                        }
                    }
                    
                    // Store each fetched data row in the results array, but first check if there is actually data.
                    if (arrDataRow.count > 0) {
                        [self.arrResults addObject:arrDataRow];
                    }
                }
            }
            else {
                // This is the case of an executable query (insert, update, ...).
                
                // Execute the query.
                //BOOL executeQueryResults = sqlite3_step(compiledStatement);
                if (sqlite3_step(compiledStatement)) {
                    // Keep the affected rows.
                    self.affectedRows = sqlite3_changes(sqlite3Database);
                    
                    // Keep the last inserted row ID.
                    self.lastInsertedRowID = sqlite3_last_insert_rowid(sqlite3Database);
                }
                else {
                    // If could not execute the query show the error message on the debugger.
                    NSLog(@"DB Error: %s", sqlite3_errmsg(sqlite3Database));
                }
            }
        }
        else {
            // In the database cannot be opened then show the error message on the debugger.
            NSLog(@"%s", sqlite3_errmsg(sqlite3Database));
        }
        
        // Release the compiled statement from memory.
        sqlite3_finalize(compiledStatement);
        
    }
    
    // Close the database.
    sqlite3_close(sqlite3Database);
}

-(NSArray *)loadDataFromDB:(NSString *)query{
    //run the query and indicate that is not executable
    //the query string is converted to a char* object
    [self runQuery:[query UTF8String] isQueryExecutable:NO];
    
    //Returned the loaded results
    return (NSArray *)self.arrResults;
}

-(void)executeQuery:(NSString *)query{
    //run the query and indicate that is executable
    [self runQuery:[query UTF8String] isQueryExecutable:YES];
}

- (void)insertDesire:(int)desireId withStartDate:(NSString *)start andExpiryDate:(NSString *)end {
    
    // Prepare query string
    NSString *query = [NSString stringWithFormat:@"INSERT INTO aktuellebeduerfnisse VALUES ('%d', '%@', '%@')", desireId, start, end];
    
    //Execute query
    [self executeQuery:query];
    
    if (self.affectedRows != 0) {
        NSLog(@"Query was executed successfully. Affected rows = %d", self.affectedRows);
    }else{
        NSLog(@"Could not execute the query.");
    }
}

- (void)deleteDesire:(NSString *)startDate {
    
    // Prepare query string
    NSString *query = [NSString stringWithFormat:@"DELETE FROM aktuellebeduerfnisse WHERE startDate = '%@'", startDate];
    
    //Execute query
    [self executeQuery:query];
    
    if (self.affectedRows != 0) {
        NSLog(@"Query was executed successfully. Affected rows = %d", self.affectedRows);
    }else{
        NSLog(@"Could not execute the query.");
    }
}

- (NSArray *)readDesires;
{
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM aktuellebeduerfnisse"];
    NSArray *result = [self loadDataFromDB:query];
    return result;
}

- (NSArray *)readPirates;
{
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM piraten"];
    NSArray *result = [self loadDataFromDB:query];
    NSLog(@"PIRATEN Eintraege: ");
    NSLog(@"%@", result);
    return result;
}

- (NSArray *)readStorage;
{
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM lager"];
    NSArray *result = [self loadDataFromDB:query];
    NSLog(@"STORAGE Eintraege: ");
    NSLog(@"%@", result);
    return result;
}

-(void)savePirates:(int)newLifes newLvl:(int)newLvl newAlcLvl:(int)newAlcLvl{
    //prepare query string
    NSString *query = [NSString stringWithFormat:@"update piraten set leben = '%d', level = '%d', pegel = '%d'", newLifes, newLvl, newAlcLvl];
    
    //Execute query
    [self executeQuery:query];
    
    if (self.affectedRows != 0) {
        NSLog(@"Query was executed successfully. Affected rows = %d", self.affectedRows);
    }else{
        NSLog(@"Could not execute the query.");
    }
}

-(void)saveStorage:(int)newAmount newColumn:(const char *)newColumn{
    //prepare query string
    NSString *query = [NSString stringWithFormat:@"update lager set anzahl = '%d' where name = '%s'", newAmount, newColumn];
    
    //Execute query
    [self executeQuery:query];
    
    if (self.affectedRows != 0) {
        NSLog(@"Query was executed successfully. Affected rows = %d", self.affectedRows);
    }else{
        NSLog(@"Could not execute the query.");
    }
}

//Generates a new Pirate with pre defined values and a given name
- (void)newPlayerDatas:(NSString *) pirateName {
    [self generatePirate:pirateName];
    [self generateStorage];
}

-(void)generatePirate:(NSString *) pirateName{
    NSString *query = [NSString stringWithFormat:@"INSERT INTO piraten values(1, '%@', '%d', '%d', '%d')", pirateName, LIFES_AMOUNT, LEVEL_AMOUNT, ALCLVL_AMOUNT];
    [self executeQuery:query];
}

//ToDo: schoener machen
-(void)generateStorage{
    NSString *query = [NSString stringWithFormat:@"INSERT INTO lager values(1, 'food', '%d', '%d')", FOOD_AMOUNT, FOOD_PRICE];
    [self executeQuery:query];
    
    query = [NSString stringWithFormat:@"INSERT INTO lager values(2, 'drinks', '%d', '%d')", DRINKS_AMOUNT, DRINKS_PRICE];
    [self executeQuery:query];
    
    query = [NSString stringWithFormat:@"INSERT INTO lager values(3, 'rum', '%d', '%d')", RUM_AMOUNT, RUM_PRICE];
    [self executeQuery:query];
    
    query = [NSString stringWithFormat:@"INSERT INTO lager values(4, 'fruits', '%d', '%d')", FRUITS_AMOUNT, FRUITS_PRICE];
    [self executeQuery:query];
    
    query = [NSString stringWithFormat:@"INSERT INTO lager values(5, 'money', '%d', '%d')", MONEY_AMOUNT, MONEY_PRICE];
    [self executeQuery:query];
}

//Checks if a player is currently in the database
- (BOOL)checkPlayerExisting{
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM piraten"];
    NSArray *result = [self loadDataFromDB:query];
    if(result != NULL){
        return true;
    }else{
        return false;
    }
}

@end
