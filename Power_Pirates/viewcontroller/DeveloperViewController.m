//
//  DeveloperViewController.m
//  Power_Pirates
//
//  Created by Codecamp on 26.07.18.
//  Copyright © 2018 Codecamp. All rights reserved.
//

#import "DeveloperViewController.h"
#import "Desires.h"

@interface DeveloperViewController ()

@end

@implementation DeveloperViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self viewLoadSetup];
}

// this Method will be called everytime the main View is opened
- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self viewLoadSetup];
}

- (void) viewLoadSetup {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onScurvyButton:(id)sender {
    NSLog(@"Viel Skorbut erstellt");
    [Desires createDesire:3 withTimer:4 andExpiryDate:8];
    [Desires createDesire:3 withTimer:12 andExpiryDate:16];
    [Desires createDesire:3 withTimer:20 andExpiryDate:24];
    [Desires createDesire:3 withTimer:28 andExpiryDate:32];
}

- (IBAction)onHungerButton:(id)sender {
    NSLog(@"Hunger in 10s mit 10s Zeit erstellt");
    [Desires createDesire:0 withTimer:10 andExpiryDate:20];
}

- (IBAction)onThirstyButton:(id)sender {
    NSLog(@"Durst in 30s mit 20s Zeit erstellt");
    [Desires createDesire:1 withTimer:30 andExpiryDate:50];
}

- (IBAction)onFulfilButton:(id)sender {
    NSLog(@"Button kann gelöscht werden");
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
