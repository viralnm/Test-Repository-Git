//
//  AppDelegate.m
//  Heart Rate Monitor
//
//  Created by One Click IT Consultancy  on 5/30/15.
//  Copyright (c) 2015 One Click IT Consultancy . All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

@synthesize homeViewController,registerViewController,rootNavigationViewController,sideMenuViewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    // main scanned device array
    /*-----------main scanned device array----------*/
    arrCases = [[NSMutableArray alloc] init];
    /*----------------------------------------------*/
    
    [BLEManager sharedManager];
    
    [self setFontNameForApp];
    
//    [[Twitter sharedInstance] startWithConsumerKey:@"KL7j2eqsbCm2qYVun2TYWRovX" consumerSecret:@"oAd6tMUmarKbZStgXBFSS6p1U8GMPgbA4IKv5CytaH3nIDd5xy"];
//    [Fabric with:@[[Twitter sharedInstance]]];
    [Fabric with:@[ DigitsKit]];
    
   /* DGTAuthenticateButton *authenticateButton = [DGTAuthenticateButton buttonWithAuthenticationCompletion:^(DGTSession *session, NSError *error) {
        // play with Digits session
    }];
    authenticateButton.center = self.view.center;
    [self.view addSubview:authenticateButton];*/
    
    deviceTokenStr = @"";
    appLatitude = @"";
    appLongitude = @"";
    
    /*-----------Start Location Manager----------*/
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    locationManager.desiredAccuracy = kCLLocationAccuracyBest; // 100 m
    if(IS_OS_8_OR_LATER) {
        [locationManager requestAlwaysAuthorization];
    }
    [locationManager startUpdatingLocation];
    /*-------------------------------------------*/
    
    /*-----------Push Notitications----------*/
    // Register for Push Notitications, if running iOS 8
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)])
    {
        UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes categories:nil];
        [application registerUserNotificationSettings:settings];
        [application registerForRemoteNotifications];
    }
    else
    {
        // Register for Push Notifications before iOS 8
        [application registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound)];
        [application enabledRemoteNotificationTypes];
    }
    
    SplashVC * splash = [[SplashVC alloc] initWithNibName:@"SplashVC" bundle:nil];
    UINavigationController * navControl = [[UINavigationController alloc] initWithRootViewController:splash];
    navControl.navigationBarHidden=YES;
    self.window.rootViewController = navControl;
    
    [_window makeKeyAndVisible];
    
    // Override point for customization after application launch.
    return YES;
}

#pragma mark - Go To Home
-(void) setSlideRootNavigation
{
    homeViewController = [[HomeVC alloc] init];
    sideMenuViewController = [[SideMenuVC alloc] init];
    
    container = [MFSideMenuContainerViewController
                 containerWithCenterViewController:[self navigationController]
                 leftMenuViewController:sideMenuViewController
                 rightMenuViewController:nil];
    
    self.window.rootViewController = container;
}

#pragma mark initialization of controller
- (HomeVC *)demoController
{
    return [[HomeVC alloc] initWithNibName:@"HomeVC" bundle:nil];
}

-(StartUpScreenNew *)loginController
{
    return [[StartUpScreenNew alloc] initWithNibName:@"StartUpScreenNew" bundle:nil];
}

- (UINavigationController *)navigationController
{
    return [[UINavigationController alloc]
            initWithRootViewController:[self demoController]];
}




#pragma mark Remote notification

#ifdef __IPHONE_8_0
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:   (UIUserNotificationSettings *)notificationSettings
{
    //register to receive notifications
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString   *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler
{
    //handle the actions
    if ([identifier isEqualToString:@"declineAction"]){
    }
    else if ([identifier isEqualToString:@"answerAction"]){
    }
}
#endif

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    deviceTokenStr = [[[[deviceToken description]
                        stringByReplacingOccurrencesOfString: @"<" withString: @""]
                       stringByReplacingOccurrencesOfString: @">" withString: @""]
                      stringByReplacingOccurrencesOfString: @" " withString: @""] ;
    NSLog(@"My device token ============================>>>>>>>>>>>%@",deviceTokenStr);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSLog(@"userInfo====================================%@",userInfo);
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    NSLog(@"Failed to get token, error: %@", error);
}


#pragma mark Location manager delegate
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    //  NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil)
    {
        appLatitude =[NSString stringWithFormat:@"%f",currentLocation.coordinate.latitude];
        appLongitude =[NSString stringWithFormat:@"%f",currentLocation.coordinate.longitude];
    }
    NSLog(@"lat==>%f, longt==>%f",currentLocation.coordinate.latitude,currentLocation.coordinate.longitude);
}

#pragma mark Orientation
-(NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - No Network Connection Message
-(void)ShowNoNetworkConnectionPopUpWithErrorCode:(NSInteger)errorCode
{
    if (errorCode == -1004)
    {
        [self ShowNoNetworkConnectionPopUpWithMessage:@"No Network Connection"];
    }
    else if (errorCode == -1009)
    {
        [self ShowNoNetworkConnectionPopUpWithMessage:@"No Network Connection"];
    }
    else if (errorCode == -1005)
    {
        //[self ShowNoNetworkConnectionPopUpWithMessage:@"Network Connection Lost"];
    }
    else if (errorCode == -1001)
    {
        [self ShowNoNetworkConnectionPopUpWithMessage:@"Request Timed Out"];
    }
}

-(void)ShowNoNetworkConnectionPopUpWithMessage:(NSString*)ErrorMessage
{
    [viewNetworkConnectionPopUp removeFromSuperview];
    [viewNetworkConnectionPopUp setAlpha:0.0];
    
    if (![ErrorMessage isEqualToString:@""])
    {
        viewNetworkConnectionPopUp = [[UIView alloc] initWithFrame:CGRectMake(0, 100, 320, 30)];
        [viewNetworkConnectionPopUp setBackgroundColor:[self colorWithHexString:@"ff3b30"]];
        [self.window addSubview:viewNetworkConnectionPopUp];
        [viewNetworkConnectionPopUp setAlpha:0.0];
        
        UIImageView * imgProfile = [[UIImageView alloc] initWithFrame:CGRectMake(50, 7, 16, 16)];
        [imgProfile setImage:[UIImage imageNamed:@"cross.png"]];
        imgProfile.contentMode = UIViewContentModeScaleAspectFit;
        imgProfile.clipsToBounds = YES;
        [viewNetworkConnectionPopUp addSubview:imgProfile];
        
        UILabel * lblMessage = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 240, 30)];
        [lblMessage setBackgroundColor:[UIColor clearColor]];
        [lblMessage setTextColor:[UIColor whiteColor]];
        [lblMessage setTextAlignment:NSTextAlignmentCenter];
        [lblMessage setNumberOfLines:2];
        [lblMessage setText:[NSString stringWithFormat:@"%@",ErrorMessage]];
        [lblMessage setFont:[UIFont systemFontOfSize:14]];
        [viewNetworkConnectionPopUp addSubview:lblMessage];
        
        [UIView transitionWithView:viewNetworkConnectionPopUp duration:1.0
                           options:UIViewAnimationOptionCurveEaseOut
                        animations:^{
                            [viewNetworkConnectionPopUp setAlpha:1.0];
                        }
                        completion:^(BOOL finished)
         {
         }];
    }
    
    [timerNetworkConnectionPopUp invalidate];
    timerNetworkConnectionPopUp = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(removeNetworkConnectionPopUp:) userInfo:nil repeats:NO];
}

#pragma mark - Remove Notification Pop Up
-(void)removeNetworkConnectionPopUp:(NSTimer*)timer
{
    [UIView transitionWithView:viewNetworkConnectionPopUp duration:0.4
                       options:UIViewAnimationOptionCurveEaseOut
                    animations:^{
                        [viewNetworkConnectionPopUp setAlpha:0.0];
                    }
                    completion:^(BOOL finished)
     {
         [viewNetworkConnectionPopUp removeFromSuperview];
     }];
    //    [viewPushNotification removeFromSuperview];
}

#pragma mark SetFontMethod
-(void)setFontNameForApp
{
    NSString *strRegular = @"Comfortaa Regular";
    NSString *strBold = @"Comfortaa Bold";
    NSString *strLight = @"Comfortaa Thin";
    
    for (NSString* family in [UIFont familyNames])
    {
        // NSLog(@"family=======%@",family);
        for (NSString* name in [UIFont fontNamesForFamilyName: family]){
            //  NSLog(@"Hello  %@", name);
            if([strRegular isEqualToString:name]){
                CustomRegularFont = name;
            }
        }
    }
    
    for (NSString* family in [UIFont familyNames])
    {
        for (NSString* name in [UIFont fontNamesForFamilyName: family]){
            // NSLog(@"Hello  %@", name);
            if([strBold isEqualToString:name]){
                CustomBoldFont = name;
            }
        }
    }
    
    for (NSString* family in [UIFont familyNames])
    {
        for (NSString* name in [UIFont fontNamesForFamilyName: family]){
            // NSLog(@"Hello  %@", name);
            if([strLight isEqualToString:name]){
                CustomThinFont = name;
            }
        }
    }
    
    
}


#pragma mark Email validation
-(BOOL)validateEmail:(NSString*)email
{
    if( (0 != [email rangeOfString:@"@"].length) &&  (0 != [email rangeOfString:@"."].length) )
    {
        NSMutableCharacterSet *invalidCharSet = [[[NSCharacterSet alphanumericCharacterSet] invertedSet]mutableCopy];
        [invalidCharSet removeCharactersInString:@"_-"];
        
        NSRange range1 = [email rangeOfString:@"@" options:NSCaseInsensitiveSearch];
        
        // If username part contains any character other than "."  "_" "-"
        
        NSString *usernamePart = [email substringToIndex:range1.location];
        NSArray *stringsArray1 = [usernamePart componentsSeparatedByString:@"."];
        for (NSString *string in stringsArray1)
        {
            NSRange rangeOfInavlidChars=[string rangeOfCharacterFromSet: invalidCharSet];
            if(rangeOfInavlidChars.length !=0 || [string isEqualToString:@""])
                return FALSE;
        }
        
        NSString *domainPart = [email substringFromIndex:range1.location+1];
        NSArray *stringsArray2 = [domainPart componentsSeparatedByString:@"."];
        
        for (NSString *string in stringsArray2)
        {
            NSRange rangeOfInavlidChars=[string rangeOfCharacterFromSet:invalidCharSet];
            if(rangeOfInavlidChars.length !=0 || [string isEqualToString:@""])
                return FALSE;
        }
        
        return TRUE;
    }
    else {// no '@' or '.' present
        return FALSE;
    }
}

#pragma mark Color with hex values
-(UIColor *) colorWithHexString:(NSString *)stringToConvert
{
    
    // NSLog(@"ColorCode -- %@",stringToConvert);
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    
    if ([cString length] < 6) return [UIColor blackColor];
    
    // strip 0X if it appears
    
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return [UIColor blackColor];
    
    // Separate into r, g, b substrings
    
    NSRange range;
    
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
            
                           green:((float) g / 255.0f)
            
                            blue:((float) b / 255.0f)
            
                           alpha:1.0f];
}

#pragma mark - Date Conversion
-(NSString *)getUTCFormateDate:(NSDate *)localDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:localDate];
    return dateString;
}

-(NSString *)getUTCFormateDateONLY:(NSDate *)localDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:localDate];
    return dateString;
}

#pragma mark - Application Life Cycle
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
