//
//  SplashVC.m
//  LOV
//
//  Created by Oneclick IT Solution on 1/13/15.
//  Copyright (c) 2015 One Click IT Consultancy Pvt Ltd. All rights reserved.
//

#import "SplashVC.h"

@interface SplashVC ()

@end

@implementation SplashVC

#pragma mark - Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"Hello");
    
//    [self.navigationController.navigationBar setHidden:YES];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    addDelegate =(AppDelegate *) [[UIApplication sharedApplication] delegate];
    NSLog(@"bounds height====%f",[[UIScreen mainScreen] bounds].size.height);
    NSLog(@"self height====%f",self.view.frame.size.height);
    
    if (IS_IPHONE_5) {
        imgLogo = [[UIImageView alloc] initWithFrame:CGRectMake(140, 568, 40, 40)];
    }else{
        imgLogo = [[UIImageView alloc] initWithFrame:CGRectMake(140, 480, 40, 40)];
    }
    [imgLogo setAlpha:0.9];
    [imgLogo setImage:[UIImage imageNamed:@"heart.png"]];
    [self.view addSubview:imgLogo];
    imgLogo.hidden=YES ;
    
   /* if (IS_IPHONE_5) {
        imgLogo = [[UIImageView alloc] initWithFrame:CGRectMake(125, 568/2-70/2, 70, 70)];
    }else{
        imgLogo = [[UIImageView alloc] initWithFrame:CGRectMake(125, 480/2-70/2, 70, 70)];
    }
    [imgLogo setImage:[UIImage imageNamed:@"logo_1.png"]];
    [self.view addSubview:imgLogo];
    imgLogo.hidden=YES ;
    
    
    if (IS_IPHONE_5) {
        imgLogoName = [[UIImageView alloc] initWithFrame:CGRectMake(115, 568+20, 90, 30)];
    }else{
        imgLogoName = [[UIImageView alloc] initWithFrame:CGRectMake(115, 480+20, 90, 30)];
    }
    [imgLogoName setImage:[UIImage imageNamed:@"textlov.png"]];
    [self.view addSubview:imgLogoName];
    
    [self LogoNameImageAnimation];*/
    
    [self logoImageAnimation];
    
//   colorTimer =  [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(changeLogoImageColorContinuously) userInfo:nil repeats:YES];
    //    [self.view bringSubviewToFront:digitsButton];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.navigationController.navigationBar setHidden:YES];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    
    [colorTimer invalidate];
}

-(void)changeLogoImageColorContinuously
{
    NSInteger index = arc4random() % 8;
    //    NSMutableArray * arrImageColors = [[NSMutableArray alloc] initWithObjects:yellow_color,orange_color,sky_blue_color, nil];
    //    imgLogo.image = [self imageNamed:@"logo_1" withColor:[APP_DELEGATE colorWithHexString:[arrImageColors objectAtIndex:index]]];
    
    NSMutableArray * arrImageColors = [[NSMutableArray alloc] initWithObjects:[UIColor darkGrayColor],[UIColor whiteColor],[UIColor greenColor],[UIColor redColor],[UIColor cyanColor],[UIColor orangeColor],[UIColor magentaColor],[UIColor yellowColor], nil];
    //    imgLogo.image = [self imageNamed:@"logo_1" withColor:[arrImageColors objectAtIndex:index]];
    
    [UIView transitionWithView:imgLogo duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        imgLogo.image = [self imageNamed:@"heart.png" withColor:[arrImageColors objectAtIndex:index]];
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
    
    [UIView transitionWithView:imgLogo duration:0.6
                       options:UIViewAnimationOptionCurveEaseOut
                    animations:^{
                        if (IS_IPHONE_5) {
                            [imgLogo setFrame:CGRectMake(140, 568/2-70/2, 40, 40)];
                        }else{
                            [imgLogo setFrame:CGRectMake(140, 480/2-70/2, 40, 40)];
                        }
                    }
                    completion:^(BOOL finished)
     {
         [self performSelector:@selector(gotoNextView) withObject:nil afterDelay:1];
     }];
}


#pragma mark Home view delegate
- (HomeVC *)demoController
{
    return [[HomeVC alloc] initWithNibName:@"HomeVC" bundle:nil];
}

//-(StartUpScreenNew *)loginController
//{
//    return [[StartUpScreenNew alloc] initWithNibName:@"StartUpScreenNew" bundle:nil];
//}

- (UINavigationController *)navigationController
{
    return [[UINavigationController alloc] initWithRootViewController:[self demoController]];
}

#pragma mark - gotoNextView
-(void)gotoNextView
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1.3];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:[[UIApplication sharedApplication] keyWindow] cache:YES];
    [UIView commitAnimations];
    
    if ([CURRENT_USER_ID isEqualToString:@""] || [CURRENT_USER_ID isEqual:[NSNull null]] || CURRENT_USER_ID == nil || [CURRENT_USER_ID isEqualToString:@"(null)"])
    {
        StartUpScreenNew *  startup = [[StartUpScreenNew alloc] init];
//        [self.navigationController pushViewController:startup animated:YES];
        UINavigationController * navControl = [[UINavigationController alloc] initWithRootViewController:startup];
        navControl.navigationBarHidden=YES;
        addDelegate.window.rootViewController = navControl; // login
    }
    else
    {
        _sideMenuViewController = [[SideMenuVC alloc] init];
        container = [MFSideMenuContainerViewController containerWithCenterViewController:[self navigationController]
                                                                  leftMenuViewController:_sideMenuViewController rightMenuViewController:nil];
        addDelegate.window.rootViewController = container;
    }
}

#pragma mark CleanUp
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
