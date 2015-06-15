//
//  Constant.h
//  ibeacon stores
//
//  Created by One Click IT Consultancy  on 5/14/14.
//  Copyright (c) 2014 One Click IT Consultancy . All rights reserved.
//

#import <Foundation/Foundation.h>


//#define WEB_SERVICE_TOKEN @"3e3d7f49a85bd118a62743f392169e1b"
#define WEB_SERVICE_TOKEN @"test token"

//#define kGOOGLE_API_KEY  @"AIzaSyBvPHdOTL50rBSKu2gPiQJ_ipZxgNWfNxA" //com.oneclick.mobilesafegaurd
//#define kGOOGLE_API_KEY  @"31058062843-u0ko28teqgn2origf84nr7rg0stv703f.apps.googleusercontent.com"
#define kGOOGLE_API_KEY  @"AIzaSyA1eIzaEXxjYOxu5c1t8yLHKoJjwcOBTVY"   //com.oneclick.smartarmor


#define kClientId    @"101046264356-lqncecos6vad4dp4ej4gmokvgtagl64r.apps.googleusercontent.com"

@protocol Constant <NSObject>

typedef enum ScrollDirection {
    ScrollDirectionNone,
    ScrollDirectionRight,
    ScrollDirectionLeft,
    ScrollDirectionUp,
    ScrollDirectionDown,
    ScrollDirectionCrazy,
} ScrollDirection;



#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)



#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_5 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 568.0f)
#define IS_IPAD ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)


#define APP_DELEGATE (AppDelegate*)[[UIApplication sharedApplication]delegate]

//#define WEB_SERVICE_URL @"http://103.240.35.200/subdomain/mobilesafe/webservice/"
//#define WEB_SERVICE_URL @"http://162.242.240.213/webservice/" //client server
#define WEB_SERVICE_URL @"http://103.240.35.200/subdomain/heart_beat_monitor/webservice/" //client server

//#define Alert_Animation_Type URBAlertAnimationTumble
#define Alert_Animation_Type URBAlertAnimationTopToBottom


#define ALERT_TITLE @"Smart Armor"
#define OK_BTN @"OK"
#define ALERT_CANCEL  @"Cancel"

#define ACTION_TAKE_PHOTO       @"Take Photo"
#define ACTION_LIBRARY_PHOTO    @"Photo From Library"
#define CONNECTION_FAILED @"Please check internet connection"

#define SCAN_DEVICE_VALIDATION_STRING @"SenseGiz-Find"
//#define SCAN_DEVICE_VALIDATION_STRING @"Smart-Armor"


#pragma mark User Credential-----------------------------------------
#define CURRENT_USER_EMAIL [[NSUserDefaults standardUserDefaults] stringForKey:@"User_Email"]
#define CURRENT_USER_USERNAME [[NSUserDefaults standardUserDefaults] stringForKey:@"User_Name"]

#define CURRENT_USER_ID [[NSUserDefaults standardUserDefaults] stringForKey:@"userId"]
#define CURRENT_USER_TWITTER_ID [[NSUserDefaults standardUserDefaults] stringForKey:@"CURRENT_User_Twitter_Session_Id"]
#define CURRENT_USER_FIRSTNAME [[NSUserDefaults standardUserDefaults] stringForKey:@"User_Firstname"]
#define CURRENT_USER_LASTNAME [[NSUserDefaults standardUserDefaults] stringForKey:@"User_Lastname"]
#define CURRENT_USER_Phone [[NSUserDefaults standardUserDefaults] stringForKey:@"User_Phone"]
#define CURRENT_USER_PROFILE_IMAGE [[NSUserDefaults standardUserDefaults] stringForKey:@"User_Image"]
#define CURRENT_USER_HEIGHT [[NSUserDefaults standardUserDefaults] stringForKey:@"User_Height"]
#define CURRENT_USER_WEIGHT [[NSUserDefaults standardUserDefaults] stringForKey:@"User_Weight"]
#define CURRENT_USER_BIRTHDATE [[NSUserDefaults standardUserDefaults] stringForKey:@"User_Birthdate"]
#define CURRENT_USER_GENDER [[NSUserDefaults standardUserDefaults] stringForKey:@"User_Gender"]



#define IS_Password_Saved [[NSUserDefaults standardUserDefaults] stringForKey:@"IS_Password_Saved"]
#define V_IS_Auto_Connect [[NSUserDefaults standardUserDefaults] boolForKey:@"isAutoConnectDevice"]

#define IS_Range_Alert_ON [[NSUserDefaults standardUserDefaults] stringForKey:@"IS_Range_Alert_ON"]
#define Range_Alert_Value [[NSUserDefaults standardUserDefaults] stringForKey:@"Range_Alert_Value"]


#pragma mark - Notifications

#define kOnConnectNotification @"onConnectNotification"
#define kOnDisconnectNotification @"onDisconnectNotification"

#define kBluetoothSignalUpdateNotification @"bluetoothSignalUpdateNotification"
#define kBatterySignalValueUpdateNotification @"batterySignalValueUpdateNotification"

#define kDidDiscoverPeripheralNotification @"didDiscoverPeripheralNotification"
#define kDeviceDidConnectNotification @"deviceDidConnectNotification"
#define kDeviceDidDisConnectNotification @"deviceDidDisConnectNotification"

#define kRefreshSearchAnimation @"refreshSearchAnimation"

#pragma mark - Color Codes
#define dark_green_color @"39b54a"
#define dark_red_color @"ff3b30"



#pragma mark - Bluetooth Service UUIDS
#define POLARH7_HRM_DEVICE_INFO_SERVICE_UUID @"180A"       // 180A = Device Information
#define POLARH7_HRM_HEART_RATE_SERVICE_UUID @"180D"        // 180D = Heart Rate Service
#define POLARH7_HRM_ENABLE_SERVICE_UUID @"2A39"
#define POLARH7_HRM_NOTIFICATIONS_SERVICE_UUID @"2A37"
#define POLARH7_HRM_BODY_LOCATION_UUID @"2A38"
#define POLARH7_HRM_MANUFACTURER_NAME_UUID @"2A29"

#define HEX_POLARH7_HRM_DEVICE_INFO_SERVICE_UUID 0x180A       // 180A = Device Information
#define HEX_POLARH7_HRM_HEART_RATE_SERVICE_UUID 0x180D        // 180D = Heart Rate Service
#define HEX_POLARH7_HRM_ENABLE_SERVICE_UUID 0x2A39
#define HEX_POLARH7_HRM_NOTIFICATIONS_SERVICE_UUID 0x2A37
#define HEX_POLARH7_HRM_BODY_LOCATION_UUID 0x2A38
#define HEX_POLARH7_HRM_MANUFACTURER_NAME_UUID 0x2A29



#pragma mark - Color Codes------------------
#define orange_color @"fa7965"
#define yellow_color @"fcbd21"
#define sky_blue_color @"008bbc"
#define dark_gray_color @"4d4d4d"
#define light_gray_bg_color @"f6f6f6"
#define dark_green_color @"39b54a"
#define light_green_color @"b3c833"
#define dark_red_color @"ff3b30"

#define pink_color @"ff005c"

@end
