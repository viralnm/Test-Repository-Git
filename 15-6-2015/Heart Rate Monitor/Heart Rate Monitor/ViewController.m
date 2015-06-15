//
//  ViewController.m
//  Heart Rate Monitor
//
//  Created by One Click IT Consultancy  on 5/30/15.
//  Copyright (c) 2015 One Click IT Consultancy . All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize heartRate;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setHeaderViewFrame];
    
    imgHeart = [[UIImageView alloc] initWithFrame:CGRectMake(60, 150, 200, 200)];
    [imgHeart setBackgroundColor:[UIColor clearColor]];
    
    [imgHeart setImage:[UIImage imageNamed:@"heart1.png"]];
    [self.view addSubview:imgHeart];
    
    lblHeartBeat = [[UILabel alloc] initWithFrame:CGRectMake(70, 220, 180, 40)];
    [lblHeartBeat setText:@"0 BPM"];
    [lblHeartBeat setTextAlignment:NSTextAlignmentCenter];
    [lblHeartBeat setTextColor:[UIColor whiteColor]];
    [lblHeartBeat setBackgroundColor:[UIColor clearColor]];
    [lblHeartBeat setFont:[UIFont boldSystemFontOfSize:25]];
    [self.view addSubview:lblHeartBeat];
    
    UILabel * lblStatus = [[UILabel alloc] initWithFrame:CGRectMake(70, 400, 180, 40)];
    [lblStatus setText:@"Connected"];
    [lblStatus setTextAlignment:NSTextAlignmentCenter];
    [lblStatus setTextColor:[UIColor darkGrayColor]];
    [lblStatus setBackgroundColor:[UIColor clearColor]];
    [lblStatus setFont:[UIFont boldSystemFontOfSize:17]];
    [self.view addSubview:lblStatus];
    
    [self registerNotifications];
    
    [BLEManager sharedManager];
}

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
    
    lblHeartBeat.text = [NSString stringWithFormat:@"%@ BPM",strHeartRate];
    
    heartRate = [strHeartRate integerValue];
    NSLog(@"heartRate===>>>>>>>>>%i",heartRate);

    [NSTimer scheduledTimerWithTimeInterval:(60. / self.heartRate) target:self selector:@selector(doHeartBeat) userInfo:nil repeats:NO];
}

-(void)setHeaderViewFrame
{
    UIView * viewHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 64)];
    [viewHeader setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:viewHeader];
    
    UILabel * lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(60, 20, 200, 44)];
    [lblTitle setText:@"Heart Rate Monitor"];
    [lblTitle setTextAlignment:NSTextAlignmentCenter];
    [lblTitle setTextColor:[UIColor darkGrayColor]];
    [lblTitle setBackgroundColor:[UIColor clearColor]];
    [lblTitle setFont:[UIFont boldSystemFontOfSize:18]];
    [viewHeader addSubview:lblTitle];
    
    UILabel * lblLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 63, 320, 1)];
    [lblLine setBackgroundColor:[UIColor darkGrayColor]];
    [viewHeader addSubview:lblLine];

}

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
