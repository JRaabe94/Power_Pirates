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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onScurvyButton:(id)sender {
    NSLog(@"Skorbut erstellt");
    [Desires createDesire:3 withTimer:10 andExpiryDate:13];
    [Desires createDesire:3 withTimer:20 andExpiryDate:60];
    [Desires createDesire:3 withTimer:80 andExpiryDate:99];
    [Desires createDesire:3 withTimer:100 andExpiryDate:120];
}

- (IBAction)onFulfilButton:(id)sender {
    NSLog(@"Kann gelöscht werden");
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
