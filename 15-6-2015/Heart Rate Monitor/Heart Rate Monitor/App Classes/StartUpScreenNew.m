//
//  StartUpScreenNew.m
//  LOV
//
//  Created by Oneclick IT Solution on 2/13/15.
//  Copyright (c) 2015 One Click IT Consultancy Pvt Ltd. All rights reserved.
//

#import "StartUpScreenNew.h"

@interface StartUpScreenNew ()

@end

@implementation StartUpScreenNew

@synthesize userDict;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    addDelegate =(AppDelegate *) [[UIApplication sharedApplication] delegate];
    
//    [self setMoviePlayerView];
    
    userDict= [[NSMutableDictionary alloc] init];
    //    [self setPagedScroll];
    
    UIImageView * imgBg ;
    if (IS_IPHONE_5) {
        imgBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
        [imgBg setImage:[UIImage imageNamed:@"sp1_iPhone_5_bg.png"]];
    }else{
        imgBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
        [imgBg setImage:[UIImage imageNamed:@"sp1_iPhone_4_bg.png"]];
    }
    [self.view addSubview:imgBg];
    //    [self setBottomView];
    
//    UIView * viewOverlay = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
//    [viewOverlay setBackgroundColor:[UIColor darkGrayColor]];
//    [viewOverlay setAlpha:0.3];
//    [self.view addSubview:viewOverlay];
    
    
    if (IS_IPHONE_5) {
        imgLogo = [[UIImageView alloc] initWithFrame:CGRectMake(140, -40, 40, 40)];
    }else{
        imgLogo = [[UIImageView alloc] initWithFrame:CGRectMake(140, -40, 40, 40)];
    }
    [imgLogo setAlpha:0.9];
    imgLogo.contentMode = UIViewContentModeScaleAspectFit;
    [imgLogo setImage:[UIImage imageNamed:@"heartlogo.png"]];
//    [self.view addSubview:imgLogo];
    imgLogo.hidden=YES ;
    
    
    if (IS_IPHONE_5) {
        imgLogoName = [[UIImageView alloc] initWithFrame:CGRectMake(68, 568, 184, 62)];
    }else{
        imgLogoName = [[UIImageView alloc] initWithFrame:CGRectMake(68, 480, 184, 62)];
    }
    [imgLogoName setAlpha:0.75];
//    [imgLogoName setImage:[UIImage imageNamed:@"textlov.png"]];
    [imgLogoName setImage:[UIImage imageNamed:@"heart.png"]];
    [imgLogoName setUserInteractionEnabled:NO];
//    [self.view addSubview:imgLogoName];
    
    
    if (IS_IPHONE_5) {
        lblTempMessage = [[UILabel alloc] initWithFrame:CGRectMake(50, 568, 220, 120)];
    }else{
        lblTempMessage = [[UILabel alloc] initWithFrame:CGRectMake(50, 480, 220, 120)];
    }
    [lblTempMessage setBackgroundColor:[UIColor clearColor]];
    [lblTempMessage setTextColor:[UIColor whiteColor]];
    [lblTempMessage setText:@"Measure Your Heart Rate Whenever You Are"];
    [lblTempMessage setFont:[UIFont fontWithName:CustomRegularFont size:14]];
    [lblTempMessage setNumberOfLines:3];
    [lblTempMessage setTextAlignment:NSTextAlignmentCenter];
    [lblTempMessage setAlpha:0.75];
//    [self.view addSubview:lblTempMessage];
//    [lblTempMessage setHidden:YES];
    
    
    NSString* string = lblTempMessage.text;
    NSMutableParagraphStyle *style  = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = 4;
    NSDictionary *attributtes = @{NSParagraphStyleAttributeName : style};
    lblTempMessage.attributedText = [[NSAttributedString alloc] initWithString:string attributes:attributtes];
    lblTempMessage.textAlignment = NSTextAlignmentCenter;
    
    
    if (IS_IPHONE_5) {
        pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(110, 568 , 100, 20)];
    }else{
        pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(110, 480 , 100, 20)];
    }
    pageControl.numberOfPages = 3;
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    //  pageControl.currentPageIndicatorTintColor = [APP_DELEGATE colorWithHexString:@"6c83b8"];
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    [self.view addSubview:pageControl];
    
    [self performSelector:@selector(logoImageAnimation) withObject:nil afterDelay:1.5];
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"refreshVideoScreenNotification" object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshView) name:@"refreshVideoScreenNotification" object:nil];

}

-(void)refreshView
{
    [moviePlayerController play];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
//    [moviePlayerController prepareToPlay];
//    [moviePlayerController play];
    
//    [colorTimer invalidate];
//    colorTimer =  [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(changeLogoImageColorContinuously) userInfo:nil repeats:YES];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    
//    [moviePlayerController stop];
    
}

-(void)setMoviePlayerView
{
    [moviePlayerController.view removeFromSuperview];
    moviePlayerController = nil;
    
    NSString *moviePath = [[NSBundle mainBundle] pathForResource:@"Onboarding_video" ofType:@"mp4"];
    
    NSURL *movieURL = [NSURL fileURLWithPath:moviePath];
    moviePlayerController = [[MPMoviePlayerController alloc] initWithContentURL:movieURL];
    [moviePlayerController.view setFrame:self.view.bounds];  // player's frame must match parent's
    [self.view addSubview:moviePlayerController.view];
    moviePlayerController.scalingMode = MPMovieScalingModeAspectFill;
    moviePlayerController.repeatMode = MPMovieRepeatModeOne;
    // Configure the movie player controller
    moviePlayerController.controlStyle = MPMovieControlStyleNone;
//    [moviePlayerController prepareToPlay];
    [moviePlayerController play];
    
    UIView * viewOverlay = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
    [viewOverlay setBackgroundColor:[UIColor darkGrayColor]];
    [viewOverlay setAlpha:0.3];
    [self.view addSubview:viewOverlay];
}

-(void)setPagedScroll
{
    [scrlContent removeFromSuperview];
    
    if (IS_IPAD) {
        scrlContent = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 768, 1024)];
        [scrlContent setContentSize:CGSizeMake(scrlContent.frame.size.width*3, 1024-20)];
    }else{
        if (IS_IPHONE_5) {
            scrlContent = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
            [scrlContent setContentSize:CGSizeMake(scrlContent.frame.size.width*3, 568-20)];
        }else{
            scrlContent = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
            [scrlContent setContentSize:CGSizeMake(scrlContent.frame.size.width*3, 480-20)];
        }
    }
    [scrlContent setBackgroundColor:[UIColor clearColor]];
    scrlContent.pagingEnabled = YES;
    scrlContent.bounces = NO;
    scrlContent.delegate = self;
    scrlContent.showsHorizontalScrollIndicator = NO;
    scrlContent.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrlContent];
    
    UIImageView * backImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, scrlContent.frame.size.width, scrlContent.frame.size.height)];
    [backImg setImage:[UIImage imageNamed:@"sp1_iPhone_5_bg.png"]];
    
    int xx = 0;
    UIView * contentView;
    for (int i = 0; i<3; i++)
    {
        contentView = [[UIView alloc] initWithFrame:CGRectMake(xx, 0, scrlContent.frame.size.width, scrlContent.frame.size.height)];
        [contentView setBackgroundColor:[UIColor clearColor]];
        [scrlContent addSubview:contentView];
        
        UIImageView * imgBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
        [contentView addSubview:imgBg];
        
        UIImageView * logoImg = [[UIImageView alloc] initWithFrame:CGRectMake(141, 35, 40, 40)];
        [logoImg setImage:[UIImage imageNamed:@"heartlogo.png"]];
        [logoImg setAlpha:0.9];
//        [contentView addSubview:logoImg];
        
        UIImageView * logoTextImg ;
        if (IS_IPHONE_5) {
            logoTextImg = [[UIImageView alloc] initWithFrame:CGRectMake(68, 280, 184, 62)];
        }else{
            logoTextImg = [[UIImageView alloc] initWithFrame:CGRectMake(68, 280-88, 184, 62)];
        }
        [logoTextImg setAlpha:0.75];
        [logoTextImg setImage:[UIImage imageNamed:@"heartlogo.png"]];
//        [contentView addSubview:logoTextImg];
        
        lblMessage = [[UILabel alloc] initWithFrame:CGRectMake(40, 320, 240, 120)];
        [lblMessage setBackgroundColor:[UIColor clearColor]];
        [lblMessage setTextColor:[UIColor whiteColor]];
        [lblMessage setFont:[UIFont fontWithName:CustomRegularFont size:14]];
        [lblMessage setNumberOfLines:6];
        [lblMessage setTag:i+1];
        [lblMessage setTextAlignment:NSTextAlignmentCenter];
        [lblMessage setAlpha:0.75];
//        [contentView addSubview:lblMessage];
        
        
        if (i==0)
        {
            if (IS_IPAD) {
                [imgBg setImage:[UIImage imageNamed:@"sp1_iPhone_4_bg.png"]];
            }else{
                if (IS_IPHONE_5) {
                    [imgBg setImage:[UIImage imageNamed:@"sp1_iPhone_5_bg.png"]];
                }else{
                    [imgBg setImage:[UIImage imageNamed:@"sp1_iPhone_4_bg.png"]];
                }
            }
            [lblMessage setText:@"Measure Your Heart Rate Whenever You Are"];
            
        }
        else if (i==1)
        {
            if (IS_IPAD) {
                [imgBg setImage:[UIImage imageNamed:@"sp2_iPhone_4_bg.png"]];
            }else{
                if (IS_IPHONE_5) {
                    [imgBg setImage:[UIImage imageNamed:@"sp2_iPhone_5_bg.png"]];
                }else{
                    [imgBg setImage:[UIImage imageNamed:@"sp2_iPhone_4_bg.png"]];
                }
            }
//            [lblMessage setText:@"Be yourself with goofy jokes and silly flirts."];
            [lblMessage setText:@"Persnalize Your Detail and get Perfect Results on Heart Rate"];
        }
        else if (i==2)
        {
            if (IS_IPAD) {
                [imgBg setImage:[UIImage imageNamed:@"sp3_iPhone_4_bg.png"]];
            }else{
                if (IS_IPHONE_5) {
                    [imgBg setImage:[UIImage imageNamed:@"sp3_iPhone_5_bg.png"]];
                }else{
                    [imgBg setImage:[UIImage imageNamed:@"sp3_iPhone_4_bg.png"]];
                }
            }
            
            [lblMessage setText:@"Get Helthier : Get Track of Daily Heart rate"];
        }
        
        lblMessage.numberOfLines = 0;
        NSString* string = lblMessage.text;
        NSMutableParagraphStyle *style  = [[NSMutableParagraphStyle alloc] init];
        //        style.minimumLineHeight = 17.f;
        //        style.maximumLineHeight = 20.f;
        style.lineSpacing = 4;
        NSDictionary *attributtes = @{NSParagraphStyleAttributeName : style};
        lblMessage.attributedText = [[NSAttributedString alloc] initWithString:string attributes:attributtes];
        lblMessage.textAlignment = NSTextAlignmentCenter;
        
        if (IS_IPAD) {
            [imgBg setFrame:CGRectMake(0, 0, 768, 1024)];
            [logoImg setFrame:CGRectMake(347, 120, 74, 130)];
            [lblMessage setFrame:CGRectMake(40, 340, 240, 120)];
        }else{
            if (IS_IPHONE_5) {
                [imgBg setFrame:CGRectMake(0, 0, 320, 568)];
                [logoImg setFrame:CGRectMake(140, 35, 40, 40)];
                [lblMessage setFrame:CGRectMake(50, 320, 220, 120)];
            }else{
                [imgBg setFrame:CGRectMake(0, 0, 320, 480)];
                [logoImg setFrame:CGRectMake(140, 35, 40, 40)];
                [lblMessage setFrame:CGRectMake(50, 320-88, 220, 120)];
            }
        }
        
        xx = xx+scrlContent.frame.size.width;
    }
    
    [pageControl removeFromSuperview];
    if (IS_IPHONE_5) {
        pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(110, 568-90 , 100, 20)];
    }else{
        pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(110, 480-90 , 100, 20)];
    }
    pageControl.numberOfPages = 3;
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    //  pageControl.currentPageIndicatorTintColor = [APP_DELEGATE colorWithHexString:@"6c83b8"];
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    [self.view addSubview:pageControl];
    
    [lblTempMessage setHidden:YES];
//    [imgLogo setHidden:YES];
//    [imgLogoName setHidden:YES];//viral
    
    [self setBottomView];
    
//    [colorTimer invalidate];
//    colorTimer =  [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(changeLogoImageColorContinuously) userInfo:nil repeats:YES];
    
//    [self.view bringSubviewToFront:digitsButton];
}

-(void)changeLogoImageColorContinuously
{
    NSInteger index = arc4random() % 8;
//    NSMutableArray * arrImageColors = [[NSMutableArray alloc] initWithObjects:yellow_color,orange_color,sky_blue_color, nil];
//    imgLogo.image = [self imageNamed:@"logo_1" withColor:[APP_DELEGATE colorWithHexString:[arrImageColors objectAtIndex:index]]];
    
    NSMutableArray * arrImageColors = [[NSMutableArray alloc] initWithObjects:[UIColor darkGrayColor],[UIColor whiteColor],[UIColor greenColor],[UIColor redColor],[UIColor cyanColor],[UIColor orangeColor],[UIColor magentaColor],[UIColor yellowColor],[UIColor whiteColor], nil];
//    imgLogo.image = [self imageNamed:@"logo_1" withColor:[arrImageColors objectAtIndex:index]];
    
    [UIView transitionWithView:imgLogo duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        imgLogo.image = [self imageNamed:@"logo_yellow" withColor:[arrImageColors objectAtIndex:index]];
    } completion:^(BOOL finished) {
    }];
}

-(UIImage *)imageNamed:(NSString *)name withColor:(UIColor *)color {
    // load the image
    
    UIImage *img = [UIImage imageNamed:name];
    
    // begin a new image context, to draw our colored image onto
    UIGraphicsBeginImageContext(img.size);
    
    // get a reference to that context we created
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // set the fill color
    [color setFill];
    
    // translate/flip the graphics context (for transforming from CG* coords to UI* coords
    CGContextTranslateCTM(context, 0, img.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    // set the blend mode to color burn, and the original image
    CGContextSetBlendMode(context, kCGBlendModeColorBurn);
    CGRect rect = CGRectMake(0, 0, img.size.width, img.size.height);
    CGContextDrawImage(context, rect, img.CGImage);
    
    // set a mask that matches the shape of the image, then draw (color burn) a colored rectangle
    CGContextClipToMask(context, rect, img.CGImage);
    CGContextAddRect(context, rect);
    CGContextDrawPath(context,kCGPathFill);
    
    // generate a new UIImage from the graphics context we drew onto
    UIImage *coloredImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //return the color-burned image
    return coloredImg;
}

#pragma mark - logoImageAnimation
-(void)logoImageAnimation
{
    imgLogo.hidden=NO;
    
    [UIView transitionWithView:imgLogo duration:0.4
                       options:UIViewAnimationOptionCurveEaseOut
                    animations:^{
                        if (IS_IPHONE_5) {
                            [imgLogo setFrame:CGRectMake(140, 35, 40, 40)];
                        }else{
                            [imgLogo setFrame:CGRectMake(140, 35, 40, 40)];
                        }
                    }
                    completion:^(BOOL finished)
     {
         [self performSelector:@selector(LogoNameImageAnimation) withObject:nil afterDelay:0.2];
     }];
}

#pragma mark - LogoNameImageAnimation
-(void)LogoNameImageAnimation
{
    imgLogoName.hidden=NO;
    [UIView transitionWithView:imgLogoName duration:0.6
                       options:UIViewAnimationOptionCurveEaseOut
                    animations:^{
                        if (IS_IPHONE_5) {
                            [imgLogoName setFrame:CGRectMake(68, 280, 184, 62)];
                        }else{
                            [imgLogoName setFrame:CGRectMake(68, 280-88, 184, 62)];
                        }
                    }
                    completion:^(BOOL finished)
     {
         lblTempMessage.hidden=NO;
         [UIView transitionWithView:lblTempMessage duration:0.6
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             if (IS_IPHONE_5) {
                                 [lblTempMessage setFrame:CGRectMake(50, 320, 220, 120)];
                             }else{
                                 [lblTempMessage setFrame:CGRectMake(50, 320-88, 220, 120)];
                             }
                         }
                         completion:^(BOOL finished)
          {
              [UIView transitionWithView:pageControl duration:0.6
                                 options:UIViewAnimationOptionCurveEaseOut
                              animations:^{
                                  if (IS_IPHONE_5) {
                                      [pageControl setFrame:CGRectMake(110, 568 -90 , 100, 20)];
                                  }else{
                                      [pageControl setFrame:CGRectMake(110, 480 -90, 100, 20)];
                                  }
                              }
                              completion:^(BOOL finished)
               {
                   [self performSelector:@selector(setPagedScroll) withObject:nil afterDelay:0.0];
               }];
          }];
     }];
}

#pragma mark - bottomViewAnimation
-(void)bottomViewAnimation
{
    [UIView transitionWithView:viewBottom duration:0.5
                       options:UIViewAnimationOptionCurveEaseOut
                    animations:^{
                        [viewBottom setAlpha:1.0];
                    }
                    completion:^(BOOL finished)
     {
     }];
}

-(void)setBottomView
{
    [viewBottom removeFromSuperview];
    viewBottom = [[UIView alloc] init];
    
    if (IS_IPHONE_5) {
        [viewBottom setFrame:CGRectMake(0, 568-94, 320, 94)];
    }else{
        [viewBottom setFrame:CGRectMake(0, 480-94, 320, 94)];
    }
    [viewBottom setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:viewBottom];
    
    UIButton * btnGetStarted = [UIButton buttonWithType:UIButtonTypeCustom];
    if (IS_IPHONE_5) {
        [btnGetStarted setFrame:CGRectMake(0, 35, 320, 44)];
    }else{
        [btnGetStarted setFrame:CGRectMake(0, 35, 320, 44)];
    }
    [btnGetStarted setImage:[UIImage imageNamed:@"get-started.png"] forState:UIControlStateNormal];
//    [btnGetStarted setBackgroundColor:[APP_DELEGATE colorWithHexString:light_green_color]];
//    [btnGetStarted setTitle:@"GET STARTED" forState:UIControlStateNormal];
//    btnGetStarted.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [btnGetStarted addTarget:self action:@selector(didTapButton) forControlEvents:UIControlEventTouchUpInside];
    [viewBottom addSubview:btnGetStarted];
    
    [[Twitter sharedInstance] logOut];
    [[Twitter sharedInstance] logOutGuest];
    [[Digits sharedInstance] logOut];
    
 
    
    [self performSelector:@selector(bottomViewAnimation) withObject:nil afterDelay:0.2];
}

// Objective-C
- (void)didTapButton
{
    userDict = [[NSMutableDictionary alloc] init];
    [userDict setObject:@"3018168937" forKey:@"sessionUserId"];
    [userDict setObject:@"+918866586171" forKey:@"phone"];
    [self checkUserTwitterSessionDict:userDict];
    RegisterVC1 * register_view = [[RegisterVC1 alloc] initWithNibName:@"RegisterVC1" bundle:nil];
    register_view.userDetailDict = userDict;
    [self.navigationController pushViewController:register_view animated:YES];
    
  /*  [[Twitter sharedInstance] logOut];
    [[Twitter sharedInstance] logOutGuest];
    [[Digits sharedInstance] logOut];
    
    // Create an already initialized DGTAppearance object with standard colors:
    DGTAppearance *digitsAppearance = [[DGTAppearance alloc] init];
    
    digitsAppearance.backgroundColor = [UIColor whiteColor];
    digitsAppearance.accentColor = [APP_DELEGATE colorWithHexString:light_green_color];
    
    // Start the authentication flow with the custom appearance. Nil parameters for default values.
    Digits *digits = [Digits sharedInstance];
    [digits authenticateWithDigitsAppearance:digitsAppearance viewController:nil title:@"Log In" completion:^(DGTSession *session, NSError *error)
    {
        // Inspect session/error objects
        NSLog(@"error====%@, session =====%@",error,session);
        NSLog(@"session.authToken===%@ ,session.authTokenSecret====%@ ,session.phoneNumber====%@, session.userID===%@",session.authToken,session.authTokenSecret,session.phoneNumber,session.userID);
        userDict = [[NSMutableDictionary alloc] init];
        if (session.userID != NULL && ![session.userID isEqualToString:@""])
        {
            [userDict setObject:session.userID forKey:@"sessionUserId"];
            [userDict setObject:session.authTokenSecret forKey:@"sessionSecret"];
            [userDict setObject:session.authToken forKey:@"sessionToken"];
            [userDict setObject:session.phoneNumber forKey:@"phone"];
            
            [self checkUserTwitterSessionDict:userDict];
        }
    }];*/
}

#pragma mark scrollview delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat lastContentOffset;
    ScrollDirection scrollDirection;
    if (lastContentOffset > scrollView.contentOffset.x)
        scrollDirection = ScrollDirectionRight;
    else if (lastContentOffset < scrollView.contentOffset.x)
        scrollDirection = ScrollDirectionLeft;
    
    lastContentOffset = scrollView.contentOffset.x;
    
    if (lastContentOffset>0)
    {
        CGFloat pageWidth = scrollView.frame.size.width;
        int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        //  NSLog(@"page==%d",page);
        pageControl.currentPage = page;
    }
}

#pragma mark Button Click
-(void)btnGetStartedClicekd:(id)sender
{
    userDict = [[NSMutableDictionary alloc] init];

    RegisterVC1 * register_view = [[RegisterVC1 alloc] initWithNibName:@"RegisterVC1" bundle:nil];
    register_view.userDetailDict = userDict;
    [self.navigationController pushViewController:register_view animated:YES];
}

#pragma mark Home view delegate
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
    return [[UINavigationController alloc] initWithRootViewController:[self demoController]];
}


#pragma mark - Web Service
-(void)checkUserTwitterSessionDict:(NSMutableDictionary*)userSessionDict
{
//    {"device_type":"0","device_token":"aa123","phone":"+919898689570","lat":"111","lon":"1234"}
    NSString * webServiceName = @"checkPhone";
    NSMutableDictionary *mainDict = [[NSMutableDictionary alloc]init];
    [mainDict setObject:[userSessionDict valueForKey:@"sessionUserId"] forKey:@"twitter_id"];
    [mainDict setObject:[userSessionDict valueForKey:@"phone"] forKey:@"phone"];
    if (deviceTokenStr) {
        [mainDict setObject:deviceTokenStr forKey:@"device_token"];
    }
    [mainDict setObject:@"0" forKey:@"device_type"];
    [mainDict setObject:appLatitude forKey:@"lat"];
    [mainDict setObject:appLongitude forKey:@"lon"];
    [mainDict setObject:[APP_DELEGATE getUTCFormateDate:[NSDate date]] forKey:@"created_date"];
    
    URLManager *manager = [[URLManager alloc] init];
    manager.delegate = self;
    manager.commandName = @"checkPhone";
    NSLog(@"LoginDict : %@",mainDict);
    [manager urlCall:[NSString stringWithFormat:@"%@%@",WEB_SERVICE_URL,webServiceName]  withParameters:mainDict];
    [HUD show:YES];
}

#pragma mark Response
- (void)onResult:(NSDictionary *)result
{
    [HUD hide:YES];
    
    NSLog(@"Result :%@",result);
    if([[result valueForKey:@"commandName"] isEqualToString:@"checkPhone"])
    {
        if([[[[result valueForKey:@"result"] valueForKey:@"data"]valueForKey:@"response"] isEqualToString:@"true"])
        {
            [self setUserDefaultWhenLogIn:[[[result valueForKey:@"result"] valueForKey:@"data"] valueForKey:@"response_data"]];
            
//            HomeVC * home = [[HomeVC alloc] initWithNibName:@"HomeVC" bundle:nil];
//            [self.navigationController pushViewController:home animated:YES];
            
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:1.3];
            [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:[[UIApplication sharedApplication] keyWindow] cache:YES];
            [UIView commitAnimations];
            
            _sideMenuViewController = [[SideMenuVC alloc] init];
            container = [MFSideMenuContainerViewController containerWithCenterViewController:[self navigationController] leftMenuViewController:_sideMenuViewController rightMenuViewController:nil];
            addDelegate.window.rootViewController = container;
        }
        else
        {
//            RegisterVC1 * register_view = [[RegisterVC1 alloc] initWithNibName:@"RegisterVC1" bundle:nil];
//            register_view.userDetailDict = userDict;
//            UINavigationController * navControl = [[UINavigationController alloc] initWithRootViewController:register_view];
//            [self.navigationController pushViewController:navControl animated:YES];
            
            RegisterVC1 *  register_view = [[RegisterVC1 alloc] init];
            UINavigationController * navControl = [[UINavigationController alloc] initWithRootViewController:register_view];
            register_view.userDetailDict = userDict;
            navControl.navigationBarHidden=YES;
            addDelegate.window.rootViewController = navControl;
        }
    }
}

- (void)onError:(NSError *)error
{
    [HUD hide:YES];
    NSLog(@"The error is...%@", error);
    
    NSInteger ancode = [error code];
    [APP_DELEGATE ShowNoNetworkConnectionPopUpWithErrorCode:ancode];
}

-(void)setUserDefaultWhenLogIn:(NSDictionary*)result
{
    NSLog(@"LoginUser dict ====%@",result);
    NSUserDefaults *LoginUser=[NSUserDefaults standardUserDefaults];
    
    [LoginUser setValue:[result valueForKey:@"user_id"] forKey:@"userId"];
    
    if ([result valueForKey:@"twitter_id"]!=[NSNull null] && ![[result valueForKey:@"twitter_id"] isEqualToString:@""])
    {
        [LoginUser setValue:[result valueForKey:@"twitter_id"] forKey:@"CURRENT_User_Twitter_Session_Id"];
    }else{
        [LoginUser setValue:@"" forKey:@"CURRENT_User_Twitter_Session_Id"];
    }
    
    if ([result valueForKey:@"first_name"]!=[NSNull null] && ![[result valueForKey:@"first_name"] isEqualToString:@""])
    {
        [LoginUser setValue:[result valueForKey:@"first_name"] forKey:@"User_Firstname"];
    }else{
        [LoginUser setValue:@"" forKey:@"User_Firstname"];
    }
    
    if ([result valueForKey:@"last_name"]!=[NSNull null] && ![[result valueForKey:@"last_name"] isEqualToString:@""])
    {
        [LoginUser setValue:[result valueForKey:@"last_name"] forKey:@"User_Lastname"];
    }else{
        [LoginUser setValue:@"" forKey:@"User_Lastname"];
    }
    
    if ([result valueForKey:@"phone"]!=[NSNull null] && ![[result valueForKey:@"phone"] isEqualToString:@""])
    {
        [LoginUser setValue:[result valueForKey:@"phone"] forKey:@"User_Phone"];
    }else{
        [LoginUser setValue:@"" forKey:@"User_Phone"];
    }
    
    
    if ([result valueForKey:@"weight"]!=[NSNull null] && ![[result valueForKey:@"weight"] isEqualToString:@""])
    {
        [LoginUser setValue:[result valueForKey:@"weight"] forKey:@"User_Weight"];
    }else{
        [LoginUser setValue:@"" forKey:@"User_Weight"];
    }
    
    if ([result valueForKey:@"height"]!=[NSNull null] && ![[result valueForKey:@"height"] isEqualToString:@""])
    {
        [LoginUser setValue:[result valueForKey:@"height"] forKey:@"User_Height"];
    }else{
        [LoginUser setValue:@"" forKey:@"User_Height"];
    }
    
    if ([result valueForKey:@"birthdate"]!=[NSNull null] && ![[result valueForKey:@"birthdate"] isEqualToString:@""])
    {
        [LoginUser setValue:[result valueForKey:@"birthdate"] forKey:@"User_Birthdate"];
    }else{
        [LoginUser setValue:@"" forKey:@"User_Birthdate"];
    }
    
    if ([result valueForKey:@"gender"]!=[NSNull null] && ![[result valueForKey:@"gender"] isEqualToString:@""])
    {
        [LoginUser setValue:[result valueForKey:@"gender"] forKey:@"User_Gender"];
    }else{
        [LoginUser setValue:@"" forKey:@"User_Gender"];
    }
    
    if ([result valueForKey:@"photo"]!=[NSNull null] && ![[result valueForKey:@"photo"] isEqualToString:@""])
    {
        [LoginUser setValue:[result valueForKey:@"photo"] forKey:@"User_Image"];
    }else{
        [LoginUser setValue:@"" forKey:@"User_Image"];
    }
    
    NSLog(@"CURRENT_USER_ID==========%@",CURRENT_USER_ID);
    NSLog(@"CURRENT_USER_TWITTER_ID==========%@",CURRENT_USER_TWITTER_ID);
    NSLog(@"CURRENT_USER_FIRSTNAME==========%@",CURRENT_USER_FIRSTNAME);
    NSLog(@"CURRENT_USER_LASTNAME==========%@",CURRENT_USER_LASTNAME);
    NSLog(@"CURRENT_USER_Phone==========%@",CURRENT_USER_Phone);
    NSLog(@"CURRENT_USER_PROFILE_IMAGE==========%@",CURRENT_USER_PROFILE_IMAGE);
    NSLog(@"CURRENT_USER_HEIGHT==========%@",CURRENT_USER_HEIGHT);
    NSLog(@"CURRENT_USER_WEIGHT==========%@",CURRENT_USER_WEIGHT);
    NSLog(@"CURRENT_USER_BIRTHDATE==========%@",CURRENT_USER_BIRTHDATE);
    NSLog(@"CURRENT_USER_GENDER==========%@",CURRENT_USER_GENDER);
    
    [LoginUser synchronize];
}

#pragma mark CleanUp
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
