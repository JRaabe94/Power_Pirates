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

+ (void)createPushNotification:(NSString *)message withTimer:(NSDate *)time;

+ (void)removePushNotification:(NSDate *)time;

+ (void)cleanPushNotifications;

@end
