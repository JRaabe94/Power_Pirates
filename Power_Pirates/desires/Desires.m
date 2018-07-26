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

@interface Desires()

@end

@implementation Desires

NSString *format = @"yyyy-MM-dd hh:mm:ss";

+ (void)createDesire:(int)desireId withTimer:(int)timer andExpiryDate:(int)expiry
{
    // Create a Push-notification
    [NotificationManager createPushNotification:@"Ich will essen" withTimer:timer];
    [NotificationManager createPushNotification:@"Ich bin verhungert :(" withTimer:expiry];
    
    // Get expiry date
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSDate *now = [NSDate date];
    NSDate *startDate = [now dateByAddingTimeInterval:timer];
    NSDate *expiryDate = [now dateByAddingTimeInterval:expiry];
    NSLog(@"Expiry Date: %@",[formatter stringFromDate:expiryDate]);
    
    // Add desire to DB
    DBManager *dbManager = [[DBManager alloc] init];
    dbManager = [dbManager initWithDatabaseFilename:@"piratendb.sql"];
    [dbManager insertDesire:desireId withStartDate:[formatter stringFromDate:startDate] andExpiryDate:[formatter stringFromDate:expiryDate]];
}

+ (void)checkStatus
{
    NSDate *now = [NSDate date];
    DBManager *dbManager = [[DBManager alloc] init];
    dbManager = [dbManager initWithDatabaseFilename:@"piratendb.sql"];
    NSArray *desires = [dbManager readDesires];
    NSLog(@"%@", desires);
    for (NSInteger i = 0; i < [desires count]; i++) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:format];
        NSDate *startDate = [formatter dateFromString: desires[i][1]];
        NSDate *expiryDate = [formatter dateFromString: desires[i][2]];
        // NSLog(@"Aufgabe Nummer %d", desires[i][1]);
        NSLog(@"%@", startDate);
        NSLog(@"%@", expiryDate);
        if ([startDate compare:now] == NSOrderedSame || [startDate compare:now] == NSOrderedAscending) {
            NSLog(@"Aufgabe ist aktiv!!");
        }
        if ([expiryDate compare:now] == NSOrderedSame || [expiryDate compare:now] == NSOrderedAscending) {
            NSLog(@"Aufgabe ist abgelaufen!!");
        }
    }
}

@end
