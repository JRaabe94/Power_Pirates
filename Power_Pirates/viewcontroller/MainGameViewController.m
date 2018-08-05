//
//  MainGameViewController.m
//  Power_Pirates
//
//  Created by Codecamp on 25.07.18.
//  Copyright © 2018 Codecamp. All rights reserved.
//

#import "MainGameViewController.h"
#import "Desires.h"
#import "AppDelegate.h"
#import "Storage.h"
#import "Pirates.h"
#import "TypeDef.h"
#import "DBManager.h"

@interface MainGameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *goldLabel;
@property (weak, nonatomic) IBOutlet UIImageView *lifeImageView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingConstraint;
@property (weak, nonatomic) IBOutlet UIView *menuView;
@property (weak, nonatomic) IBOutlet UILabel *desireText;
@property bool menuShowing;

@property Storage *storage;
@property Pirates *pirat;

@end

@implementation MainGameViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self viewLoadSetup];
}

// this Method will be called everytime the main View is opened
- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // Auskommentiert, weil sonst immer ein neuer Pirat erstellt wird
//    [self viewLoadSetup];
}

- (void) viewLoadSetup {
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate initGame];
    
    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(updateDesires) userInfo:nil repeats:YES];
    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(updateLifes) userInfo:nil repeats:YES];
    
    // initialice storage and pirat
    _storage = [[Storage alloc] init];
    [_storage loadData];
    _pirat = appDelegate.pirate;		
    [_pirat loadData];
    
    // set up new game Thread
    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(updateDesires) userInfo:nil repeats:YES];
    
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
    
    int piratLevel = _pirat.level;
    NSString *pirateIcon;
    switch (piratLevel){
        case 2:
            pirateIcon = @"Pirate_lvl2";
            break;
        case 3:
            pirateIcon = @"Pirate_lvl3";
            break;
        case 4:
            pirateIcon = @"Pirate_lvl4";
            break;
        case 5:
            pirateIcon = @"Pirate_lvl5";
            break;
        default:
            pirateIcon = @"Pirate_lvl1";
            break;
    }
    UIImage *pirateImg = [UIImage imageNamed:pirateIcon];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 450, 100, 100)];
    imageView.image = pirateImg;
    [self.view addSubview:imageView];
    
    
    // setup Sliding Menu
    _menuShowing = false;
    _menuView.hidden = YES;
    
    // gold Label and Heart Image
    _goldLabel.text = _storage.supplies[MONEY][AMOUNT];
    
    int piratLife = _pirat.lifes;
    NSString *lifeImageString;
    switch (piratLife) {
        case 1:
            lifeImageString = @"Heart_5";
            break;
        case 2:
            lifeImageString = @"Heart_4";
            break;
        case 3:
            lifeImageString = @"Heart_3";
            break;
        case 4:
            lifeImageString = @"Heart_2";
            break;
        case 5:
            lifeImageString = @"Heart_1";
            break;
        default:
            break;
    }
    UIImage *lifeImage = [UIImage imageNamed:lifeImageString];
    _lifeImageView.image = lifeImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//**************** Menu Bar ****************
- (IBAction)openMenu:(id)sender {
    // hide or show menuView
    if(_menuShowing) {
        _menuView.hidden = YES;
        _leadingConstraint.constant = -180;
    } else {
        _menuView.hidden = NO;
        _leadingConstraint.constant = 0;
    }
    _menuShowing = !_menuShowing;
}

- (IBAction)onFeedingButton:(id)sender {
    [Desires fulfilDesire:0];
}

- (IBAction)onWaterButton:(id)sender {
    [Desires fulfilDesire:1];
}

- (IBAction)onRumButton:(id)sender {
    [Desires fulfilDesire:2];
}

- (IBAction)onMedicineButton:(id)sender {
    [Desires fulfilDesire:3];
}

- (void)updateDesires {
    NSArray *desireText = @[@"Ich will essen.", @"Ich will trinken", @"Ich will saufen", @"Ich kriege gleich Skorbut"];
    NSArray *activeDesire = [Desires getActiveDesire];
    if ([activeDesire count] == 0) {
        _desireText.text = @"";
    } else {
        NSNumber *desireNumber = activeDesire[0];
        NSInteger desireId = [desireNumber integerValue];
        NSString *label = [NSString stringWithFormat:@"%@", desireText[desireId]];
        _desireText.text = label;
    }
}

- (void)updateLifes {
    int piratLife = _pirat.lifes;
//    NSLog(@"Leben: %d", piratLife);
    NSString *lifeImageString;
    switch (piratLife) {
        case 1:
            lifeImageString = @"Heart_5";
            break;
        case 2:
            lifeImageString = @"Heart_4";
            break;
        case 3:
            lifeImageString = @"Heart_3";
            break;
        case 4:
            lifeImageString = @"Heart_2";
            break;
        case 5:
            lifeImageString = @"Heart_1";
            break;
        default:
            break;
    }
    UIImage *lifeImage = [UIImage imageNamed:lifeImageString];
    _lifeImageView.image = lifeImage;
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
