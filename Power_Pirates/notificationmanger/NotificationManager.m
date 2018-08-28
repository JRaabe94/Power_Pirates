//
//  NotificationManager.m
//  Power_Pirates
//
//  Created by Codecamp on 24.07.18.
//  Copyright © 2018 Codecamp. All rights reserved.
//

#import "NotificationManager.h"
#import "TypeDef.h"

@implementation NotificationManager

+ (void)createPushNotification:(NSString *)message withTimer:(NSDate *)time {
    __block BOOL hasAcces;
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
        hasAcces = settings.authorizationStatus == UNAuthorizationStatusAuthorized;
    }];
    
    if (hasAcces) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:DATE_FORMAT];
        NSString *newId = [formatter stringFromDate:time];
        NSTimeInterval timer = [time timeIntervalSinceNow];
        
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        content.title = @"Power Pirates";
        content.body = message;
        content.sound = [UNNotificationSound defaultSound];
        
        UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:timer repeats:NO];
        
        // Setting up the request for notification
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:newId content:content trigger:trigger];
        [center addNotificationRequest:request withCompletionHandler:nil];
    }
}

+ (void)changeNotificationDate:(NSDate *)time newTime:(NSDate *)newTime {
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    [center getPendingNotificationRequestsWithCompletionHandler:^(NSArray<UNNotificationRequest *> * _Nonnull requests) {
        for (NSArray *o in requests) {
            NSLog(@"Message: %@", o);
        }
    }];
}

+ (void)removePushNotification:(NSDate *)time {
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:DATE_FORMAT];
    NSString *identifier = [formatter stringFromDate:time];
    [center removePendingNotificationRequestsWithIdentifiers:@[identifier]];
}

+ (void)cleanPushNotifications {
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    [center removeAllDeliveredNotifications];
    [center removeAllPendingNotificationRequests];
}

@end
