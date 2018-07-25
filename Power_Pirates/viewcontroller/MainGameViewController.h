//
//  MainGameViewController.h
//  Power_Pirates
//
//  Created by Codecamp on 24.07.18.
//  Copyright © 2018 Codecamp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainGameViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *dropDownButton;
@property (weak, nonatomic) IBOutlet UITableView *dropDownTableView;
@property (strong, nonatomic) NSArray *dropDownTableData;

@property (weak, nonatomic) IBOutlet UIButton *onDropDownButton;

@end
