//
//  Desires.h
//  Power_Pirates
//
//  Created by Codecamp on 24.07.18.
//  Copyright © 2018 Codecamp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Desires : NSObject

+ (void)createDesire:(NSInteger)desireId withTimer:(NSInteger)timer andExpiryDate:(NSInteger)expiry;

+ (void)removeDesire:(NSDate *)time;

+ (NSArray *)getActiveDesire;

+ (void)fulfilDesire:(NSInteger)givenDesireId;

+ (void)fillDesires;

+ (void)checkStatus;

@end
