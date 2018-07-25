//
//  AppDelegate.h
//  Power_Pirates
//
//  Created by Codecamp on 23.07.18.
//  Copyright © 2018 Codecamp. All rights reserved.
//
//

#import <UIKit/UIKit.h>
@class Storage;
@class Pirates;
@class DBManager;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property DBManager *dbManager;
@property Storage *storage;
@property Pirates *pirat;

- (void) initGame;

@end

