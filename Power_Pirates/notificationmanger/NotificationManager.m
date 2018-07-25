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

+ (void)createPushNotification:(NSString *)message withTimer:(int)time;
// Creates a Push-notification with the given message
// Aufruf: [NotificationManager createPushNotification:@"Hallo!" withTimer:10];
{
    bool isGrantedNotificationAccess = true;
    if (isGrantedNotificationAccess) {
        __block NSInteger idCounter = 0;
        __block NSInteger readyCounter;
        __block BOOL ready = NO;
        __block NSString *newId = [NSString stringWithFormat: @"notification_%ld", (long)idCounter];
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        
        while (!ready) {
            // Get existing notifications
            [center getPendingNotificationRequestsWithCompletionHandler:^(NSArray<UNNotificationRequest *> * _Nonnull requests) {
                readyCounter = 0;
                for (NSUInteger i = 0; i < requests.count; i++) {
                    UNNotificationRequest *pendingRequest = [requests objectAtIndex:i];
                    newId = [NSString stringWithFormat: @"notification_%ld", (long)idCounter];
                    if ([newId isEqualToString:pendingRequest.identifier]) {
                        idCounter++;
                    } else {
                        readyCounter++;
                    }
                }
                if (readyCounter == requests.count) {
                    ready = YES;
                }
            }];
        }
        newId = [NSString stringWithFormat: @"notification_%ld", (long)idCounter];
        NSLog(@"Id: %@", newId);
        
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        content.title = @"Power Pirates";
        content.body = message;
        content.sound = [UNNotificationSound defaultSound];
        
        UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:time repeats:NO];
        
        // Setting up the request for notification
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:newId content:content trigger:trigger];
        [center addNotificationRequest:request withCompletionHandler:nil];
    }
}

@end
