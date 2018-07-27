//
//  ShopViewController.m
//  Power_Pirates
//
//  Created by Codecamp on 24.07.18.
//  Copyright © 2018 Codecamp. All rights reserved.
//

#import "ShopViewController.h"
#import "AppDelegate.h"
#import "DBManager.h"
#import "Storage.h"
#import "PiratLabelStyle.h"
#import "BuySellButton.h"

@interface ShopViewController ()

@end

@implementation ShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    // Do any additional setup after loading the view.
    DBManager *dbManager = [[DBManager alloc] init];    // Test
    dbManager = [dbManager initWithDatabaseFilename:@"piratendb.sql"];
    [dbManager readDesires];
    
    Storage *storage = [[Storage alloc] init];
    [storage loadData];
    
    //Image
    NSString *shopIcon = @"shopIcon";
    UIImage *shopImg = [UIImage imageNamed: shopIcon];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 420, 700)];
    imageView.image = shopImg;
    [self.view sendSubviewToBack:imageView];
    [self.view addSubview:imageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//************ Create Shop Information ************

- (IBAction)onShopItemClick:(id)sender {
    UIStackView *horizontalStackView = [[UIStackView alloc] init];
    PiratLabelStyle *itemName =[[PiratLabelStyle alloc] init];
    PiratLabelStyle *itemPriceName =[[PiratLabelStyle alloc] init];
    PiratLabelStyle *itemNumberName =[[PiratLabelStyle alloc] init];
    
    UIStackView *verticalStackView = [[UIStackView alloc] init];
    BuySellButton *buyButton =[[BuySellButton alloc] init];
    BuySellButton *sellButton =[[BuySellButton alloc] init];
    
    horizontalStackView.axis = UILayoutConstraintAxisHorizontal;
    horizontalStackView.alignment = UIStackViewAlignmentCenter;
    horizontalStackView.distribution = UIStackViewDistributionFillEqually;
    horizontalStackView.frame = CGRectMake(0, 600, UIScreen.mainScreen.bounds.size.width, 100);
    
    itemName.text = @"Wasser";
    itemPriceName.text = @"5";
    [itemPriceName.text stringByAppendingString:@"Dublonen"]; // is like + for Strings
    itemNumberName.text = @"0";
    itemNumberName.textAlignment = NSTextAlignmentRight;
    
    verticalStackView.axis = UILayoutConstraintAxisVertical;
    verticalStackView.alignment = UIStackViewAlignmentFill;
    verticalStackView.distribution = UIStackViewDistributionFill;
    
    [buyButton setTitle:@"Kaufen" forState:UIControlStateNormal];
    [sellButton setTitle:@"Verkaufen" forState:UIControlStateNormal];
    
    
    // add functionality to buy/sell-Button
    [buyButton addTarget:self action:@selector(onBuyButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [sellButton addTarget:self action:@selector(onSellButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [verticalStackView addArrangedSubview:buyButton];
    [verticalStackView addArrangedSubview:sellButton];
    
    [horizontalStackView addArrangedSubview:itemName];
    [horizontalStackView addArrangedSubview:itemPriceName];
    [horizontalStackView addArrangedSubview:verticalStackView];
    [horizontalStackView addArrangedSubview:itemNumberName];
    
    [self.view addSubview:horizontalStackView];
    
}

- (void)onBuyButton:(UIButton *)sender {
    NSLog(@"Buy button was tapped: dismiss the view controller.");
}

- (void)onSellButton:(UIButton *)sender {
    NSLog(@"Sell button was tapped: dismiss the view controller.");
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
