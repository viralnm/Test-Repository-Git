//
//  AppDelegate.h
//  Heart Rate Monitor
//
//  Created by One Click IT Consultancy  on 5/30/15.
//  Copyright (c) 2015 One Click IT Consultancy . All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreLocation/CoreLocation.h>
#import <Fabric/Fabric.h>
#import <TwitterKit/TwitterKit.h>
#import <DigitsKit/DigitsKit.h>

#import "SplashVC.h"
#import "SideMenuVC.h"
#import "BLEManager.h"
#import "BLEService.h"

#import "MFSideMenu.h"

double rssiValue;
NSMutableArray * arrCases;

NSString * appLatitude;
NSString * appLongitude;

NSString * deviceTokenStr;

NSString * CustomRegularFont;
NSString * CustomBoldFont;
NSString * CustomThinFont;

@interface AppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate>
{
    MFSideMenuContainerViewController *container;
    
    CLLocationManager * locationManager;
    
    UIView * viewNetworkConnectionPopUp;
    NSTimer * timerNetworkConnectionPopUp;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) HomeVC *homeViewController;
@property (strong, nonatomic) RegisterVC1 *registerViewController;
@property (strong, nonatomic) SideMenuVC *sideMenuViewController;

@property (strong, nonatomic) UINavigationController *rootNavigationViewController;


-(UIColor *) colorWithHexString:(NSString *)stringToConvert;
-(BOOL)validateEmail:(NSString*)email;

-(NSString *)getUTCFormateDate:(NSDate *)localDate;
-(NSString *)getUTCFormateDateONLY:(NSDate *)localDate;

-(void)ShowNoNetworkConnectionPopUpWithMessage:(NSString*)ErrorMessage;
-(void)ShowNoNetworkConnectionPopUpWithErrorCode:(NSInteger)errorCode;

@end

