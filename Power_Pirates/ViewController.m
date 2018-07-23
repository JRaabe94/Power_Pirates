//
//  ViewController.m
//  Power_Pirates
//
//  Created by Codecamp on 23.07.18.
//  Copyright © 2018 Codecamp. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"images/strand.jpg"]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)startGame:(id)sender {
    NSString *enteredText = [_charName text];
    NSLog(@"Value of Input = %@", enteredText);
}
@end
