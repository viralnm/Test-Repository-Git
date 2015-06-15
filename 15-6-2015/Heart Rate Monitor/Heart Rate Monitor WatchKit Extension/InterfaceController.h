//
//  InterfaceController.h
//  Heart Rate Monitor WatchKit Extension
//
//  Created by One Click IT Consultancy  on 5/30/15.
//  Copyright (c) 2015 One Click IT Consultancy . All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>


#import "HospitalsVC.h"

@interface InterfaceController : WKInterfaceController
{
}
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *lblHeartRate;

@end
