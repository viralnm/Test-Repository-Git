//
//  SideMenuCell.h
//  Heart Rate Monitor
//
//  Created by One Click IT Consultancy  on 6/12/15.
//  Copyright (c) 2015 One Click IT Consultancy . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"

@interface SideMenuCell : UITableViewCell

@property (nonatomic ,strong) AsyncImageView * imgType;
@property (nonatomic , strong) UILabel * lblTypeName;
@property (nonatomic ,strong) AsyncImageView * imgArrow;
@property (nonatomic , strong) UILabel * lblUpper;
@property (nonatomic , strong) UILabel * lblLower;

@end
