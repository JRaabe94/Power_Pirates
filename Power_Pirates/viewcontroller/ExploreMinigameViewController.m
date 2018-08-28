//
//  ExploreMinigameViewController.m
//  Power_Pirates
//
//  Created by Codecamp on 24.07.18.
//  Copyright © 2018 Codecamp. All rights reserved.
//

#import "ExploreMinigameViewController.h"
#import "Storage.h"
#import "TypeDef.h"

@interface ExploreMinigameViewController ()

@property (nonatomic) double totalDistance;

-(BOOL)checkWin;

@end

double distanceNeeded = 0.1;

//mode 0 = gps, mode 1 = pedometer
int mode = 0;

@implementation ExploreMinigameViewController

CLLocationManager *locationManager;
CLLocation *lastLocation;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //locationManager = [[CLLocationManager alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onBackButton:(id)sender {
    //stop location updates
    [locationManager stopUpdatingLocation];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)onStartButton:(id)sender {
    //init LocationManager
    [self initLocationManager];
    
    //label for feedback
    [self updateLabel];
    
    //Request Permission
    [self requestPermission];
    
    //Start Location Updates
    [locationManager startUpdatingLocation];
}

-(void)initLocationManager{
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
}

-(void)requestPermission{
    if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [locationManager requestWhenInUseAuthorization];
    }
}

//check if the player traveled the needed distance
-(BOOL)checkWin{
    if(self.totalDistance > distanceNeeded){
        return true;
    }else{
        return false;
    }
}

-(void)cleanUp{
    //if the player win, the updates should stop
    [locationManager stopUpdatingLocation];
    self.totalDistance = 0;
    lastLocation = nil;
    
    [self giveMoney];
    
    self.distanceLabel.text = @"Geschafft";
}

-(void)updateLabel{
    NSString *textForLabel = [NSString stringWithFormat:@"%f", 1000*(distanceNeeded- _totalDistance)];
    self.distanceLabel.text = [NSString stringWithFormat:@"%@%@", @"Verbleibende Meter: ", textForLabel];
}

-(void)giveMoney{
    //give the player money
    Storage *storage = [[Storage alloc] init];
    [storage loadData];
    for(int i = 0; i < 10; i++){
        [storage give:MONEY];
    }
}
    
    
#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation *currentLocation = [locations lastObject];   //get the new location values
    if(currentLocation != nil){
        if(lastLocation != nil){
            CLLocationDistance distance = [lastLocation distanceFromLocation:currentLocation] / 1000;    //calculate the distance between the last and the current location in meters
            _totalDistance = _totalDistance + (distance);      //add the newly traveled meters
            
            [self updateLabel];     //update meter in label
            
            //set the new last location for next update
            lastLocation = currentLocation;
        }else{
            //set the lastLocation, if no last Location is set
            lastLocation = currentLocation;
        }
    }
    if([self checkWin]){
        [self cleanUp];
    }
}

@end
