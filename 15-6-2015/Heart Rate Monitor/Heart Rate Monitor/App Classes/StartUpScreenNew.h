//
//  StartUpScreenNew.h
//  LOV
//
//  Created by Oneclick IT Solution on 2/13/15.
//  Copyright (c) 2015 One Click IT Consultancy Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <Fabric/Fabric.h>
#import <TwitterKit/TwitterKit.h>

#import "RegisterVC1.h"
#import <MediaPlayer/MediaPlayer.h>

#import "URLManager.h"
#import "MBProgressHUD.h"

#import "MFSideMenu.h"
#import "SideMenuVC.h"

@class AppDelegate;

@interface StartUpScreenNew : UIViewController<UIScrollViewDelegate,URLManagerDelegate>
{
    MBProgressHUD * HUD;
        
    UIScrollView * scrlContent;
    UIPageControl * pageControl;
    
    UIImageView * imgLogo;
    UIImageView * imgLogoName;
    
    UIView * viewBottom;
    
    UILabel * lblMessage;
    
    UILabel * lblTempMessage;
    
    MPMoviePlayerController *moviePlayerController;
    
//    DGTAuthenticateButton *digitsButton;
    
    AppDelegate * addDelegate;
    
    MFSideMenuContainerViewController *container;
}

@property(nonatomic,strong)NSMutableDictionary * userDict;

@property (strong, nonatomic) SideMenuVC *sideMenuViewController;

@end
