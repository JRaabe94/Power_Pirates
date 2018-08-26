//
//  AppDelegate.m
//  Power_Pirates
//
//  Created by Codecamp on 23.07.18.
//  Copyright © 2018 Codecamp. All rights reserved.
//

#import "AppDelegate.h"
#import "Pirates.h"
#import "DBManager.h"
#import "Storage.h"
#import "Desires.h"
#import "NotificationManager.h"
#import "GameOverViewController.h"

@interface AppDelegate ()

@property NSTimer *gl;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIStoryboard *storyboard = [self grabStoryboard];
    
    // change storyboard
    self.window.rootViewController = [storyboard instantiateInitialViewController];
    [self.window makeKeyAndVisible];
    
    NSString *music = [[NSBundle mainBundle]pathForResource:@"Music" ofType:@"mp3"];
    audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:music] error:NULL];
    audioPlayer.delegate = self;
    audioPlayer.numberOfLoops = -1;
    [audioPlayer play];
    
    // Override point for customization after application launch.
   return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [_pirate saveData];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    [_pirate saveData];
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//change Storyboard depends if there is a charakter
- (UIStoryboard *)grabStoryboard {
    self.dbManager = [[DBManager alloc] init];
    self.dbManager = [self.dbManager initWithDatabaseFilename:@"piratendb.sql"];
    
    UIStoryboard *storyboard;
    
    if([self.dbManager checkIfPlayerExists]){
        storyboard = [UIStoryboard storyboardWithName:@"Main2" bundle:nil];
    } else {
        storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    }
    return storyboard;
}

- (void)initGame {
    self.pirate = [[Pirates alloc] init];
    [self.pirate loadData];
    
    self.storage = [[Storage alloc] init];
    [self.storage loadData];
    
    self.gl = [NSTimer scheduledTimerWithTimeInterval:0.5
                                     target:self
                                   selector:@selector(gameLoop)
                                   userInfo:nil
                                    repeats:YES];}

- (void)gameLoop {
//    NSLog(@"---Fire---");
    [Desires checkStatus];
    if (self.pirate.lifes < 1) {
        [self loose];
    }
}

// Has to be called from gameLoop, when player has no life left
- (void)loose {
    [self.dbManager cleanDatabase];
    [NotificationManager cleanPushNotifications];
    [self.gl invalidate];
    //ToDo: Piraten erstellen Screen laden
    
    // Override point for customization after application launch.
    
    // Change viewController when pirat is deads
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    GameOverViewController *gameOverViewController = (GameOverViewController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"GameOverViewControllerID"];
    self.window.rootViewController = gameOverViewController;
}

@end
