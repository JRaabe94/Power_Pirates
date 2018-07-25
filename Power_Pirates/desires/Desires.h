//
//  Desires.h
//  Power_Pirates
//
//  Created by Codecamp on 24.07.18.
//  Copyright © 2018 Codecamp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Desires : NSObject

+ (void)createDesire:(int)desireId withTimer:(int)time andExpiryDate:(int)expiry;

@end
