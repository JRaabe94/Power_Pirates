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


//************ Rum Button Action ************
- (IBAction)onRumBuyButton:(id)sender {
    
}
- (IBAction)onRumSellButton:(id)sender {
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
