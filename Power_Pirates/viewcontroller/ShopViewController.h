//
//  ShopViewController.h
//  Power_Pirates
//
//  Created by Codecamp on 24.07.18.
//  Copyright © 2018 Codecamp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *rumTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *rumPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *rumStorageLabel;

- (void) viewDidLoad;

- (void) viewWillAppear:(BOOL)animated;

@end
