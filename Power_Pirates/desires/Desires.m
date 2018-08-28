//
//  Desires.m
//  Power_Pirates
//
//  Created by Codecamp on 24.07.18.
//  Copyright © 2018 Codecamp. All rights reserved.
//

#import "Desires.h"
#import "NotificationManager.h"
#import "DBManager.h"
#import "TypeDef.h"
#import "AppDelegate.h"
#import "Pirates.h"

@interface Desires()

@end

@implementation Desires

+ (void)createDesire:(NSInteger)desireId withTimer:(NSInteger)timer andExpiryDate:(NSInteger)expiry
{
    NSArray *desireText = @[@"Ich will essen.", @"Ich will trinken", @"Ich will saufen", @"Ich kriege gleich Skorbut"];
    
    // Get dates
    NSDate *startDate = [NSDate dateWithTimeIntervalSinceNow:timer];
    NSDate *expiryDate = [NSDate dateWithTimeIntervalSinceNow:expiry];
    
    // Create push notifications
    [NotificationManager createPushNotification:desireText[desireId] withTimer:startDate];
    [NotificationManager createPushNotification:@"Ein Leben verloren :(" withTimer:expiryDate];

    // Create date-string formatter
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:DATE_FORMAT];
    
    // Add desire to DB
    DBManager *dbManager = [[DBManager alloc] init];
    dbManager = [dbManager initWithDatabaseFilename:@"piratendb.sql"];
    [dbManager insertDesire:desireId withStartDate:[formatter stringFromDate:startDate] andExpiryDate:[formatter stringFromDate:expiryDate]];
}

+ (void)removeDesire:(NSDate *)time
{
    // Delete desire from DB
    DBManager *dbManager = [[DBManager alloc] init];
    dbManager = [dbManager initWithDatabaseFilename:@"piratendb.sql"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:DATE_FORMAT];
    [dbManager deleteDesire:[formatter stringFromDate:time]];
}

+ (NSArray *)getActiveDesire
{
    // Read from DB
    DBManager *dbManager = [[DBManager alloc] init];
    dbManager = [dbManager initWithDatabaseFilename:@"piratendb.sql"];
    NSArray *desires = [dbManager readDesires];
    
    // Create date-string formatter
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:DATE_FORMAT];
    
    NSNumber *desireId;
    NSDate *startDate;
    NSDate *expiryDate;
    NSDate *now = [NSDate date];
    
    for (NSInteger i = 0; i < [desires count]; i++) {
        desireId = desires[i][0];
        startDate = [formatter dateFromString: desires[i][1]];
        expiryDate = [formatter dateFromString: desires[i][2]];
        if ([startDate compare:now] == NSOrderedSame || [startDate compare:now] == NSOrderedAscending) {
            if (!([expiryDate compare:now] == NSOrderedSame || [expiryDate compare:now] == NSOrderedAscending)) {
                // Active desire found
                break;
            }
        }
        // No active desire
        desireId = NULL;
        startDate = NULL;
        expiryDate = NULL;
    }
    
    // Create return value
    NSArray *result = [NSArray arrayWithObjects:desireId, startDate, expiryDate, nil];
    if ([result count] == 0) {
        result = NULL;
    }
    return result;
}

+ (void)activateNextDesire
{
    // Read from DB
    DBManager *dbManager = [[DBManager alloc] init];
    dbManager = [dbManager initWithDatabaseFilename:@"piratendb.sql"];
    NSArray *desires = [dbManager readDesires];
    
    // Create date-string formatter
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:DATE_FORMAT];
    
    // Log desires before change
    NSLog(@"Number of desires: %lu", (unsigned long)[desires count]);
    for (int i = 0; i < [desires count]; i++) {
        NSLog(@"Type of desire %d: %@", i + 1, desires[i][1]);
    }
    
    NSDate *firstDate = [NSDate distantFuture];
    NSDate *startDate;
    
    // Determine next desire
    for (NSInteger i = 0; i < [desires count]; i++) {
        startDate = [formatter dateFromString: desires[i][1]];
        if ([startDate compare:firstDate] == NSOrderedAscending) {
            firstDate = startDate;
         }
     }
    
    NSDate *soon = [NSDate dateWithTimeIntervalSinceNow:3];
    if ([firstDate compare:soon] == NSOrderedDescending) {
        // The next desire's start date is changed
        NSString *query = [NSString stringWithFormat:@"update aktuellebeduerfnisse set startdate = '%@' where startdate = '%@'",
                           [formatter stringFromDate:soon], [formatter stringFromDate:firstDate]];
        [dbManager executeQuery:query];
        
        // The Push Notification is changed
        [NotificationManager changeNotificationDate:firstDate newTime:startDate];
    }
}

+ (void)expireActiveDesire
{
    NSArray *active = [self getActiveDesire];
    if (active == NULL) {
        NSLog(@"Kein aktives Bedürfnis");
    } else {
        NSLog(@"Aktives Bedürfnis: %@", active[0]);
    }
}

+ (void)fulfilDesire:(NSInteger)givenDesireId
{
    // Read from DB
    DBManager *dbManager = [[DBManager alloc] init];
    dbManager = [dbManager initWithDatabaseFilename:@"piratendb.sql"];
    NSArray *storage = [dbManager readStorage];
    NSNumber *amount = storage[givenDesireId][2];
    if ([amount integerValue] < 1) {
        // Not enough in storage
        NSLog(@"Not enough in storage");
        return;
    }
    [dbManager updateStorageField:(int)givenDesireId+1 newAmount:(int)[amount integerValue] - 1];
    
    NSArray *desire = [self getActiveDesire];
    if ([desire count] != 0) {
        NSInteger desireId = [desire[0] integerValue];
        NSDate *startDate = desire[1];
        NSDate *expiryDate = desire[2];
        if (givenDesireId == desireId) {
            NSLog(@"Bedürfnis erfüllt");
            [self removeDesire:startDate];
            [NotificationManager removePushNotification:expiryDate];
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            [appDelegate.pirate gainEP];
        } else {
            NSLog(@"Falsches Bedürfnis!");
        }
    }
}

+ (void)failDesire:(NSDate *)time {
    DBManager *dbManager = [[DBManager alloc] init];
    dbManager = [dbManager initWithDatabaseFilename:@"piratendb.sql"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:DATE_FORMAT];
    
    // Delete desire from DB
    [dbManager deleteDesire:[formatter stringFromDate:time]];
    // Lose 1 life
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.pirate looseLife];
}

+ (void)initDesires {
    NSDate *now = [NSDate date];
    // Read from DB
    DBManager *dbManager = [[DBManager alloc] init];
    dbManager = [dbManager initWithDatabaseFilename:@"piratendb.sql"];
    
    // Create date-string formatter
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:DATE_FORMAT];
    
    NSArray *desires = [dbManager readDesires];
    NSMutableArray *dates = [[NSMutableArray alloc] init];
    NSInteger counter = [desires count];
    
    // Fill and sort array
    for (NSArray *x in desires) {
        [dates addObject:[formatter dateFromString:x[2]]];
    }
    [dates addObject:now];
    [dates sortUsingSelector:@selector(compare:)];
    NSDate *lastDate = [dates lastObject];
    NSInteger offset = [lastDate timeIntervalSinceNow];
    if (offset < 0) {
        offset = 0;
    }
    
    // Add new desires
    for (NSInteger i = counter; i < N_DESIRES; i++) {
        NSInteger randomId = arc4random_uniform(4);
        NSInteger randomTimer = offset + MIN_TIME_BETWEEN_DESIRES + arc4random_uniform(MAX_TIME_BETWEEN_DESIRES - MIN_TIME_BETWEEN_DESIRES);
        NSInteger randomExpiryDate = randomTimer + MIN_TIME_TO_FAIL + arc4random_uniform(MAX_TIME_TO_FAIL - MIN_TIME_TO_FAIL);
        [self createDesire:randomId withTimer:randomTimer andExpiryDate:randomExpiryDate];
        offset = randomExpiryDate;
    }
    
//    NSLog(@"%@", dates);
}

+ (void)checkStatus
{
    //Read from DB
    NSDate *now = [NSDate date];
    DBManager *dbManager = [[DBManager alloc] init];
    dbManager = [dbManager initWithDatabaseFilename:@"piratendb.sql"];
    NSArray *desires = [dbManager readDesires];
    NSMutableArray *delete = [[NSMutableArray alloc] init];  // Array of all expired Desires
    
    // Create date-string formatter
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:DATE_FORMAT];
    for (NSInteger i = 0; i < [desires count]; i++) {
        // Check if desire is expired
        NSDate *startDate = [formatter dateFromString: desires[i][1]];
        NSDate *expiryDate = [formatter dateFromString: desires[i][2]];
        if ([expiryDate compare:now] == NSOrderedSame || [expiryDate compare:now] == NSOrderedAscending) {
            NSLog(@"Aufgabe ist abgelaufen!!");
            [delete addObject:startDate];
        }
    }

    // Fail expired desires
    for (NSDate *date in delete) {
        [self failDesire:date];
    }
}

@end
