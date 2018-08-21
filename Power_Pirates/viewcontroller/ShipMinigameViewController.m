//
//  ShipMinigameViewController.m
//  Power_Pirates
//
//  Created by Codecamp on 24.07.18.
//  Copyright © 2018 Codecamp. All rights reserved.
//

#import "ShipMinigameViewController.h"
#import "ShipWelcomeScene.h"


@interface ShipMinigameViewController ()

@end

@implementation ShipMinigameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    SKView *skView = (SKView *) self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    // create welcome Scene before playing
    ShipWelcomeScene *welcome = [[ShipWelcomeScene alloc]
                        initWithSize:CGSizeMake(skView.bounds.size.width,
                        skView.bounds.size.height)];
    
    [skView presentScene:welcome];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onBackButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
