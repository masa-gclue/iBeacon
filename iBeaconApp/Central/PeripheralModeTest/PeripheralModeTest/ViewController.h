
#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController<CBPeripheralManagerDelegate>{
    CBPeripheralManager *manager;
}
@property (weak, nonatomic) IBOutlet UILabel *Label;
@property (weak, nonatomic) IBOutlet UITextView *Log;

- (void)willEnterBackgroud;
- (void)willBacktoForeground;

@end
