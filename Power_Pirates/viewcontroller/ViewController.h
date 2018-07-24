//
//  ViewController.h
//  Power_Pirates
//
//  Created by Codecamp on 23.07.18.
//  Copyright © 2018 Codecamp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *charName;
- (IBAction)startGame:(id)sender;

@end

