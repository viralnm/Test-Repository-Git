//
//  SplashVC.h
//  LOV
//
//  Created by Oneclick IT Solution on 1/13/15.
//  Copyright (c) 2015 One Click IT Consultancy Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>



#import "Constant.h"
#import "AppDelegate.h"
#import "HomeVC.h"

#import "StartUpScreenNew.h"
#import "SideMenuVC.h"

#import "MFSideMenu.h"
@class AppDelegate;

@interface SplashVC : UIViewController
{
    UIImageView * imgLogoName;
    UIImageView * imgLogo;
    
    AppDelegate * addDelegate;
    
    NSTimer * colorTimer;
    
    MFSideMenuContainerViewController *container;
}

@property (strong, nonatomic) SideMenuVC *sideMenuViewController;


@end
