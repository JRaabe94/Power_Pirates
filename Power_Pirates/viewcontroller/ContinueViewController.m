//
//  ContinueViewController.m
//  Power_Pirates
//
//  Created by Codecamp on 24.07.18.
//  Copyright © 2018 Codecamp. All rights reserved.
//

#import "ContinueViewController.h"
#import "PiratLabelStyle.h"
#import "Pirates.h"
#import "Storage.h"
#import "DBManager.h"
#import "TypeDef.h"

@interface ContinueViewController ()

@property (weak, nonatomic) IBOutlet PiratLabelStyle *piratNameLabel;
@property (weak, nonatomic) IBOutlet PiratLabelStyle *piratLvlLabel;
@property (weak, nonatomic) IBOutlet PiratLabelStyle *piratGoldLabel;


@end

@implementation ContinueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Load images
    NSArray *imageNames = @[@"island_1", @"island_2", @"island_3", @"island_4",
                            @"island_5", @"island_6", @"island_7", @"island_8",
                            @"island_9", @"island_10"];
    
    NSMutableArray *images = [[NSMutableArray alloc] init];
    for (int i = 0; i < imageNames.count; i++) {
        [images addObject:[UIImage imageNamed:[imageNames objectAtIndex:i]]];
    }
    
    // Normal Animation
    UIImageView *animationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 420, 700)];
    animationImageView.animationImages = images;
    animationImageView.animationDuration = 8;
    
    [self.view addSubview:animationImageView];
    [self.view sendSubviewToBack:animationImageView];
    [animationImageView startAnimating];
    
    // Ask for push notification permission, kann später gelöscht werden
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    UNAuthorizationOptions options = UNAuthorizationOptionAlert + UNAuthorizationOptionSound;
    [center requestAuthorizationWithOptions:options completionHandler:^(BOOL granted, NSError * _Nullable error) {}];
    
    Pirates *pirate = [[Pirates alloc] init];
    [pirate loadData];

    Storage *storage = [[Storage alloc] init];
    [storage loadData];

    _piratNameLabel.text = pirate.name;
    NSString *string = [@(pirate.level) stringValue];
    _piratLvlLabel.text = string;
    _piratGoldLabel.text = storage.supplies[MONEY][AMOUNT];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onContinueButton:(id)sender {
    [self performSegueWithIdentifier:@"ContinueMainGameSegue" sender:self];
}

- (IBAction)onResetButton:(id)sender {
    DBManager *dbManager = [[DBManager alloc] init];
    dbManager = [dbManager initWithDatabaseFilename:@"piratendb.sql"];
    [dbManager cleanDatabase];
    
    //ToDo: laden des alternativen main bildschirms, wo der name eingetragen wird.sonst absturz
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
