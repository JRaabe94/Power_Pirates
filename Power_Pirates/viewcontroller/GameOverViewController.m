//
//  GameOverViewController.m
//  Power_Pirates
//
//  Created by Codecamp on 25.07.18.
//  Copyright © 2018 Codecamp. All rights reserved.
//

#import "GameOverViewController.h"

@interface GameOverViewController ()

@end

@implementation GameOverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)goToRegisterButton:(id)sender {
    [self performSegueWithIdentifier:@"GameOverRegisterSegue" sender:self];
}

//*************** Test Methods ***************

- (IBAction)onNotificationButton:(id)sender {
}

- (IBAction)onHungryButton:(id)sender {
}

- (IBAction)onThirstyButton:(id)sender {
}

- (IBAction)onScurvyButton:(id)sender {
}

- (IBAction)onDeathButton:(id)sender {
}

- (IBAction)onLevelUpButton:(id)sender {
}

- (IBAction)onLooseLifeButton:(id)sender {
}

- (IBAction)onGameButton:(id)sender {
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
