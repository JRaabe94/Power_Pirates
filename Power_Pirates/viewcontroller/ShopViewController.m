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
#import "TypeDef.h"

@interface ShopViewController ()
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@end

UIStackView *horizontalStackView;
Storage *storage;
int selectedItem;

@implementation ShopViewController

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
//    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    //Image
    NSString *shopIcon = @"shopIcon";
    UIImage *shopImg = [UIImage imageNamed: shopIcon];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 420, 700)];
    imageView.image = shopImg;
    [self.view addSubview:imageView];
    [self.view sendSubviewToBack:imageView];
    
    // show amount of money
    storage = [[Storage alloc] init];
    [storage loadData];
    _moneyLabel.text = storage.supplies[MONEY][AMOUNT];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//************ Shop Item Buttons ************

- (IBAction)onFruitButton:(id)sender {
    selectedItem = FRUITS;
    [self createItemInformation:selectedItem];
}

- (IBAction)onRumButton:(id)sender {
    selectedItem = RUM;
    [self createItemInformation:selectedItem];
}

- (IBAction)onFoodButton:(id)sender {
    selectedItem = FOOD;
    [self createItemInformation:selectedItem];
}

- (IBAction)onDrinksButton:(id)sender {
    selectedItem = DRINKS;
    [self createItemInformation:selectedItem];
}

//************ Create Shop Information ************

// funtionality for created buttons
- (void)onBuyButton:(UIButton *)sender {
    [storage buy:selectedItem];
    [self updateLabels:selectedItem];
    
    NSLog(@"Buy button was tapped: dismiss the view controller.");
}

- (void)onSellButton:(UIButton *)sender {
    [storage sell:selectedItem];
    [self updateLabels:selectedItem];
    
    NSLog(@"Sell button was tapped: dismiss the view controller.");
}

- (void) createItemInformation:(int)itemID {
    
    if(horizontalStackView != nil) {
        // remove all previous elements
        [horizontalStackView.arrangedSubviews[0] removeFromSuperview];
        [horizontalStackView.arrangedSubviews[0] removeFromSuperview];
        [horizontalStackView.arrangedSubviews[0] removeFromSuperview];
        [horizontalStackView.arrangedSubviews[0] removeFromSuperview];
    } else {
        // for the first time there are no elements in the stack view
        horizontalStackView = [[UIStackView alloc] init];
    }
    
    // create content for stack view and style
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
    
    itemName.text = storage.supplies[itemID][NAME];
    itemPriceName.text = storage.supplies[itemID][PRICE];
    itemPriceName.text = [itemPriceName.text stringByAppendingString:@" Dublonen"];
    itemNumberName.text = storage.supplies[itemID][AMOUNT];
    itemNumberName.textAlignment = NSTextAlignmentRight;
    
    verticalStackView.axis = UILayoutConstraintAxisVertical;
    verticalStackView.alignment = UIStackViewAlignmentFill;
    verticalStackView.distribution = UIStackViewDistributionFill;
    
    [buyButton setTitle:@"Kaufen" forState:UIControlStateNormal];
    [sellButton setTitle:@"Verkaufen" forState:UIControlStateNormal];

    // add functionality to buy/sell-Button
    [buyButton addTarget:self action:@selector(onBuyButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [sellButton addTarget:self action:@selector(onSellButton:) forControlEvents:UIControlEventTouchUpInside];
    
    // add content to the stack views
    [verticalStackView addArrangedSubview:buyButton];
    [verticalStackView addArrangedSubview:sellButton];
    
    [horizontalStackView addArrangedSubview:itemName];
    [horizontalStackView addArrangedSubview:itemPriceName];
    [horizontalStackView addArrangedSubview:verticalStackView];
    [horizontalStackView addArrangedSubview:itemNumberName];
    
    [self.view addSubview:horizontalStackView];
}

- (void) updateLabels:(int)itemID {
    // update price and amount of the item the player has
    ((PiratLabelStyle*)horizontalStackView.arrangedSubviews[3]).text = storage.supplies [itemID][AMOUNT];

    _moneyLabel.text = storage.supplies[MONEY][AMOUNT];
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
