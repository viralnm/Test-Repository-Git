//
//  SGFManager.m
//  SGFindSDK
//
//  Created by Oneclick IT Solution on 7/11/14.
//  Copyright (c) 2014 One Click IT Consultancy Pvt Ltd, Ind. All rights reserved.
//


#import "BLEManager.h"
#import "BLEService.h"

//#import "DataBaseManager.h"

#import <CoreBluetooth/CoreBluetooth.h>
 static BLEManager	*sharedManager	= nil;
//BLEManager	*sharedManager	= nil;

@interface BLEManager()<CBCentralManagerDelegate,CBPeripheralDelegate,CBPeripheralManagerDelegate,BLEServiceDelegate,AVAudioPlayerDelegate>
{
    NSMutableArray *disconnectedPeripherals;
    NSMutableArray *connectedPeripherals;
    NSMutableArray *peripheralsServices;
    CBCentralManager    *centralManager;
    
    BLEService * blutoothService;
    
    AVAudioPlayer *songAlarmPlayer1;
}

@end

@implementation BLEManager
@synthesize delegate,foundDevices,connectedServices,centralManager;

//@synthesize autoConnect;
#pragma mark- Self Class Methods
-(id)init
{
    if(self = [super init])
    {
        [self initialize];
    }
    return self;
}

-(void)initialize
{
    NSLog(@"bleManager initialized");
    
    centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil options:@{ CBCentralManagerOptionRestoreIdentifierKey:  @"CentralManagerIdentifier" }];
    centralManager.delegate = self;
    
    blutoothService.delegate = self;
    
    if(!foundDevices)foundDevices = [[NSMutableArray alloc] init];
    if(!connectedServices)connectedServices = [[NSMutableArray alloc] init];
    if(!disconnectedPeripherals)disconnectedPeripherals = [NSMutableArray new];
}

+ (BLEManager*)sharedManager
{
//    static BLEManager	*sharedManager	= nil;
//    sharedManager = nil;
	if (!sharedManager)
    {
        sharedManager = [[BLEManager alloc] init];
    }
    
	return sharedManager;
}

#pragma mark- Scanning & Connection
-(void)startScan
{
    CBPeripheralManager *pm = [[CBPeripheralManager alloc] initWithDelegate:nil queue:nil];
    
   /* CBUUID *serviceUUID_1803 = [CBUUID UUIDWithString: @"1803"];
    CBUUID *serviceUUID_1804 = [CBUUID UUIDWithString: @"1804"];
    CBUUID *serviceUUID_1802 = [CBUUID UUIDWithString: @"1802"];
    //CBUUID *serviceUUID_Device_Information = [CBUUID UUIDWithString: @"Device Information"];
    //CBUUID *serviceUUID_Battery = [CBUUID UUIDWithString: @"Battery"];
    CBUUID *serviceUUID_FFA0 = [CBUUID UUIDWithString: @"FFA0"];
    CBUUID *serviceUUID_FFE0 = [CBUUID UUIDWithString: @"FFE0"];
    NSArray *withServices = @[serviceUUID_1802,serviceUUID_1803,serviceUUID_1804,serviceUUID_FFA0,serviceUUID_FFE0];*/
    
    NSArray *withServices = @[[CBUUID UUIDWithString:POLARH7_HRM_HEART_RATE_SERVICE_UUID], [CBUUID UUIDWithString:POLARH7_HRM_DEVICE_INFO_SERVICE_UUID]];
    NSDictionary	*options	= [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:CBCentralManagerScanOptionAllowDuplicatesKey];
    [centralManager scanForPeripheralsWithServices:withServices options:options];
}

-(void) rescan
{
    NSArray *withServices = @[[CBUUID UUIDWithString:POLARH7_HRM_HEART_RATE_SERVICE_UUID], [CBUUID UUIDWithString:POLARH7_HRM_DEVICE_INFO_SERVICE_UUID]];
    NSDictionary	*options	= [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:CBCentralManagerScanOptionAllowDuplicatesKey];
    [centralManager scanForPeripheralsWithServices:withServices options:options];
}

-(void)stopScan
{
    self.delegate = nil;
    self.serviceDelegate = nil;
    blutoothService.delegate = nil;
    blutoothService = nil;
    centralManager.delegate = nil;
    [blutoothSearchTimer invalidate];

    [centralManager stopScan];
}

- (void) connectDevice:(CBPeripheral*)device{
    if (device == nil) {
        return;
    }else{
        if ([disconnectedPeripherals containsObject:device]) {
            [disconnectedPeripherals removeObject:device];
        }
        [self connectPeripheral:device];
    }
}

- (void) disconnectDevice:(CBPeripheral*)device
{
    NSLog(@"disconnectDevice ==%@",device);
    if (device == nil) {
        return;
    }else{
        [self disconnectPeripheral:device];
    }
}

-(void)connectPeripheral:(CBPeripheral*)peripheral
{
    NSError *error;
    if (peripheral) {
        if (peripheral.state != CBPeripheralStateConnected) {
            [centralManager connectPeripheral:peripheral options:nil];
        }else{
            if(delegate){
                [delegate didFailToConnectDevice:peripheral error:error];
            }
        }
    }else{
        if(delegate){
            [delegate didFailToConnectDevice:peripheral error:error];
        }
    }
}

-(void) disconnectPeripheral:(CBPeripheral*)peripheral
{
    [self.delegate didDisconnectDevice:peripheral];
    if (peripheral) {
        if (peripheral.state == CBPeripheralStateConnected) {
            [centralManager cancelPeripheralConnection:peripheral];
        }
    }
}

-(void) updateBluetoothState
{
    [self centralManagerDidUpdateState:centralManager];
}

-(void) updateBleImageWithStatus:(BOOL)isConnected andPeripheral:(CBPeripheral*)peripheral
{
    [self.delegate updateBleImageWithStatus:isConnected andPeripheral:peripheral];
}

#pragma mark Search Timer
-(void)searchConnectedBluetooth:(NSTimer*)timer
{
    CBPeripheral * peripheral;
    
    for(CBPeripheral * p in arrCases)
    {
        if (p.state == CBPeripheralStateConnected)
        {
            peripheral = p ;
            
          /*  NSMutableArray * arrIDs = [[NSMutableArray alloc] init];
            NSString *queryStr = [NSString stringWithFormat:@"Select * from User_Created_Device where device_id = '%@' AND isPrimaryDevice = 'YES' AND user_id = '%@'",[p name],CURRENT_USER_ID];
            [[DataBaseManager dataBaseManager] execute:queryStr resultsArray:arrIDs];
            
            if ([arrIDs count]>0)
            {
                NSLog(@"self.autoConnect==%d",V_IS_Auto_Connect);
                if ([CURRENT_USER_ID isEqualToString:@""] || [CURRENT_USER_ID isEqual:[NSNull null]] || CURRENT_USER_ID == nil || [CURRENT_USER_ID isEqualToString:@"(null)"])
                {
                }
                else
                {
                    [[BLEService sharedInstance] readDeviceBattery:peripheral];
                }
            }
            else
            {
//                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isAutoConnectDevice"];
//                [[NSUserDefaults standardUserDefaults] synchronize];//viral change
                [self disconnectDevice:p];
            }*/
        }
        else
        {
           /* NSMutableArray * arrIDs = [[NSMutableArray alloc] init];
            NSString *queryStr = [NSString stringWithFormat:@"Select * from User_Created_Device where device_id = '%@' AND isPrimaryDevice = 'YES' AND user_id = '%@'",[p name],CURRENT_USER_ID];
            [[DataBaseManager dataBaseManager] execute:queryStr resultsArray:arrIDs];
            
            if ([arrIDs count]>0)
            {
                NSLog(@"self.autoConnect==%d",V_IS_Auto_Connect);
                if ([CURRENT_USER_ID isEqualToString:@""] || [CURRENT_USER_ID isEqual:[NSNull null]] || CURRENT_USER_ID == nil || [CURRENT_USER_ID isEqualToString:@"(null)"])
                {
                    
                }
                else
                {
                    if (V_IS_Auto_Connect==YES)
                    {
                         [self connectDevice:p];
                    }
                }
            }*/
            [self connectDevice:p];
        }
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kBluetoothSignalUpdateNotification object:peripheral userInfo:nil];
    
    [self rescan];
}

#pragma mark readRSSITimer
-(void)readRSSIValueForConnectedDevice:(NSTimer*)timer
{
    for(CBPeripheral * p in arrCases)
    {
        if (p.state == CBPeripheralStateConnected)
        {
            NSMutableArray * arrIDs = [[NSMutableArray alloc] init];
            NSString *queryStr = [NSString stringWithFormat:@"Select * from User_Created_Device where device_id = '%@' AND isPrimaryDevice = 'YES' AND user_id = '%@'",[p name],CURRENT_USER_ID];
            [[DataBaseManager dataBaseManager] execute:queryStr resultsArray:arrIDs];
            
            if ([arrIDs count]>0)
            {
                if ([CURRENT_USER_ID isEqualToString:@""] || [CURRENT_USER_ID isEqual:[NSNull null]] || CURRENT_USER_ID == nil || [CURRENT_USER_ID isEqualToString:@"(null)"])
                {
                }
                else
                {
                    [[BLEService sharedInstance] readDeviceRSSI:p];
                }
            }
        }
    }
}

#pragma mark callRangeDisconnectedTimer
-(void)callRangeDisconnectedTimer:(NSTimer*)timer
{
    for(CBPeripheral * p in arrCases)
    {
        if (p.state != CBPeripheralStateConnected)
        {
            NSMutableArray * arrIDs = [[NSMutableArray alloc] init];
            NSString *queryStr = [NSString stringWithFormat:@"Select * from User_Created_Device where device_id = '%@' AND isPrimaryDevice = 'YES' AND user_id = '%@'",[p name],CURRENT_USER_ID];
            [[DataBaseManager dataBaseManager] execute:queryStr resultsArray:arrIDs];
            
            if ([arrIDs count]>0)
            {
                if ([CURRENT_USER_ID isEqualToString:@""] || [CURRENT_USER_ID isEqual:[NSNull null]] || CURRENT_USER_ID == nil || [CURRENT_USER_ID isEqualToString:@"(null)"])
                {
                }
                else
                {
                    if ([IS_Range_Alert_ON isEqualToString:@"YES"])
                    {
                        if (V_IS_Auto_Connect == YES)
                        {
                            [self playSoundWhenDeviceRSSIisLow];
                        }
                    }
                }
            }
        }
    }
}

#pragma mark play Sound
-(void)playSoundWhenDeviceRSSIisLow
{
    NSLog(@"IS_Range_Alert_ON==%@",IS_Range_Alert_ON);
    if ([IS_Range_Alert_ON isEqualToString:@"YES"])
    {
        NSLog(@"playSoundWhenDeviceRSSIisLow");
        
        NSURL *songUrl = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/beep.wav", [[NSBundle mainBundle] resourcePath]]];
        
        songAlarmPlayer1=[[AVAudioPlayer alloc]initWithContentsOfURL:songUrl error:nil];
        songAlarmPlayer1.delegate=self;
        
        AVAudioSession *audioSession1 = [AVAudioSession sharedInstance];
        NSError *err = nil;
        [audioSession1 setCategory :AVAudioSessionCategoryPlayback error:&err];
        [audioSession1 setActive:YES error:&err];
        
        [songAlarmPlayer1 prepareToPlay];
        [songAlarmPlayer1 play];
    }
}

-(void)stopPlaySound
{
    [songAlarmPlayer1 stop];
}

#pragma mark- CBCentralManagerDelegate
- (void) centralManagerDidUpdateState:(CBCentralManager *)central
{
    NSLog(@"central.state========%d",central.state);
    [self startScan];
    
    [blutoothSearchTimer invalidate];
    blutoothSearchTimer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(searchConnectedBluetooth:) userInfo:nil repeats:YES];
    
//    [rssiAlertTimer invalidate];
//    rssiAlertTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(readRSSIValueForConnectedDevice:) userInfo:nil repeats:YES];
    
    switch (central.state)
    {
        case CBPeripheralManagerStateUnknown:
            //The current state of the peripheral manager is unknown; an update is imminent.
            if(delegate)[delegate bluetoothPowerState:@"The current state of the peripheral manager is unknown; an update is imminent."];
            
            break;
        case CBPeripheralManagerStateUnauthorized:
            //The app is not authorized to use the Bluetooth low energy peripheral/server role.
            if(delegate)[delegate bluetoothPowerState:@"The app is not authorized to use the Bluetooth low energy peripheral/server role."];
            
            break;
        case CBPeripheralManagerStateResetting:
            //The connection with the system service was momentarily lost; an update is imminent.
            if(delegate)[delegate bluetoothPowerState:@"The connection with the system service was momentarily lost; an update is imminent."];
            
            break;
        case CBPeripheralManagerStatePoweredOff:
            //Bluetooth is currently powered off"
            if(delegate)[delegate bluetoothPowerState:@"Bluetooth is currently powered off."];
            
            break;
        case CBPeripheralManagerStateUnsupported:
            //The platform doesn't support the Bluetooth low energy peripheral/server role.
            if(delegate)[delegate bluetoothPowerState:@"The platform doesn't support the Bluetooth low energy peripheral/server role."];
            
            break;
        case CBPeripheralManagerStatePoweredOn:
            //Bluetooth is currently powered on and is available to use.
            if(delegate)[delegate bluetoothPowerState:@"Bluetooth is currently powered on and is available to use."];
            break;
    }
}

-(void)centralManager:(CBCentralManager *)central didRetrievePeripherals:(NSArray *)peripherals
{
    NSLog(@"peripherals==%@",peripherals);
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    NSLog(@"discovered peripheral device ==%@",peripheral);
    
    NSString *string = [NSString stringWithFormat:@"%@",peripheral.name];
    NSLog(@" %@",string);
    
//    if ([string rangeOfString:SCAN_DEVICE_VALIDATION_STRING options:NSCaseInsensitiveSearch].location == NSNotFound)
//    {
//        
//    }
//    else
//    {
        if (![arrCases containsObject:peripheral])
        {
            if ([arrCases count]>0)
            {
                for (int i = 0; i<[arrCases count]; i++)
                {
                    CBPeripheral * p = [arrCases objectAtIndex:i];
                    NSLog(@"p1 ==>>%@",p);
                    NSLog(@"p2 ==>>%@",peripheral);
                    if (peripheral.name == p.name )
                    {
                        NSLog(@"[arrCases addObject:peripheral] second time");
                        [arrCases removeObject:p];
                        [arrCases addObject:peripheral];
                    }
                    else
                    {
                        [arrCases addObject:peripheral];
                    }
                }
            }
            else
            {
                NSLog(@"[arrCases addObject:peripheral] first time");
                [arrCases addObject:peripheral];
            }
            
            [[NSNotificationCenter defaultCenter] postNotificationName:kDidDiscoverPeripheralNotification object:peripheral userInfo:nil];
        }
    
    NSLog(@"arrCases===%@",arrCases);
//    }
}



- (void)centralManager:(CBCentralManager *)central willRestoreState:(NSDictionary *)dict
{
    NSArray *peripherals =dict[CBCentralManagerRestoredStatePeripheralsKey];
    
    if (peripherals.count>0)
    {
        for (CBPeripheral *p in peripherals)
        {
            if (p.state != CBPeripheralStateConnected)
            {
                //[self connectPeripheral:p];
            }
        }
    }
}

- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    if(delegate)[delegate didFailToConnectDevice:peripheral error:error];
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    [rangeDisconnectedTimer invalidate];
    
    for(CBPeripheral * p in arrCases)
    {
//        NSLog(@"CBPeripheral p == %@",p);
        if (p.state == CBPeripheralStateConnected)
        {
            NSMutableArray * arrIDs = [[NSMutableArray alloc] init];
            NSString *queryStr = [NSString stringWithFormat:@"Select * from User_Created_Device where device_id = '%@' AND isPrimaryDevice = 'YES' AND user_id = '%@'",[p name],CURRENT_USER_ID];
            [[DataBaseManager dataBaseManager] execute:queryStr resultsArray:arrIDs];
//            NSLog(@"arrIDs==%@",arrIDs);
            
            if ([arrIDs count]>0)
            {
//                [[BLEService sharedInstance] readDeviceBattery:p];
            }
            else
            {
                NSMutableArray * arrMyCases = [[NSMutableArray alloc] init];
                NSString *queryStr1 = [NSString stringWithFormat:@"Select * from User_Created_Device where device_id = '%@' AND user_id = '%@'",[p name],CURRENT_USER_ID];
                NSLog(@"queryStr--%@",queryStr1);
                [[DataBaseManager dataBaseManager] execute:queryStr1 resultsArray:arrMyCases];
                NSLog(@"arrMyCases==%@",arrMyCases);
                
                if ([arrMyCases count]>0) {
                    [self disconnectDevice:p];
                }else{
                    
                }
            }
        }
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kDeviceDidConnectNotification object:peripheral];
    [[NSNotificationCenter defaultCenter] postNotificationName:kBluetoothSignalUpdateNotification object:peripheral userInfo:nil];
    
    
    //    BLEService *service = nil;
    blutoothService = nil;
    blutoothService = [[BLEService alloc] initWithDevice:peripheral andDelegate:self.serviceDelegate];
    blutoothService.delegate = self;
    [blutoothService startDeviceService];
//    [blutoothService readDeviceBattery:peripheral];
//    [blutoothService readDeviceRSSI:peripheral];
    if (![connectedServices containsObject:blutoothService]){
        [connectedServices addObject:blutoothService];
    }
}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    rssiValue = 0;
    
    [rangeDisconnectedTimer invalidate];
    rangeDisconnectedTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(callRangeDisconnectedTimer:) userInfo:nil repeats:YES];
    //    if(delegate)[delegate didDisconnectDevice:peripheral];
    
    //manual disconnection
    if ([error code]==0){
        NSLog(@"error code is %ld",(long)[error code]);
//        autoConnect = NO;
    }
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kDeviceDidDisConnectNotification object:peripheral];
    [[NSNotificationCenter defaultCenter] postNotificationName:kBluetoothSignalUpdateNotification object:peripheral userInfo:nil];
}

- (void)centralManager:(CBCentralManager *)central didRetrieveConnectedPeripherals:(NSArray *)peripherals
{
    NSLog(@"didRetrieveConnectedPeripherals==%@",peripherals);
    /* Add to list. */
	for (CBPeripheral *peripheral in disconnectedPeripherals)
    {
        if (peripheral.state == CBPeripheralStateConnected)
        {
        }
        else
        {
            NSLog(@"auto reconnecting peripheral %@",peripheral);
          //  [central connectPeripheral:peripheral options:nil];//viral for temporary
        }
	}
}

#pragma mark- Helper Methods
-(void)sendImmediateAlertToBluetoothDeviceWithSignal:(Byte)Signalvalue forPeripheral:(CBPeripheral*)peripheral
{
    NSLog(@"Signalvalue==%d :: peripheral==%@",Signalvalue,peripheral);

    blutoothService = [[BLEService alloc] initWithDevice:peripheral andDelegate:self.serviceDelegate];
    [blutoothService soundBuzzer:Signalvalue peripheral:peripheral];
}

#pragma mark- BLEServiceDelegate----------------------------------------------
-(void)activeDevice:(CBPeripheral*)device
{
    NSLog(@"activeDevice====>%@",device);
}

-(void)updateSignalImage:(int )RSSI forDevice:(CBPeripheral*)device
{
//    NSLog(@"updateSignalImage ==%@",device);
}

-(void)batterySignalValueUpdated:(CBPeripheral*)device withBattLevel:(NSString*)batLevel
{
//    NSLog(@"batterySignalValueUpdated ==%@ withBattLevel==%@",device,batLevel);
    
    NSMutableDictionary * batteryDict = [[NSMutableDictionary alloc] init];
    [batteryDict setObject:device.name forKey:@"PeripheralName"];
    [batteryDict setObject:batLevel forKey:@"batteryLevel"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kBatterySignalValueUpdateNotification object:batteryDict userInfo:nil];
}

#pragma mark - Date Operations
-(NSString*)getCurrentTimeAndDate
{
    NSDate* date = [NSDate date];
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString * currentdate = [df stringFromDate:date];
    return currentdate;
}

-(NSString*)getCurrentDateOnly
{
    NSDate* date = [NSDate date];
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSString * currentdate = [df stringFromDate:date];
    return currentdate;
}


@end
