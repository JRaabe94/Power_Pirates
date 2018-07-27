//
//  ExploreMinigameViewController.m
//  Power_Pirates
//
//  Created by Codecamp on 24.07.18.
//  Copyright © 2018 Codecamp. All rights reserved.
//

#import "ExploreMinigameViewController.h"

@import CoreMotion;

@interface ExploreMinigameViewController ()

@property (nonatomic) CMPedometer *pedometer;

@property (nonatomic) int stepCount;

-(void)updateCounter:(CMPedometerData *)pedometerData;

-(BOOL)checkWin;

@end

int stepsNeeded = 0;

@implementation ExploreMinigameViewController

- (void)viewDidLoad {
    stepsNeeded = 500;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onBackButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onStartButton:(id)sender {
    NSLog(@"Gestartet");
    //live tracking start
    [self.pedometer startPedometerUpdatesFromDate:[NSDate date] withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
       //called for each live update
        [self updateCounter:pedometerData];
    }];
}

-(void)updateCounter:(CMPedometerData *)pedometerData{
    //Formatter for cutting the data
    //NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    if([CMPedometer isStepCountingAvailable]){
        self.stepCount = [[pedometerData numberOfSteps] intValue];
        NSLog(@"%d", self.stepCount);
    }
    if([self checkWin]){
        [self.pedometer stopPedometerUpdates];
        NSLog(@"Geschafft!");
    }
}

-(BOOL)checkWin{
    if(self.stepCount > stepsNeeded){
        return true;
    }else{
        return false;
    }
}

-(CMPedometer *) pedometer{
    if(!_pedometer){
        _pedometer = [[CMPedometer alloc] init];
    }
    return _pedometer;
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
