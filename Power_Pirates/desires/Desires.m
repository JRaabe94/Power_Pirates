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

@interface Desires()

@end

@implementation Desires

+ (void)createDesire:(int)desireId withTimer:(int)timer andExpiryDate:(int)expiry
{
    NSArray *desireText = [NSArray arrayWithObjects:@"Ich will essen.", @"Ich will trinken", @"Ich will saufen", @"Ich kriege gleich Skorbut", nil];
    
    // Get dates
    NSDate *startDate = [NSDate dateWithTimeIntervalSinceNow:timer];
    NSDate *expiryDate = [NSDate dateWithTimeIntervalSinceNow:expiry];
    
    // Create push notifications
    [NotificationManager createPushNotification:desireText[desireId] withTimer:startDate];
    [NotificationManager createPushNotification:@"Ich bin tot :(" withTimer:expiryDate];

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:DATE_FORMAT];
    
    // Add desire to DB
    DBManager *dbManager = [[DBManager alloc] init];
    dbManager = [dbManager initWithDatabaseFilename:@"piratendb.sql"];
    [dbManager insertDesire:desireId withStartDate:[formatter stringFromDate:startDate] andExpiryDate:[formatter stringFromDate:expiryDate]];
}

+ (void)removeDesire:(NSDate *)time
{
    DBManager *dbManager = [[DBManager alloc] init];
    dbManager = [dbManager initWithDatabaseFilename:@"piratendb.sql"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:DATE_FORMAT];
    [dbManager deleteDesire:[formatter stringFromDate:time]];
    [NotificationManager removePushNotification:time];
}

+ (void)checkStatus
{
    NSDate *now = [NSDate date];
    DBManager *dbManager = [[DBManager alloc] init];
    dbManager = [dbManager initWithDatabaseFilename:@"piratendb.sql"];
    NSArray *desires = [dbManager readDesires];
    NSMutableArray *delete = [[NSMutableArray alloc] init];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:DATE_FORMAT];
    for (NSInteger i = 0; i < [desires count]; i++) {
        NSDate *startDate = [formatter dateFromString: desires[i][1]];
        NSDate *expiryDate = [formatter dateFromString: desires[i][2]];
        NSLog(@"%@", startDate);
        NSLog(@"%@", expiryDate);
        if ([startDate compare:now] == NSOrderedSame || [startDate compare:now] == NSOrderedAscending) {
            NSLog(@"Aufgabe ist aktiv");
        }
        if ([expiryDate compare:now] == NSOrderedSame || [expiryDate compare:now] == NSOrderedAscending) {
            NSLog(@"Aufgabe ist abgelaufen!!");
            [delete addObject:startDate];
        }
    }

    // Delete expired desires
    for (NSDate *date in delete) {
        [dbManager deleteDesire:[formatter stringFromDate:date]];
    }
}

@end
