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
+ (void)createDesire:(NSInteger)desireId withStartTimer:(NSInteger)timer andExpiryTimer:(NSInteger)expiry;

/**
 * Removes the desire starting at the given time and deletes its push notifications
 *
 * @param time The starting time of the desire (id)
 */
+ (void)removeDesire:(NSDate *)time;

/**
 * Returns the active desire or NULL if there is no
 *
 * @return NSArray with NSNumber desireId, NSDate startDate and NSDate expiryDate
 */
+ (NSArray *)getActiveDesire;

/**
 * The next desire starts in 3 seconds if there is no active
 * or earlier desire
 */
+ (void)activateNextDesire;

/**
 * The active desire expires in 5 seconds. If there is no
 * active desire, nothing happens.
 */
+ (void)expireActiveDesire;

/**
 * Fulfills the active desire if the item is correct and
 * removes the item from the storage (even if the item is
 * not correct)
 *
 * @param givenDesireId The id of the given item
 *
 * @return 0: success, 1: Not enough in storage, 2: wrong desire
 */
+ (NSInteger)fulfillDesire:(NSInteger)givenDesireId;

/**
 * Initialises the desire queue
 */
+ (void)initDesires;

/**
 * Removes expired desires and reduces life
 */
+ (void)checkStatus;

@end
