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

+ (void)createDesire:(int)desireId withTimer:(int)time andExpiryDate:(int)expiry;
{
    // Create a Push-notification
    [NotificationManager createPushNotification:@"Ich will essen" withTimer:time];
    [NotificationManager createPushNotification:@"Ich bin verhungert :(" withTimer:expiry];
    
    // Get expiry date
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd' 'HH:mm:ss"];
    NSDate *now = [NSDate date];
    NSDate *expiryDate = [now dateByAddingTimeInterval:expiry];
    NSLog(@"Expiry Date: %@",[formatter stringFromDate:expiryDate]);
    
    // Add desire to DB
    DBManager *dbManager = [[DBManager alloc] init];
    dbManager = [dbManager initWithDatabaseFilename:@"piratendb.sql"];
    [dbManager insertDesire:desireId withTimer:[formatter stringFromDate:expiryDate]];
}

+ (void)checkStatus;
{
    NSDate *now = [NSDate date];
    DBManager *dbManager = [[DBManager alloc] init];
    dbManager = [dbManager initWithDatabaseFilename:@"piratendb.sql"];
    NSArray *desires = [dbManager readDesires];
    NSLog(@"%@", desires);
}

@end
