//
//  StockViewController.m
//  Power_Pirates
//
//  Created by Codecamp on 25.07.18.
//  Copyright © 2018 Codecamp. All rights reserved.
//

#import "StockViewController.h"
#import "GameOverViewController.h"

@interface StockViewController ()

@end

@implementation StockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Method to directly go to the GameOver Screen
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    GameOverViewController *viewController = (GameOverViewController *)[storyboard instantiateViewControllerWithIdentifier:@"GameOverViewControllerID"];
    [self presentViewController:viewController animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
