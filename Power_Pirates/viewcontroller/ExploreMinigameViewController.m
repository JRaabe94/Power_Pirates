//
//  ExploreMinigameViewController.m
//  Power_Pirates
//
//  Created by Codecamp on 24.07.18.
//  Copyright © 2018 Codecamp. All rights reserved.
//

#import "ExploreMinigameViewController.h"

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
    locationManager = [[CLLocationManager alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onBackButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onStartButton:(id)sender {
    self.totalDistance = 0;
    lastLocation = nil;
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    NSString *textForLabel = [NSString stringWithFormat:@"%f", 1000*distanceNeeded];
    _distanceLabel.text = [NSString stringWithFormat:@"%@%@", @"Verbleibende Meter: ", textForLabel];

    NSLog(@"Gestartet");
        
    if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [locationManager requestWhenInUseAuthorization];
    }
    [locationManager startUpdatingLocation];
}

-(BOOL)checkWin{
    if(self.totalDistance > distanceNeeded){
        return true;
    }else{
        return false;
    }
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    //UIAlertController *errorAlert = [[UIAlertController initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //[errorAlert show];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    NSLog(@"%f", _totalDistance);
    CLLocation *currentLocation = [locations lastObject];
    if(currentLocation != nil){
        if(lastLocation != nil){
            CLLocationDistance meters = [lastLocation distanceFromLocation:currentLocation];
            _totalDistance = _totalDistance + (meters/1000);
            NSString *textForLabel = [NSString stringWithFormat:@"%f", ((distanceNeeded - _totalDistance) * 1000)];
            _distanceLabel.text = [NSString stringWithFormat:@"%@%@", @"Verbleibende Meter: ", textForLabel];
            lastLocation = currentLocation;
        }else{
            lastLocation = currentLocation;
        }
    }
    if([self checkWin]){
        [locationManager stopUpdatingLocation];
        _totalDistance = 0;
        _distanceLabel.text = @"Geschafft";
        NSLog(@"Geschafft!");
    }
}

@end
