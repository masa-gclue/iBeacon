//
//  BCViewController.m
//  BeaconClient
//
//  Created by masa on 2013/09/19.
//  Copyright (c) 2013年 gclue. All rights reserved.
//

#import "BCViewController.h"

@interface BCViewController ()

@end

@implementation BCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    lm = [[CLLocationManager alloc] init];
    lm.delegate = self;
                                                             //@"CB86BC31-05BD-40CC-903D-1C9BD13D966B"
    NSUUID *proximityUUID = [[NSUUID alloc] initWithUUIDString:@"CB86BC31-05BD-40CC-903D-1C9BD13D966B"];
                                                                 //@"com.gclue.BeconTest"
    [self registerBeaconRegionWithUUID:proximityUUID andIdentifier:@"com.gclue.BeconTest"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)registerBeaconRegionWithUUID:(NSUUID *)proximityUUID andIdentifier:(NSString *)identifier {
    CLBeaconRegion *beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:proximityUUID identifier:identifier];
    
    [lm startMonitoringForRegion:beaconRegion];
    [lm startRangingBeaconsInRegion:beaconRegion];
    NSLog(@"startMonitoringForRegion");
}

/*
- (void)locationManager:(CLLocationManager *)manager
        didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region{
    
    NSLog(@"locationManager: didRangeBeacons: inRegion:");
    NSLog(@"%@", beacons);
    NSLog(@"%@", region);
}

- (void)locationManager:(CLLocationManager *)manager
         didEnterRegion:(CLRegion *)region{
    NSLog(@"locationManager: didEnterRegion");
    NSLog(@"%@", region);
}
*/

//Callback when the iBeacon is in range
- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    NSLog(@"didEnterRegion");
    if ([region isKindOfClass:[CLBeaconRegion class]]) {
        [manager startRangingBeaconsInRegion:(CLBeaconRegion *)region];
    }
}

//Callback when the iBeacon has left range
- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
{
    NSLog(@"didExitRegion");
    if ([region isKindOfClass:[CLBeaconRegion class]]) {
        [manager stopRangingBeaconsInRegion:(CLBeaconRegion *)region];
    }
}

//Callback when ranging is successful
- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons
               inRegion:(CLBeaconRegion *)region
{
    //Check if we have moved closer or farther away from the iBeacon…
    
    if([beacons count] == 0){
        NSLog(@"no beacons.");
        return;
    }
    CLBeacon *beacon = [beacons objectAtIndex:0];
    
    switch (beacon.proximity) {
        case CLProximityImmediate:
            [_label1 setText:@"Immediate"];
            NSLog(@"CLProximityImmediate  %f %d", beacon.accuracy, beacon.rssi);
            break;
        case CLProximityNear:
            [_label1 setText:@"Near"];
            NSLog(@"CLProximityNear %f %d", beacon.accuracy, beacon.rssi);
            break;
        case CLProximityFar:
            [_label1 setText:@"Far"];
            NSLog(@"CLProximityFar %f %d", beacon.accuracy, beacon.rssi);
            break;
        default:
            [_label1 setText:@"Unknown"];
            NSLog(@"CLProximityUnknown %f %d", beacon.accuracy, beacon.rssi);
            break;
    }
    [_label2 setText:[NSString stringWithFormat:@"%f", beacon.accuracy]];
}



@end
