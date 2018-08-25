//
//  Desires.h
//  Power_Pirates
//
//  Created by Codecamp on 24.07.18.
//  Copyright © 2018 Codecamp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Desires : NSObject

/**
 * Creates a new desire
 *
 * @param desireId Displayed Text
 * @param timer Time when the desire starts
 * @param expiry Time when the desire expires
 */
+ (void)createDesire:(NSInteger)desireId withTimer:(NSInteger)timer andExpiryDate:(NSInteger)expiry;

/**
 * Removes the desire starting at the given time
 *
 * @param time The starting time of the desire (id)
 */
+ (void)removeDesire:(NSDate *)time;

/**
 * Returns the active desire or NULL if there is no
 *
 * @return NSArray with desire id, start date and expiry date
 */
+ (NSArray *)getActiveDesire;

+ (void)activateNextDesire;

+ (void)expireActiveDesire;

/**
 * Fulfills the active desire if the item is correct and removes the item from the storage
 *
 * @param givenDesireId The id of the given item
 */
+ (void)fulfilDesire:(NSInteger)givenDesireId;

/**
 * Fills the desire queue
 */
+ (void)fillDesires;

/**
 * Removes expired desires and reduces life
 */
+ (void)checkStatus;

@end
