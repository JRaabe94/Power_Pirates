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
#include "AppDelegate.h"
#import "TypeDef.h"
#include <stdlib.h>

@interface StockViewController ()

@property Pirates *pirat;
@property Storage *storage;

@property (weak, nonatomic) IBOutlet UILabel *foodLabel;
@property (weak, nonatomic) IBOutlet UILabel *fruitsLabel;
@property (weak, nonatomic) IBOutlet UILabel *drinksLabel;
@property (weak, nonatomic) IBOutlet UILabel *rumLabel;

@property (weak, nonatomic) IBOutlet UILabel *lootLabel;

@end

@implementation StockViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self viewInitiateSetup];
    [self viewLoadSetup];
}

// this Method will be called everytime the main View is opened
- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self viewLoadSetup];
}

// only called once, when view is initiated
- (void) viewInitiateSetup {
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    _pirat = appDelegate.pirate;
}

- (void) viewLoadSetup {
    AppDelegate *appDelegate;
    
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
    
    
    //goods img
    UIImage *coconutBoxImg = [UIImage imageNamed:@"Coconutbox"];
    UIImageView *imageView5 = [[UIImageView alloc] initWithFrame:CGRectMake(300, 530, 100, 100)];
    imageView5.image = coconutBoxImg;
    [self.view addSubview:imageView5];
    
    UIImage *orangeBoxImg = [UIImage imageNamed:@"Orangebox"];
    UIImageView *imageView6 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 580, 100, 100)];
    imageView6.image = orangeBoxImg;
    [self.view addSubview:imageView6];
    
    UIImage *bottleBoxImg = [UIImage imageNamed:@"Bottlebox"];
    UIImageView *imageView7 = [[UIImageView alloc] initWithFrame:CGRectMake(204, 460, 100, 100)];
    imageView7.image = bottleBoxImg;
    [self.view addSubview:imageView7];
    
    UIImage *meatImg = [UIImage imageNamed:@"Meat"];
    UIImageView *imageView8 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 480, 100, 100)];
    imageView8.image = meatImg;
    [self.view addSubview:imageView8];
    
    UIImage *meatImg2 = [UIImage imageNamed:@"Meat"];
    UIImageView *imageView9 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 510, 100, 100)];
    imageView9.image = meatImg2;
    [self.view addSubview:imageView9];
    
    // Method to directly go to the GameOver Screen
    /*UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
     GameOverViewController *viewController = (GameOverViewController *)[storyboard instantiateViewControllerWithIdentifier:@"GameOverViewControllerID"];
     [self presentViewController:viewController animated:YES completion:nil];*/
   
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    _storage = [[Storage alloc] init];
    [_storage loadData];
    
    // set Amount of Items to Labels
    _rumLabel.text = _storage.supplies[RUM][AMOUNT];
    _foodLabel.text = _storage.supplies[FOOD][AMOUNT];
    _fruitsLabel.text = _storage.supplies[FRUITS][AMOUNT];
    _drinksLabel.text = _storage.supplies[DRINKS][AMOUNT];
    
    // add them to view, to set them to the front
    [self.view addSubview:_rumLabel];
    [self.view addSubview:_foodLabel];
    [self.view addSubview:_fruitsLabel];
    [self.view addSubview:_drinksLabel];
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
        
        // update Labels
        _rumLabel.text = _storage.supplies[RUM][AMOUNT];
        _foodLabel.text = _storage.supplies[FOOD][AMOUNT];
        _fruitsLabel.text = _storage.supplies[FRUITS][AMOUNT];
        _drinksLabel.text = _storage.supplies[DRINKS][AMOUNT];
        
        // set Resulttext for Loot-Button
        NSString *itemName;
        switch (randomItem) {
            case 0:
                itemName = @"1x Hammelkeule";
                break;
            case 1:
                itemName = @"1x Wasser";
                break;
            case 2:
                itemName = @"1x Rum";
                break;
            case 3:
                itemName = @"1x Frucht";
                break;
            case 4:
                itemName = @"10x Gold";
                break;
            default:
                break;
        }
        _lootLabel.text = [NSString stringWithFormat:@"%@%@%@", @"Der Raubzug war erfolgreich! ", itemName, @" erhalten"];;
        
    } else {
        [_pirat looseLife];
        _lootLabel.text = [NSString stringWithFormat:@"%@%@", _pirat.name, @" ist grandios gescheitert! -1 Leben"];
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
