//
//  BLEService.m
//  
//
//  Created by Oneclick IT Solution on 7/11/14.
//  Copyright (c) 2014 One Click IT Consultancy Pvt Ltd, Ind. All rights reserved.
//

#import "BLEService.h"
#import "BLEManager.h"

#import "AppDelegate.h"


#define TI_KEYFOB_LEVEL_SERVICE_UUID                        0x2A19
#define TI_KEYFOB_BATT_SERVICE_UUID                         0x180F
#define TI_KEYFOB_PROXIMITY_ALERT_WRITE_LEN                 1
#define TI_KEYFOB_PROXIMITY_ALERT_UUID                      0x1802
#define TI_KEYFOB_PROXIMITY_ALERT_PROPERTY_UUID             0x2a06

static BLEService	*sharedInstance	= nil;

@interface BLEService ()<CBPeripheralDelegate,AVAudioPlayerDelegate>
{
    NSMutableArray *assignedDevices;

    AVAudioPlayer *songAlarmPlayer1;
}

@property (nonatomic, strong) CBPeripheral *servicePeripheral;
@property (nonatomic,strong) NSMutableArray *servicesArray;
@end

@implementation BLEService
@synthesize servicePeripheral;

@synthesize heartRate,bodyData,manufacturer;

#pragma mark- Self Class Methods
-(id)init{
    self = [super init];
    if (self) {
        //do additional work
    }
    return self;
}

+ (instancetype)sharedInstance
{
	if (!sharedInstance)
		sharedInstance = [[BLEService alloc] init];
    
	return sharedInstance;
}

-(id)initWithDevice:(CBPeripheral*)device andDelegate:(id /*<BLEServiceDelegate>*/)delegate{
    self = [super init];
    if (self) {
        _delegate = delegate;
        [device setDelegate:self];
//        [servicePeripheral setDelegate:self];
        servicePeripheral = device;
    }
    return self;
}

-(void)startDeviceService{
    [servicePeripheral discoverServices:nil];
}

-(void) readDeviceBattery:(CBPeripheral *)device{
    
//    NSLog(@"readDeviceBattery==%@",device);
    if (device.state != CBPeripheralStateConnected) {
        return;
    }else{
        [self notification:TI_KEYFOB_BATT_SERVICE_UUID characteristicUUID:TI_KEYFOB_LEVEL_SERVICE_UUID p:device on:YES];
    }
}

-(void)readDeviceRSSI:(CBPeripheral *)device
{
//    NSLog(@"device==%@",device);
    if (device.state == CBPeripheralStateConnected)
    {
        [device readRSSI];
    }else{
        return;
    }
}

-(void)startBuzzer:(CBPeripheral*)device{
    NSLog(@"startBuzzer called");
    NSLog(@"startBuzzer called with device ==%@",device);

//     [self soundBuzzer:0x06 peripheral:device];

    if (device == nil || device.state != CBPeripheralStateConnected) {
        return;
    }else{
        NSLog(@"startBuzzer==0x10");
        [self soundBuzzer:0x06 peripheral:device];
        //to know, from which OS the device has been connected i.e., iOS/Android
//        [self soundBuzzer:0x0D peripheral:device];
    }
}

-(void)stopBuzzer:(CBPeripheral*)device{
    if (device == nil || device.state != CBPeripheralStateConnected) {
        return;
    }else{
        [self soundBuzzer:0x07 peripheral:device];
    }
}

#pragma mark- CBPeripheralDelegate
- (void) peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
	NSArray		*services	= nil;
	if (peripheral != servicePeripheral)
    {
		NSLog(@"Wrong Peripheral.\n");
		return ;
	}
    
    if (error != nil)
    {
        NSLog(@"Error %@\n", error);
		return ;
	}
    
	services = [peripheral services];
        
	if (!services || ![services count])
    {
		return ;
	}
    
    if (!error)
    {
        //        printf("Services of peripheral with UUID : %s found\r\n ",[self UUIDToString:peripheral.UUID],peripheral.services);
        [self getAllCharacteristicsFromKeyfob:peripheral];
    }
    else
    {
        printf("Service discovery was unsuccessfull !\r\n");
    }
}

- (void) peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error;
{
	NSArray		*characteristics	= [service characteristics];
    //NSLog(@"didDiscoverCharacteristicsForService %@",characteristics);
	CBCharacteristic *characteristic;
    
	if (peripheral != servicePeripheral) {
		//NSLog(@"didDiscoverCharacteristicsForService Wrong Peripheral.\n");
		return ;
	}
	
    if (error != nil) {
		//NSLog(@"didDiscoverCharacteristicsForService Error %@\n", error);
		return ;
	}
    
	for (characteristic in characteristics)
    {
        UInt16 characteristicUUID = [self CBUUIDToInt:characteristic.UUID];
        
        switch(characteristicUUID)
        {
            case TI_KEYFOB_LEVEL_SERVICE_UUID:
            {
                char batlevel;
                [characteristic.value getBytes:&batlevel length:1];
                if (_delegate) {
                    [_delegate activeDevice:peripheral];
                }
                //sending code to identify the from which app it has benn connected i.e, either Find App/others....
//                [self soundBuzzer:0x0E peripheral:peripheral];//used for senseGiz-Find
//                //to know, from which OS the device has been connected i.e., iOS/Android
//                [self soundBuzzer:0x0D peripheral:peripheral];//used for senseGiz-Find
                
                break;
            }
            case HEX_POLARH7_HRM_NOTIFICATIONS_SERVICE_UUID:
            {
                [self.servicePeripheral setNotifyValue:YES forCharacteristic:characteristic];
                break;
            }
//            case HEX_POLARH7_HRM_BODY_LOCATION_UUID:
//            {
//                [self.servicePeripheral readValueForCharacteristic:characteristic];
//                break;
//            }
//            case HEX_POLARH7_HRM_MANUFACTURER_NAME_UUID:
//            {
//                [self.servicePeripheral readValueForCharacteristic:characteristic];
//                break;
//            }
        }
	}
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
//    NSLog(@"didUpdateNotificationStateForCharacteristic");
    [self readValue:TI_KEYFOB_BATT_SERVICE_UUID characteristicUUID:TI_KEYFOB_LEVEL_SERVICE_UUID p:peripheral];
}

- (void) peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    NSLog(@"didUpdateValueForCharacteristic==%@",characteristic);
    UInt16 characteristicUUID = [self CBUUIDToInt:characteristic.UUID];
    
    switch(characteristicUUID)
    {
        /*case TI_KEYFOB_LEVEL_SERVICE_UUID:
        {
            char batlevel;
            [characteristic.value getBytes:&batlevel length:1];
            NSString *battervalStr = [NSString stringWithFormat:@"%f",(float)batlevel];
            if (_delegate) {
                [_delegate batterySignalValueUpdated:peripheral withBattLevel:battervalStr];
            }
            //0x65
            if (batlevel == 101)
            {
                NSLog(@"decide owner here");
            }
            break;
        }
        case TI_KEYFOB_BATT_SERVICE_UUID:
        {
            char alertSignal;
            
            [characteristic.value getBytes:&alertSignal length:1];
            
            NSLog(@"alertSignal %@",[NSString stringWithFormat:@"%c",alertSignal]);
            
            break;
        }*/
        case HEX_POLARH7_HRM_NOTIFICATIONS_SERVICE_UUID:
        {
//            [self.servicePeripheral setNotifyValue:YES forCharacteristic:characteristic];
            [self getHeartBPMData:characteristic error:error];
            break;
        }
//        case HEX_POLARH7_HRM_BODY_LOCATION_UUID:
//        {
//            [self.servicePeripheral readValueForCharacteristic:characteristic];
//            break;
//        }
//        case HEX_POLARH7_HRM_MANUFACTURER_NAME_UUID:
//        {
//            [self.servicePeripheral readValueForCharacteristic:characteristic];
//            break;
//        }
    }
}

- (void)peripheralDidUpdateRSSI:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@"peripheralDidUpdateRSSI peripheral.name ==%@ ::RSSI ==%f, error==%@",peripheral.name,[peripheral.RSSI doubleValue],error);

    if (error == nil)
    {
        if(peripheral == nil)
            return;
        
        if (peripheral != servicePeripheral)
        {
            NSLog(@"Wrong peripheral\n");
            return ;
        }
        
        if (peripheral==servicePeripheral)
        {
            if (_delegate) {
                //            [_delegate updateSignalImage:[[peripheral RSSI] intValue] forDevice:peripheral];
                [_delegate updateSignalImage:[peripheral.RSSI doubleValue] forDevice:peripheral];
            }
            rssiValue = [peripheral.RSSI doubleValue];
            
            NSLog(@"rssiValue peripheralDidUpdateRSSI =====================================================>>%f",rssiValue);
            
           /* if (peripheral.state == CBPeripheralStateConnected)
            {
                if (rssiValue !=0)
                {
                    if ([Range_Alert_Value integerValue]<40)
                    {
                        if (rssiValue < -55)
                        {
                            [self playSoundWhenDeviceRSSIisLow];
                        }
                    }
                    else if ([Range_Alert_Value integerValue]>=40 && [Range_Alert_Value integerValue]<90)
                    {
                        if (rssiValue < -80)
                        {
                            [self playSoundWhenDeviceRSSIisLow];
                        }
                    }
                    else if([Range_Alert_Value integerValue]>90)
                    {
                        if (rssiValue < -96)
                        {
//                            [self stopPlaySound];
                            [self playSoundWhenDeviceRSSIisLow];
                        }
                    }
                }
                else
                {
                   // [self playSoundWhenDeviceRSSIisLow]; //comment due to app is randomly beep when rssi is 0
                }
            }*/
        }
    }
}

-(void) peripheral:(CBPeripheral *)peripheral didReadRSSI:(NSNumber *)RSSI error:(NSError *)error
{
    NSLog(@"didReadRSSI peripheral.name ==%@ ::RSSI ==%f, error==%@",peripheral.name,[RSSI doubleValue],error);
    
    if(peripheral == nil)
        return;
    
    if (peripheral != servicePeripheral)
    {
        //NSLog(@"Wrong peripheral\n");
        return ;
    }
    
    if (peripheral==servicePeripheral)
    {
       /* if (_delegate) {
//            [_delegate updateSignalImage:[[peripheral RSSI] intValue] forDevice:peripheral];
            [_delegate updateSignalImage:[RSSI doubleValue] forDevice:peripheral];
        }*/ //viral right now not required
        
//        rssiValue = [RSSI doubleValue];
        
      /*  if (tempRSSI == 0) {
            tempRSSI = [RSSI doubleValue];
        }else{
            tempRSSI = rssiValue;
        }
        
        rssiValue = [RSSI doubleValue];
        
        if (tempRSSI != 0) {
            rssiValue = tempRSSI+rssiValue;
            rssiValue = rssiValue/2;
        }else{
            rssiValue = [RSSI doubleValue];
        }
        
        NSLog(@"rssiValue=====================================================>>%f",rssiValue);
//        NSLog(@"Range_Alert_Value=====================================================>>%@",Range_Alert_Value);
        
        if (peripheral.state == CBPeripheralStateConnected)
        {
            if (rssiValue !=0)
            {
                if ([Range_Alert_Value integerValue]<40)
                {
                    if (rssiValue < -55)
                    {
                        [self playSoundWhenDeviceRSSIisLow];
                    }
                }
                else if ([Range_Alert_Value integerValue]>=40 && [Range_Alert_Value integerValue]<90)
                {
                    if (rssiValue < -80)
                    {
                        [self playSoundWhenDeviceRSSIisLow];
                    }
                }
                else if([Range_Alert_Value integerValue]>90)
                {
                    if (rssiValue < -96)
                    {
                        [self playSoundWhenDeviceRSSIisLow];
                    }
                }
            }
            else
            {
               // [self playSoundWhenDeviceRSSIisLow]; //comment due to app is randomly beep when rssi is 0
            }
            
        }*/
    }
}


#pragma mark - POLAR Helper 
// Instance method to get the heart rate BPM information
- (void) getHeartBPMData:(CBCharacteristic *)characteristic error:(NSError *)error
{
    // Get the Heart Rate Monitor BPM
    NSData *data = [characteristic value];      // 1
    const uint8_t *reportData = [data bytes];
    uint16_t bpm = 0;
    
    if ((reportData[0] & 0x01) == 0) {          // 2
        // Retrieve the BPM value for the Heart Rate Monitor
        bpm = reportData[1];
    }
    else {
        bpm = CFSwapInt16LittleToHost(*(uint16_t *)(&reportData[1]));  // 3
    }
    // Display the heart rate value to the UI if no error occurred
    if( (characteristic.value)  || !error ) {   // 4
        self.heartRate = bpm;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"getHeartBeatNotification" object:[NSString stringWithFormat:@"%i", bpm]];
        
//
        NSLog(@"heartRate===%hu",heartRate);
//        self.heartRateBPM.text = [NSString stringWithFormat:@"%i bpm", bpm];
//        self.heartRateBPM.font = [UIFont fontWithName:@"Futura-CondensedMedium" size:28];
//        [self doHeartBeat];
//        self.pulseTimer = [NSTimer scheduledTimerWithTimeInterval:(60. / self.heartRate) target:self selector:@selector(doHeartBeat) userInfo:nil repeats:NO];//viral
    }
    return;
}

// Instance method to get the manufacturer name of the device
- (void) getManufacturerName:(CBCharacteristic *)characteristic
{
    NSString *manufacturerName = [[NSString alloc] initWithData:characteristic.value encoding:NSUTF8StringEncoding];
    self.manufacturer = [NSString stringWithFormat:@"Manufacturer: %@", manufacturerName];
    NSLog(@"manufacturer===%@",manufacturer);
    return;
}

// Instance method to get the body location of the device
- (void) getBodyLocation:(CBCharacteristic *)characteristic
{
    NSData *sensorData = [characteristic value];
    uint8_t *bodyData = (uint8_t *)[sensorData bytes];
    if (bodyData ) {
        uint8_t bodyLocation = bodyData[0];
        self.bodyData = [NSString stringWithFormat:@"Body Location: %@", bodyLocation == 1 ? @"Chest" : @"Undefined"];
    }
    else {
        self.bodyData = [NSString stringWithFormat:@"Body Location: N/A"];
    }
    NSLog(@"bodyData===%@",bodyData);

    return;
}

#pragma mark- Helper Methods
-(int) compareCBUUID:(CBUUID *) UUID1 UUID2:(CBUUID *)UUID2 {
    char b1[16];
    char b2[16];
    [UUID1.data getBytes:b1];
    [UUID2.data getBytes:b2];
    if (memcmp(b1, b2, UUID1.data.length) == 0)return 1;
    else return 0;
}

-(const char *) CBUUIDToString:(CBUUID *) UUID
{
    return [[UUID.data description] cStringUsingEncoding:NSStringEncodingConversionAllowLossy];
}

-(CBService *) findServiceFromUUID:(CBUUID *)UUID p:(CBPeripheral *)p
{
    for(int i = 0; i < p.services.count; i++) {
        CBService *s = [p.services objectAtIndex:i];
        if ([self compareCBUUID:s.UUID UUID2:UUID]) return s;
    }
    return nil; //Service not found on this peripheral
}

-(UInt16) swap:(UInt16)s
{
    UInt16 temp = s << 8;
    temp |= (s >> 8);
    return temp;
}

-(CBCharacteristic *) findCharacteristicFromUUID:(CBUUID *)UUID service:(CBService*)service {
    for(int i=0; i < service.characteristics.count; i++)
    {
        CBCharacteristic *c = [service.characteristics objectAtIndex:i];
        if ([self compareCBUUID:c.UUID UUID2:UUID]) return c;
    }
    return nil; //Characteristic not found on this service
}

-(void) notification:(int)serviceUUID characteristicUUID:(int)characteristicUUID p:(CBPeripheral *)p on:(BOOL)on {
    UInt16 s = [self swap:serviceUUID];
    UInt16 c = [self swap:characteristicUUID];
    NSData *sd = [[NSData alloc] initWithBytes:(char *)&s length:2];
    NSData *cd = [[NSData alloc] initWithBytes:(char *)&c length:2];
    CBUUID *su = [CBUUID UUIDWithData:sd];
    CBUUID *cu = [CBUUID UUIDWithData:cd];
    CBService *service = [self findServiceFromUUID:su p:p];
    if (!service) {
        NSLog(@"Could not find service with UUID %s on peripheral with UUID %@ \r\n",[self CBUUIDToString:su],p.identifier.UUIDString);
        return;
    }
    CBCharacteristic *characteristic = [self findCharacteristicFromUUID:cu service:service];
    if (!characteristic) {
        NSLog(@"Could not find characteristic with UUID %s on service with UUID %s on peripheral with UUID %@ \r\n",[self CBUUIDToString:cu],[self CBUUIDToString:su],p.identifier.UUIDString);
        return;
    }
    [p setNotifyValue:on forCharacteristic:characteristic];
}

-(void) getAllCharacteristicsFromKeyfob:(CBPeripheral *)p
{
    for (int i=0; i < p.services.count; i++)
    {
        CBService *s = [p.services objectAtIndex:i];
        if ( self.servicesArray )
        {
            if ( ! [self.servicesArray containsObject:s.UUID] )
                [self.servicesArray addObject:s.UUID];
        }
        else
            self.servicesArray = [[NSMutableArray alloc] initWithObjects:s.UUID, nil];
        
        [p discoverCharacteristics:nil forService:s];
    }
    NSLog(@" services array is %@",self.servicesArray);
}

-(UInt16) CBUUIDToInt:(CBUUID *) UUID
{
    char b1[16];
    [UUID.data getBytes:b1];
    return ((b1[0] << 8) | b1[1]);
}

-(void) soundBuzzer:(Byte)buzzerValue peripheral:(CBPeripheral *)peripheral
{
    NSLog(@"buzzerValue==%d",buzzerValue);
    NSData *d = [[NSData alloc] initWithBytes:&buzzerValue length:TI_KEYFOB_PROXIMITY_ALERT_WRITE_LEN];
    
    [self writeValue:TI_KEYFOB_PROXIMITY_ALERT_UUID characteristicUUID:TI_KEYFOB_PROXIMITY_ALERT_PROPERTY_UUID p:peripheral data:d];
}

-(void) readValue: (int)serviceUUID characteristicUUID:(int)characteristicUUID p:(CBPeripheral *)p
{
    UInt16 s = [self swap:serviceUUID];
    UInt16 c = [self swap:characteristicUUID];
    NSData *sd = [[NSData alloc] initWithBytes:(char *)&s length:2];
    NSData *cd = [[NSData alloc] initWithBytes:(char *)&c length:2];
    CBUUID *su = [CBUUID UUIDWithData:sd];
    CBUUID *cu = [CBUUID UUIDWithData:cd];
    CBService *service = [self findServiceFromUUID:su p:p];
    if (!service) {
        NSLog(@"Could not find service with UUID %s on peripheral with UUID %@ \r\n",[self CBUUIDToString:su],p.identifier.UUIDString);
        return;
    }
    CBCharacteristic *characteristic = [self findCharacteristicFromUUID:cu service:service];
    if (!characteristic) {
        NSLog(@"Could not find characteristic with UUID %s on service with UUID %s on peripheral with UUID %@ \r\n",[self CBUUIDToString:cu],[self CBUUIDToString:su],p.identifier.UUIDString);
        return;
    }
    [p readValueForCharacteristic:characteristic];
}

-(void) writeValue:(int)serviceUUID characteristicUUID:(int)characteristicUUID p:(CBPeripheral *)p data:(NSData *)data
{
    UInt16 s = [self swap:serviceUUID];
    UInt16 c = [self swap:characteristicUUID];
    NSData *sd = [[NSData alloc] initWithBytes:(char *)&s length:2];
    NSData *cd = [[NSData alloc] initWithBytes:(char *)&c length:2];
    CBUUID *su = [CBUUID UUIDWithData:sd];
    CBUUID *cu = [CBUUID UUIDWithData:cd];
    CBService *service = [self findServiceFromUUID:su p:p];
    if (!service) {
        NSLog(@"Could not find service with UUID %s on peripheral with UUID %@ \r\n",[self CBUUIDToString:su],p.identifier.UUIDString);
        return;
    }
    CBCharacteristic *characteristic = [self findCharacteristicFromUUID:cu service:service];
    if (!characteristic) {
        NSLog(@"Could not find characteristic with UUID %s on service with UUID %s on peripheral with UUID %@ \r\n",[self CBUUIDToString:cu],[self CBUUIDToString:su],p.identifier.UUIDString);
        return;
    }
    
    NSLog(@" ***** find data *****%@",data);
    NSLog(@" ***** find data *****%@",characteristic);
    
    [p writeValue:data forCharacteristic:characteristic type:CBCharacteristicWriteWithoutResponse];
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

@end
