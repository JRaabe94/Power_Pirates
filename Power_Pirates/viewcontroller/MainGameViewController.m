//
//  MainGameViewController.m
//  Power_Pirates
//
//  Created by Codecamp on 25.07.18.
//  Copyright © 2018 Codecamp. All rights reserved.
//

#import "MainGameViewController.h"

@interface MainGameViewController ()

@end

@implementation MainGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Load images
    NSArray *imageNames = @[@"island/island_1.png", @"island/island_2.png", @"island/island_3.png", @"island/island_4.png",
                            @"island/island_5.png", @"island/island_6.png", @"island/island_7.png", @"island/island_8.png",
                            @"island/island_9.png", @"island/island_10.png"];
    
    NSMutableArray *images = [[NSMutableArray alloc] init];
    for (int i = 0; i < imageNames.count; i++) {
        [images addObject:[UIImage imageNamed:[imageNames objectAtIndex:i]]];
    }
    
    // Normal Animation
    UIImageView *animationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 420, 700)];
    animationImageView.animationImages = images;
    animationImageView.animationDuration = 8;
    
    [self.view addSubview:animationImageView];
    [animationImageView startAnimating];
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
