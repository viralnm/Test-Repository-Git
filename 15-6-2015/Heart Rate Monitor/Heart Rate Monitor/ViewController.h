//
//  ViewController.h
//  Heart Rate Monitor
//
//  Created by One Click IT Consultancy  on 5/30/15.
//  Copyright (c) 2015 One Click IT Consultancy . All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BLEManager.h"
#import "BLEService.h"

@interface ViewController : UIViewController
{
    UIImageView * imgHeart;
    
    UILabel * lblHeartBeat;
}

@property (assign) uint16_t heartRate;

@end

