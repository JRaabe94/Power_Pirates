//
//  DeveloperViewController.m
//  Power_Pirates
//
//  Created by Codecamp on 26.07.18.
//  Copyright © 2018 Codecamp. All rights reserved.
//

#import "DeveloperViewController.h"
#import "Desires.h"
#import "Storage.h"
#import "AppDelegate.h"
#import "Pirates.h"
#import "TypeDef.h"

@interface DeveloperViewController ()

@property Pirates *pirat;
@property Storage *storage;
@property AppDelegate *appDelegate;

@end

@implementation DeveloperViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self viewInitiateSetup];
}

// this Method will be called everytime the main View is opened
- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self viewLoadSetup];
}

- (void) viewInitiateSetup {
    _appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    _pirat = _appDelegate.pirate;
    _storage = [[Storage alloc] init];
    [_storage loadData];
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
    NSLog(@"Nächstes Bedürfnis wird in 3s aktiv");
    [Desires activateNextDesire];
}

- (IBAction)onThirstyButton:(id)sender {
    NSLog(@"Durst in 30s mit 20s Zeit erstellt");
    [Desires createDesire:1 withTimer:30 andExpiryDate:50];
}

- (IBAction)onFulfilButton:(id)sender {
    NSLog(@"Button kann gelöscht werden");
}

- (IBAction)onLevelUpButton:(id)sender {
    if(_pirat.level <= 4) {
        [_pirat gainLevel];
        NSLog(@"Level wurde um 1 erhöht");
    }
}

- (IBAction)onLooseLifeButton:(id)sender {
    [_pirat looseLife];
    NSLog(@"1 Leben verloren");
}

- (IBAction)onGetGoldButton:(id)sender {
    for (int i = 0; i < 10; i++) {
        [_storage give:MONEY];
    }
    NSLog(@"10 Gold bekommen");
}

- (IBAction)onGainXPButton:(id)sender {
    [_pirat gainEP];
    NSLog(@"Erfahrungspunkte bekommen");
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
