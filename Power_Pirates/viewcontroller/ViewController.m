//
//  ViewController.m
//  Power_Pirates
//
//  Created by Codecamp on 23.07.18.
//  Copyright © 2018 Codecamp. All rights reserved.
//

#import "ViewController.h"
#import "NotificationManager.h"

@interface ViewController ()

@end

bool isGrantedNotificationAccess;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Ask for push notification permission
    isGrantedNotificationAccess = false;
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    UNAuthorizationOptions options = UNAuthorizationOptionAlert + UNAuthorizationOptionSound;
    [center requestAuthorizationWithOptions:options completionHandler:^(BOOL granted, NSError * _Nullable error) {
        isGrantedNotificationAccess = granted;
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)startGame:(id)sender {
    NSString *enteredText = [_charName text];
    NSLog(@"Value of Input = %@", enteredText);
}

- (IBAction)onStartButton:(id)sender {
    [self performSegueWithIdentifier:@"ViewControllerMainGameSegue" sender:self];
}

@end
