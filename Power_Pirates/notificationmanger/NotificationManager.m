//
//  NotificationManager.m
//  Power_Pirates
//
//  Created by Codecamp on 24.07.18.
//  Copyright © 2018 Codecamp. All rights reserved.
//

#import "NotificationManager.h"
#import "ViewController.h"

@implementation NotificationManager

// Aufruf: [NotificationManager createPushNotification:@"Hallo!"];

+ (void)createPushNotification:(NSString *)message;
// Creates a Push-notification with the given message
{
    bool isGrantedNotificationAccess = true;
    if (isGrantedNotificationAccess) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        content.title = @"Power Pirates";
        // content.subtitle = @"Untertitel";
        content.body = message;
        content.sound = [UNNotificationSound defaultSound];
        
        UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:5 repeats:NO];
        
        // Setting up the request for notification
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"UYLocalNotification" content:content trigger:trigger];
        
        [center addNotificationRequest:request withCompletionHandler:nil];
    }
}

@end
