//
//  BCViewController.h
//  BeaconClient
//
//  Created by masa on 2013/09/19.
//  Copyright (c) 2013年 gclue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreLocation/CoreLocation.h>

@interface BCViewController : UIViewController<CLLocationManagerDelegate>{
    CLLocationManager *lm;
}
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;

@end
