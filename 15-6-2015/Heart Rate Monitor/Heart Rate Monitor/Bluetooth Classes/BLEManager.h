//
//  BLEManager.h
//
//
//  Created by Oneclick IT Solution on 7/11/14.
//  Copyright (c) 2014 One Click IT Consultancy Pvt Ltd, Ind. All rights reserved.
//

#import "BLEService.h"
#import <AudioToolbox/AudioToolbox.h>

#import <CoreBluetooth/CoreBluetooth.h>

#import "AppDelegate.h"
#import "DataBaseManager.h"
#import "Constant.h"

/*!
 *  @protocol SGFManagerDelegate
 *
 *  @discussion The delegate of a {@link SGFManager} object must adopt the <code>SGFManagerDelegate</code> protocol. The
 *              single required method indicates the availability of the sgf manager, while the optional methods allow for the discovery and
 *              connection of peripherals.
 *
 */
@protocol BLEManagerDelegate <NSObject>

@optional
/*!
 * this delegate method sense the bluetooth status.
 */
-(void) bluetoothPowerState:(NSString*)state;

-(void) updateBleImageWithStatus:(BOOL)isConnected andPeripheral:(CBPeripheral*)peripheral;

@required

/*!
 * this delegate method sense immediatly when device connected.
 */
-(void) didConnectDevice:(CBPeripheral *)device;

/*!
 * this delegate method sense immediatly when device disconnected.
 */
-(void) didDisconnectDevice:(CBPeripheral *)device;

/*!
 * this delegate method called when the central manger failed to connect device.
 */
-(void) didFailToConnectDevice:(CBPeripheral*)device error:(NSError*)error;

/*!
 * this delegate method called when ever a new device scanned.
 */
-(void) didDiscoveredDevice:(CBPeripheral *)device withRSSI:(NSNumber *)RSSI;

@end

@interface BLEManager : NSObject
{
    NSTimer * blutoothSearchTimer;
    NSTimer * scannedDeviceSyncTimer;
    NSTimer * rssiAlertTimer;
    NSTimer * rangeDisconnectedTimer;
}

- (id)init;

/*!
 * shared instance object.
 */
+ (BLEManager*)sharedManager;


/*!
 *  @method startScan
 *
 *  @discussion         Starts scanning for peripherals that are advertising any of the services listed to Find device,
 *                      Applications that have specified the <code>bluetooth-central</code> background mode are allowed to scan while backgrounded
 */
- (void) startScan;



/*!
 *  @method stopScan:
 *
 *  @discussion Stops scanning for devices.
 *
 */
- (void) stopScan;


/*!
 *  @method connectDevice:
 *
 *  @param peripheral   The <code>CBPeripheral</code> to be connected.
 *  @param options      An optional dictionary specifying connection behavior options.
 *
 *  @discussion         Initiates a connection to <i>peripheral</i>. Connection attempts never time out and, depending on the outcome, will result
 *                      in a call to either {@link didDisconnectDevice:} or {@link didFailToConnectDevice:error:}.
 *                      Pending attempts are cancelled automatically upon deallocation of <i>peripheral</i>, and explicitly via {@link disconnectDevice}.
 *
 *  @see                didDisconnectDevice:
 *  @see                didFailToConnectDevice:error:
 *
 */- (void) connectDevice:(CBPeripheral*)device;


/*!
 *  @method disconnectDevice:
 *
 *  @param peripheral   A <code>CBPeripheral</code>.
 *
 *  @discussion         Cancels an active or pending connection to <i>peripheral</i>. Note that this is non-blocking, and any <code>CBPeripheral</code>
 *                      commands that are still pending to <i>peripheral</i> may or may not complete.
 *
 *  @see                didDisconnectDevice:
 *
 */
- (void) disconnectDevice:(CBPeripheral*)device;


/*!
 *  @property delegate
 *
 *  @discussion The delegate object that will receive manager events.
 *
 */
@property (nonatomic, weak)     id<BLEManagerDelegate>delegate;


/*!
 *  @property delegate
 *
 *  @discussion The delegate object that will receive service events.
 *
 */
@property (nonatomic, weak)     id<BLEServiceDelegate>serviceDelegate;


/*!
 * centralManager object provides to scann all the find devices
 */
@property (nonatomic, strong)     CBCentralManager    *centralManager;


/*!
 * foundDevices results all scanned devices.
 */
@property (nonatomic, strong) NSMutableArray *foundDevices;


/*!
 * connectedServices results all the services of pripherals.
 */
@property (strong, nonatomic)   NSMutableArray	*connectedServices;	// Array of SGFService


/*!
 * @discussion autoConnect will offers the devices to connected automatically when device disconnected aotomatically.
 */
//@property (assign) BOOL autoConnect;


//by viral
-(void) rescan;

-(void)sendImmediateAlertToBluetoothDeviceWithSignal:(Byte)Signalvalue forPeripheral:(CBPeripheral*)peripheral;
-(void) updateBluetoothState;

-(void)initialize;

@end
