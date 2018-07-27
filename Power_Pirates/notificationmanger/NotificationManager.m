//
//  NotificationManager.m
//  Power_Pirates
//
//  Created by Codecamp on 24.07.18.
//  Copyright © 2018 Codecamp. All rights reserved.
//

#import "NotificationManager.h"
#import "ViewController.h"
#import "TypeDef.h"

@implementation NotificationManager

+ (void)createPushNotification:(NSString *)message withTimer:(NSDate *)time
// Creates a Push-notification with the given message that appears at the given time
{
    bool isGrantedNotificationAccess = true;
    if (isGrantedNotificationAccess) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:DATE_FORMAT];
        NSString *newId = [formatter stringFromDate:time];
        NSTimeInterval timer = [time timeIntervalSinceNow];
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        NSLog(@"Id: %@", newId);
        
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

+ (void)removePushNotification:(NSDate *)time
{
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:DATE_FORMAT];
    NSString *identifier = [formatter stringFromDate:time];
    [center removePendingNotificationRequestsWithIdentifiers:@[identifier]];
}

@end
