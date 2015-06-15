//
//  HomeVC.m
//  Heart Rate Monitor
//
//  Created by Oneclick IT Solution on 6/8/15.
//  Copyright (c) 2015 One Click IT Consultancy . All rights reserved.
//

#import "HomeVC.h"

@interface HomeVC ()

@end

@implementation HomeVC

@synthesize heartRate;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setHidden:YES];
    
    [self.view setBackgroundColor:[APP_DELEGATE colorWithHexString:light_gray_bg_color]];
    
    [self setHeaderViewFrame];
    
    [self setContentFrames];
    
    [self registerNotifications];
    
//    [BLEManager sharedManager];
}

-(void)setHeaderViewFrame
{
    UIView * viewHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 64)];
    [viewHeader setBackgroundColor:[APP_DELEGATE colorWithHexString:light_green_color]];
    [self.view addSubview:viewHeader];
    
    UILabel * lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(60, 20, 200, 44)];
    [lblTitle setText:@"Heart Rate Monitor"];
    [lblTitle setTextAlignment:NSTextAlignmentCenter];
    [lblTitle setTextColor:[UIColor blackColor]];
    [lblTitle setBackgroundColor:[UIColor clearColor]];
    [lblTitle setFont:[UIFont boldSystemFontOfSize:18]];
    [viewHeader addSubview:lblTitle];
    
    UIButton * btnMenu = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnMenu setFrame:CGRectMake(5, 20, 44, 44)];
    [btnMenu setBackgroundColor:[UIColor clearColor]];
    [btnMenu setImage:[UIImage imageNamed:@"list.png"] forState:UIControlStateNormal];
    [btnMenu addTarget:self action:@selector(leftSideMenuButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [viewHeader addSubview:btnMenu];
    
    UIButton * btnMap = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnMap setFrame:CGRectMake(275, 20, 44, 44)];
    [btnMap setBackgroundColor:[UIColor clearColor]];
    [btnMap setImage:[UIImage imageNamed:@"nearest.png"] forState:UIControlStateNormal];
    [btnMap addTarget:self action:@selector(btnMapClicked:) forControlEvents:UIControlEventTouchUpInside];
    [viewHeader addSubview:btnMap];
}

-(void)setContentFrames
{
    lblDate = [[UILabel alloc] initWithFrame:CGRectMake(60, 80, 200, 20)];
    [lblDate setText:[self getOnlyDate]];
    [lblDate setTextAlignment:NSTextAlignmentCenter];
    [lblDate setTextColor:[UIColor blackColor]];
    [lblDate setBackgroundColor:[UIColor clearColor]];
    [lblDate setFont:[UIFont systemFontOfSize:15]];
    [self.view addSubview:lblDate];
    
    lblTime = [[UILabel alloc] initWithFrame:CGRectMake(60, 110, 200, 44)];
    [lblTime setText:[self getTimeInMinSec]];
    [lblTime setTextAlignment:NSTextAlignmentCenter];
    [lblTime setTextColor:[UIColor grayColor]];
    [lblTime setBackgroundColor:[UIColor clearColor]];
    [lblTime setFont:[UIFont systemFontOfSize:15]];
    [self.view addSubview:lblTime];
    
    imgHeart = [[UIImageView alloc] initWithFrame:CGRectMake(135, 145, 50, 50)];
    [imgHeart setBackgroundColor:[UIColor clearColor]];
    imgHeart.contentMode = UIViewContentModeScaleAspectFit;
    [imgHeart setImage:[UIImage imageNamed:@"heart.png"]];
    [self.view addSubview:imgHeart];
    
    UIView * viewCircle = [[UIView alloc] initWithFrame:CGRectMake(100, 210, 120, 120)];
    [viewCircle setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:viewCircle];
    
    UIImageView * imgCircle = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 120, 120)];
    [imgCircle setBackgroundColor:[UIColor clearColor]];
    [imgCircle setImage:[UIImage imageNamed:@"circle.png"]];
    [viewCircle addSubview:imgCircle];
    
    lblHeartBeat = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, 100, 50)];
    [lblHeartBeat setText:@"0"];
    [lblHeartBeat setTextAlignment:NSTextAlignmentCenter];
    [lblHeartBeat setTextColor:[APP_DELEGATE colorWithHexString:pink_color]];
    [lblHeartBeat setBackgroundColor:[UIColor clearColor]];
    [lblHeartBeat setFont:[UIFont boldSystemFontOfSize:40]];
    [viewCircle addSubview:lblHeartBeat];
    
    UILabel * lblStaticBPM = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, 80, 20)];
    [lblStaticBPM setText:@"BPM"];
    [lblStaticBPM setTextAlignment:NSTextAlignmentCenter];
    [lblStaticBPM setTextColor:[UIColor grayColor]];
    [lblStaticBPM setBackgroundColor:[UIColor clearColor]];
    [lblStaticBPM setFont:[UIFont fontWithName:CustomRegularFont size:15]];
    [viewCircle addSubview:lblStaticBPM];
    
    
    /*------------------------------*/
    UIView * viewAverageCircle = [[UIView alloc] initWithFrame:CGRectMake(10, 200, 80, 80)];
    [viewAverageCircle setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:viewAverageCircle];
    
    UIImageView * imgAverageCircle = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    [imgAverageCircle setBackgroundColor:[UIColor clearColor]];
    [imgAverageCircle setImage:[UIImage imageNamed:@"avg_circle.png"]];
    [viewAverageCircle addSubview:imgAverageCircle];
    
    lblAverage = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, 60, 20)];
    [lblAverage setText:@"80"];
    [lblAverage setTextAlignment:NSTextAlignmentCenter];
    [lblAverage setTextColor:[APP_DELEGATE colorWithHexString:light_green_color]];
    [lblAverage setBackgroundColor:[UIColor clearColor]];
    [lblAverage setFont:[UIFont boldSystemFontOfSize:25]];
    [viewAverageCircle addSubview:lblAverage];
    
    UILabel * lblStaticAverage = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 60, 20)];
    [lblStaticAverage setText:@"Avg"];
    [lblStaticAverage setTextAlignment:NSTextAlignmentCenter];
    [lblStaticAverage setTextColor:[UIColor grayColor]];
    [lblStaticAverage setBackgroundColor:[UIColor clearColor]];
    [lblStaticAverage setFont:[UIFont fontWithName:CustomThinFont size:15]];
    [viewAverageCircle addSubview:lblStaticAverage];
    /*------------------------------*/
    
    /*------------------------------*/
    UIView * viewHighCircle = [[UIView alloc] initWithFrame:CGRectMake(220, 160, 90, 90)];
    [viewHighCircle setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:viewHighCircle];
    
    UIImageView * imgHighCircle = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 90, 90)];
    [imgHighCircle setBackgroundColor:[UIColor clearColor]];
    [imgHighCircle setImage:[UIImage imageNamed:@"avg_circle.png"]];
    [viewHighCircle addSubview:imgHighCircle];
    
    lblHigh = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, 70, 20)];
    [lblHigh setText:@"110"];
    [lblHigh setTextAlignment:NSTextAlignmentCenter];
    [lblHigh setTextColor:[APP_DELEGATE colorWithHexString:pink_color]];
    [lblHigh setBackgroundColor:[UIColor clearColor]];
    [lblHigh setFont:[UIFont boldSystemFontOfSize:22]];
    [viewHighCircle addSubview:lblHigh];
    
    UILabel * lblStaticHigh = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 70, 20)];
    [lblStaticHigh setText:@"High"];
    [lblStaticHigh setTextAlignment:NSTextAlignmentCenter];
    [lblStaticHigh setTextColor:[UIColor grayColor]];
    [lblStaticHigh setBackgroundColor:[UIColor clearColor]];
    [lblStaticHigh setFont:[UIFont fontWithName:CustomThinFont size:14]];
    [viewHighCircle addSubview:lblStaticHigh];
    /*------------------------------*/
    
    
    /*------------------------------*/
    UIView * viewLowCircle = [[UIView alloc] initWithFrame:CGRectMake(235, 280, 60, 60)];
    [viewLowCircle setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:viewLowCircle];
    
    UIImageView * imgLowCircle = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    [imgLowCircle setBackgroundColor:[UIColor clearColor]];
    [imgLowCircle setImage:[UIImage imageNamed:@"avg_circle.png"]];
    [viewLowCircle addSubview:imgLowCircle];
    
    lblLow = [[UILabel alloc] initWithFrame:CGRectMake(5, 15, 50, 20)];
    [lblLow setText:@"65"];
    [lblLow setTextAlignment:NSTextAlignmentCenter];
    [lblLow setTextColor:[APP_DELEGATE colorWithHexString:light_green_color]];
    [lblLow setBackgroundColor:[UIColor clearColor]];
    [lblLow setFont:[UIFont boldSystemFontOfSize:20]];
    [viewLowCircle addSubview:lblLow];
    
    UILabel * lblStaticLow = [[UILabel alloc] initWithFrame:CGRectMake(5, 35, 50, 20)];
    [lblStaticLow setText:@"Low"];
    [lblStaticLow setTextAlignment:NSTextAlignmentCenter];
    [lblStaticLow setTextColor:[UIColor grayColor]];
    [lblStaticLow setBackgroundColor:[UIColor clearColor]];
    [lblStaticLow setFont:[UIFont fontWithName:CustomThinFont size:14]];
    [viewLowCircle addSubview:lblStaticLow];
    /*------------------------------*/
    
    
    /*------------------------------*/
    UIImageView * imgStaticGraph = [[UIImageView alloc] initWithFrame:CGRectMake(5, 380, 310, 90)];
    [imgStaticGraph setBackgroundColor:[UIColor clearColor]];
    [imgStaticGraph setImage:[UIImage imageNamed:@"static-graph.png"]];
    [self.view addSubview:imgStaticGraph];
    /*------------------------------*/
    
    
    /*------------------------------*/
    UIView * viewLastMeasurement = [[UIView alloc] initWithFrame:CGRectMake(0, 568-80, 320, 80)];
    [viewLastMeasurement setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:viewLastMeasurement];
    
    UILabel * lblLastMeasurment = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 180, 20)];
    [lblLastMeasurment setText:@"Last Measurement"];
    [lblLastMeasurment setTextAlignment:NSTextAlignmentLeft];
    [lblLastMeasurment setTextColor:[UIColor darkGrayColor]];
    [lblLastMeasurment setBackgroundColor:[UIColor clearColor]];
    [lblLastMeasurment setFont:[UIFont fontWithName:CustomThinFont size:15]];
    [viewLastMeasurement addSubview:lblLastMeasurment];
    
    UIImageView * imgBox = [[UIImageView alloc] initWithFrame:CGRectMake(10, 25, 300, 42)];
    [imgBox setBackgroundColor:[UIColor clearColor]];
    [imgBox setImage:[UIImage imageNamed:@"whitebox.png"]];
    [viewLastMeasurement addSubview:imgBox];
    
    UIImageView * imgPulseIcon = [[UIImageView alloc] initWithFrame:CGRectMake(20, 35, 22, 22)];
    [imgPulseIcon setBackgroundColor:[UIColor clearColor]];
    [imgPulseIcon setImage:[UIImage imageNamed:@"pluse_icon.png"]];
    [viewLastMeasurement addSubview:imgPulseIcon];
    
    lblHeartRateType = [[UILabel alloc] initWithFrame:CGRectMake(50, 25, 180, 20)];
    [lblHeartRateType setText:@"Normal"];
    [lblHeartRateType setTextAlignment:NSTextAlignmentLeft];
    [lblHeartRateType setTextColor:[UIColor darkGrayColor]];
    [lblHeartRateType setBackgroundColor:[UIColor clearColor]];
    [lblHeartRateType setFont:[UIFont fontWithName:CustomThinFont size:15]];
    [viewLastMeasurement addSubview:lblHeartRateType];
    
    lblLastMeasureDateTime = [[UILabel alloc] initWithFrame:CGRectMake(50, 45, 180, 20)];
    [lblLastMeasureDateTime setText:[self getLastMeasuredDateTime]];
    [lblLastMeasureDateTime setTextAlignment:NSTextAlignmentLeft];
    [lblLastMeasureDateTime setTextColor:[APP_DELEGATE colorWithHexString:light_green_color]];
    [lblLastMeasureDateTime setBackgroundColor:[UIColor clearColor]];
    [lblLastMeasureDateTime setFont:[UIFont fontWithName:CustomThinFont size:15]];
    [viewLastMeasurement addSubview:lblLastMeasureDateTime];
    
    lblLastMeasuredHeartRate = [[UILabel alloc] initWithFrame:CGRectMake(190, 35, 80, 20)];
    [lblLastMeasuredHeartRate setText:@"0"];
    [lblLastMeasuredHeartRate setTextAlignment:NSTextAlignmentRight];
    [lblLastMeasuredHeartRate setTextColor:[UIColor grayColor]];
    [lblLastMeasuredHeartRate setBackgroundColor:[UIColor clearColor]];
    [lblLastMeasuredHeartRate setFont:[UIFont fontWithName:CustomThinFont size:25]];
    [viewLastMeasurement addSubview:lblLastMeasuredHeartRate];
    
    
    UIImageView * imgSmallHeart = [[UIImageView alloc] initWithFrame:CGRectMake(280, 30, 20, 20)];
    [imgSmallHeart setBackgroundColor:[UIColor clearColor]];
    imgSmallHeart.contentMode = UIViewContentModeScaleAspectFit;
    [imgSmallHeart setImage:[UIImage imageNamed:@"heart.png"]];
    [viewLastMeasurement addSubview:imgSmallHeart];
    
    UILabel * lblStaticBPM2 = [[UILabel alloc] initWithFrame:CGRectMake(270, 50, 40, 15)];
    [lblStaticBPM2 setText:@"BPM"];
    [lblStaticBPM2 setTextAlignment:NSTextAlignmentCenter];
    [lblStaticBPM2 setTextColor:[UIColor grayColor]];
    [lblStaticBPM2 setBackgroundColor:[UIColor clearColor]];
    [lblStaticBPM2 setFont:[UIFont fontWithName:CustomRegularFont size:12]];
    [viewLastMeasurement addSubview:lblStaticBPM2];

    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(getTimeInMinSec) userInfo:nil repeats:YES];
}

-(NSString *)getTimeInMinSec
{
    NSDate * date = [NSDate date];
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"HH:mm:ss"];
    NSString * strTime = [df stringFromDate:date];
    
    lblTime.text = [NSString stringWithFormat:@"%@",strTime];
    return strTime;
}

-(NSString*)getOnlyDate
{
    NSDate * date = [NSDate date];
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSString * strTime = [df stringFromDate:date];
    
    lblDate.text = [NSString stringWithFormat:@"%@",strTime];
    return strTime;
}

-(NSString*)getLastMeasuredDateTime
{
    NSDate * date = [NSDate date];
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString * strTime = [df stringFromDate:date];
    NSLog(@"strTime===%@",strTime);
    
    lblLastMeasureDateTime.text = [NSString stringWithFormat:@"%@",strTime];
    return strTime;
}

#pragma mark - Button Click
-(void)leftSideMenuButtonPressed:(id)sender
{
    [self.menuContainerViewController setMenuSlideAnimationFactor:0.5f];
    [self.menuContainerViewController toggleLeftSideMenuCompletion:^{
       // [self setupMenuBarButtonItems];
    }];
}

-(void)btnMapClicked:(id)sender
{
    
}

#pragma mark - Notifications
-(void)registerNotifications
{
    [self removeNotifications];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getHeartBeatNotification:) name:@"getHeartBeatNotification" object:nil];
}

-(void)removeNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"getHeartBeatNotification" object:nil];
}

-(void)getHeartBeatNotification:(NSNotification*)center
{
    //    heartRate = (uint16_t)center.object;
    NSString *strHeartRate = (NSString*)center.object;
    NSLog(@"strHeartRate===%@",strHeartRate);
    
    lblHeartBeat.text = [NSString stringWithFormat:@"%@",strHeartRate];
    lblLastMeasuredHeartRate.text = [NSString stringWithFormat:@"%@",strHeartRate];

    heartRate = [strHeartRate integerValue];
//    NSLog(@"heartRate===>>>>>>>>>%i",heartRate);
    
    [NSTimer scheduledTimerWithTimeInterval:(60. / self.heartRate) target:self selector:@selector(doHeartBeat) userInfo:nil repeats:NO];
}

#pragma mark - Heart Beat Animation
- (void) doHeartBeat
{
    //----*Animation for background coloe*----//
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.duration = 0.1;
    scaleAnimation.repeatCount = 2;
    scaleAnimation.autoreverses = YES;
    scaleAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    scaleAnimation.toValue = [NSNumber numberWithFloat:1.2];
    [imgHeart.layer addAnimation:scaleAnimation forKey:@"scale"];
}


#pragma mark - CleanUp
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
