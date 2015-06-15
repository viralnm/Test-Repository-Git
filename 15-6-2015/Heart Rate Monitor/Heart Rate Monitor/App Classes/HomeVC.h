//
//  HomeVC.h
//  Heart Rate Monitor
//
//  Created by Oneclick IT Solution on 6/8/15.
//  Copyright (c) 2015 One Click IT Consultancy . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLEManager.h"
#import "BLEService.h"

#import "SideMenuVC.h"

@interface HomeVC : UIViewController
{
    UIImageView * imgHeart;
    
    UILabel * lblHeartBeat;
    
    UILabel * lblDate;
    UILabel * lblTime;
    
    UILabel * lblLastMeasureDateTime;
    UILabel * lblLastMeasuredHeartRate;
    
    UILabel * lblHeartRateType;
    UILabel * lblAverage;
    UILabel * lblHigh;
    UILabel * lblLow;
}

@property (assign) uint16_t heartRate;

@property (strong, nonatomic) SideMenuVC *sideMenuViewController;

@end
