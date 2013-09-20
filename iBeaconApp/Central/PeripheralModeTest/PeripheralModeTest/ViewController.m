
#import "ViewController.h"

#define BEACON_UUID @"CB86BC31-05BD-40CC-903D-1C9BD13D966B"
#define BEACON_IDENTIFIER @"com.gclue.BeconTest"

@interface ViewController ()

@end

@implementation ViewController
@synthesize Label;
@synthesize Log;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    manager = [[CBPeripheralManager alloc]initWithDelegate:self queue:nil];
}

- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral{
    NSLog(@"peripheralManagerDidUpdateState");
    switch (peripheral.state) {
        case CBPeripheralManagerStatePoweredOn:{
            
            NSUUID *proximityUUID = [[NSUUID alloc] initWithUUIDString:BEACON_UUID];
            
            CLBeaconRegion *beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:proximityUUID identifier:BEACON_IDENTIFIER];
            
            NSDictionary *beaconPeripheralData = [beaconRegion peripheralDataWithMeasuredPower:nil];
            
            NSLog(@"dictionary : %@", beaconPeripheralData);
            
            
            [peripheral startAdvertising:beaconPeripheralData];
             NSLog(@"startAdvertising");

            
        }
            break;
            
        default:
            NSLog(@"%i",peripheral.state);
            break;
    }
}

- (void)peripheralManager:(CBPeripheralManager *)peripheral didAddService:(CBService *)service error:(NSError *)error{
    
}

- (void)peripheralManagerDidStartAdvertising:(CBPeripheralManager *)peripheral error:(NSError *)error{
    NSLog(@"peripheralManagerDidStartAdvertising");
}

- (void)willEnterBackgroud{
    [manager stopAdvertising];
}

- (void)willBacktoForeground{
    NSUUID *proximityUUID = [[NSUUID alloc] initWithUUIDString:BEACON_UUID];
    
    CLBeaconRegion *beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:proximityUUID identifier:BEACON_IDENTIFIER];
    
    NSDictionary *beaconPeripheralData = [beaconRegion peripheralDataWithMeasuredPower:nil];
    
    NSLog(@"dictionary : %@", beaconPeripheralData);
    
    [manager startAdvertising:beaconPeripheralData];
    NSLog(@"startAdvertising");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
