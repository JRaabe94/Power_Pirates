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
    // Load images
    NSArray *imageNames = @[@"island_1", @"island_2", @"island_3", @"island_4",
                            @"island_5", @"island_6", @"island_7", @"island_8",
                            @"island_9", @"island_10"];
    
    NSMutableArray *images = [[NSMutableArray alloc] init];
    for (int i = 0; i < imageNames.count; i++) {
        [images addObject:[UIImage imageNamed:[imageNames objectAtIndex:i]]];
    }
    
    // Normal Animation
    UIImageView *animationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 420, 700)];
    animationImageView.animationImages = images;
    animationImageView.animationDuration = 8;
    
    [self.view addSubview:animationImageView];
    [self.view sendSubviewToBack:animationImageView];
    [animationImageView startAnimating];
    
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
