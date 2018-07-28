//
//  NotificationManager.h
//  Power_Pirates
//
//  Created by Codecamp on 24.07.18.
//  Copyright © 2018 Codecamp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UserNotifications/UserNotifications.h>

@interface NotificationManager : NSObject

/**
 * Creates a new push notification
 *
 * @param message Displayed Text
 * @param time Time when the message appears
 */
+ (void)createPushNotification:(NSString *)message withTimer:(NSDate *)time;

/**
 * Removes one pending push notification
 *
 * @param time Time when the message appears (id)
 */
+ (void)removePushNotification:(NSDate *)time;

/**
 * Deletes all pending notifications and clears the notification center
 */
+ (void)cleanPushNotifications;

@end
