//
//  BLEService.h
//
//
//  Created by Oneclick IT Solution on 7/11/14.
//  Copyright (c) 2014 One Click IT Consultancy Pvt Ltd, Ind. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

#import <CoreBluetooth/CoreBluetooth.h>

#import "Constant.h"

/*!
 *  @protocol SGFServiceDelegate
 *
 *  @discussion Delegate for SGFService.
 *
 */
@protocol BLEServiceDelegate <NSObject>

@optional
/*!
 *  @method activeDevice:
 *
 *  @param device	The device providing this update of communication status.
 *
 *  @discussion			This method is invoked when the @link name @/link of <i>device</i> changes.
 */
-(void)activeDevice:(CBPeripheral*)device;

/*!
 *  @method updateSignalImage:forDevice:
 *
 *  @param device	The device providing this update.
 *
 *  @discussion			This method returns the result of a @link readDeviceRSSI: @/link call.
 */
-(void)updateSignalImage:(int )RSSI forDevice:(CBPeripheral*)device;

@required
/*!
 *  @method batterySignalValueUpdated:withBattLevel:
 *
 *  @param device	The device providing this update.
 *
 *  @discussion			This method returns the result of a @link readDeviceBattery: @/link call.
 */
-(void)batterySignalValueUpdated:(CBPeripheral*)device withBattLevel:(NSString*)batLevel;

@end

@interface BLEService : NSObject

/*!
 *  @property delegate
 *
 *  @discussion The delegate object that will receive service events.
 *
 */

@property (nonatomic, weak) id<BLEServiceDelegate>delegate;

@property (assign) uint16_t heartRate;
@property (nonatomic, strong) NSString   *bodyData;
@property (nonatomic, strong) NSString   *manufacturer;

-(id)init;

+ (instancetype)sharedInstance;

/*!
 *  @method initWithDevice:andDelegate:
 *  @discussion If the developer sets the SGFServiceDelegate while creating object for SGFManager then no need to use
 *      this method. If the developer does not set SGFServiceDelegate while creating object for SGFManager then 
 *      developer has to call this method manually when device connected.
 *
 */
-(id)initWithDevice:(CBPeripheral*)device andDelegate:(id /*<BLEServiceDelegate>*/)delegate;


/*!
 *  @method startDeviceService
 *
 *  @discussion			This method activates the services of connected devices.
 */
-(void)startDeviceService;


/*!
 *  @method readDeviceBattery:
 *
 *  @param device	The device providing this update.
 *
 *  @discussion			This method starts to reading battery values of device.
 *
 *  @see                batterySignalValueUpdated:withBattLevel:
 */
-(void)readDeviceBattery:(CBPeripheral*)device;

/*!
 *  @method readDeviceRSSI:
 *
 *  @param device	The device providing this update.
 *
*  @discussion			This method starts to reading RSSI values of device.
 *
 *  @see                updateSignalImage:forDevice:
 */

-(void)readDeviceRSSI:(CBPeripheral*)device;


/*!
 *  @method startBuzzer:
 *
 *  @param device	The device providing this update.
 *
 *  @discussion			This method provides the developer to call raising the alarm in the find device.
 */
-(void)startBuzzer:(CBPeripheral*)device;


/*!
 *  @method stopBuzzer:
 *
 *  @param device	The device providing this update.
 *
 *  @discussion			This method provides the developer to call stop the alarm in the find device.
 */
-(void)stopBuzzer:(CBPeripheral*)device;

-(void) soundBuzzer:(Byte)buzzerValue peripheral:(CBPeripheral *)peripheral;

@end
