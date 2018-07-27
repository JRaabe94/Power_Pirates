//
//  StockViewController.m
//  Power_Pirates
//
//  Created by Codecamp on 25.07.18.
//  Copyright © 2018 Codecamp. All rights reserved.
//

#import "StockViewController.h"
#import "GameOverViewController.h"
#import "Pirates.h"
#import "Storage.h"
#include <stdlib.h>

@interface StockViewController ()

@property Pirates *pirat;
@property Storage *storage;

@end

@implementation StockViewController

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
    // Do any additional setup after loading the view.
    // Load images
    NSArray *imageNames = @[@"Storage_1", @"Storage_2", @"Storage_3"];
    
    NSMutableArray *images = [[NSMutableArray alloc] init];
    for (int i = 0; i < imageNames.count; i++) {
        [images addObject:[UIImage imageNamed:[imageNames objectAtIndex:i]]];
    }
    
    // Normal Animation
    UIImageView *animationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 420, 700)];
    animationImageView.animationImages = images;
    animationImageView.animationDuration = 1;
    
    [self.view addSubview:animationImageView];
    [self.view sendSubviewToBack:animationImageView];
    [animationImageView startAnimating];
    
    
    UIImage *barrelImg1 = [UIImage imageNamed:@"barrel"];
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(204, 378, 100, 100)];
    imageView1.image = barrelImg1;
    [self.view addSubview:imageView1];
    
    UIImage *boxImg1 = [UIImage imageNamed:@"box"];
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(284, 401, 100, 100)];
    imageView2.image = boxImg1;
    [self.view addSubview:imageView2];
    
    UIImage *boxImg2 = [UIImage imageNamed:@"box"];
    UIImageView *imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 418, 100, 100)];
    imageView3.image = boxImg2;
    [self.view addSubview:imageView3];
    
    UIImage *barrelImg2 = [UIImage imageNamed:@"barrel"];
    UIImageView *imageView4 = [[UIImageView alloc] initWithFrame:CGRectMake(334, 420, 100, 100)];
    imageView4.image = barrelImg2;
    imageView4.transform = CGAffineTransformMakeRotation((M_PI_2)*-1);
    [self.view addSubview:imageView4];
    
    
    // Method to directly go to the GameOver Screen
    /*UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
     GameOverViewController *viewController = (GameOverViewController *)[storyboard instantiateViewControllerWithIdentifier:@"GameOverViewControllerID"];
     [self presentViewController:viewController animated:YES completion:nil];*/
    
    _storage = [[Storage alloc] init];
    _pirat = [[Pirates alloc] init];
    [_pirat loadData];
    [_storage loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onLootButton:(id)sender {

    int randomValue = arc4random_uniform(101); // create Random Number
    int numberToWin;
    
    // set winchance dependend on lvl
    switch (_pirat.level) {
        case 2:
            numberToWin = 50;
            break;
        case 3:
            numberToWin = 35;
            break;
        case 4:
            numberToWin = 25;
            break;
        case 5:
            numberToWin = 15;
            break;
        default: // lvl 1
            numberToWin = 66;
            break;
    }
    
    if(randomValue >= numberToWin) {
        // get item
        int randomItem = arc4random_uniform(5);
        if(randomItem == 4) {
            // get 10 gold
            for (int i = 0; i < 10; i++) {
                [_storage give:randomItem];
            }
        } else {
            [_storage give:randomItem];
        }
        NSLog(@"Gewonnen");
    } else {
        [_pirat looseLife];
        NSLog(@"%d Leben verloren", _pirat.lifes);
    }
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
