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

@property (nonatomic, strong) DBManager *dbManager;

@end

@implementation Desires

+ (void)createDesire:(int)desireId withTimer:(int)time;
{
    // Create a Push-notification
    [NotificationManager createPushNotification:@"Ich will essen" withTimer:time];
    
    // Get expire-time
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd' 'HH:mm:ss"];
    NSDate *now = [NSDate date];
    NSDate *endDate = [now dateByAddingTimeInterval:time];
    NSLog(@"New Date: %@",[formatter stringFromDate:endDate]);
    
    // Add desire to DB
    // [Desires insertDesire:desireId withTimer:[formatter stringFromDate:endDate]];
}

- (void)insertDesire:(int)desireId withTimer:(NSString *)time;
{
    
    // Prepare query string
    NSString *query = [NSString stringWithFormat:@"INSERT INTO aktuellebeduerfnisse VALUES ('%d', '%@')", desireId, time];
    
    //Execute query
    [self.dbManager executeQuery:query];
    
    if (self.dbManager.affectedRows != 0) {
        NSLog(@"Query was executed successfully. Affected rows = %d", self.dbManager.affectedRows);
    }else{
        NSLog(@"Could not execute the query.");
    }
}

@end
