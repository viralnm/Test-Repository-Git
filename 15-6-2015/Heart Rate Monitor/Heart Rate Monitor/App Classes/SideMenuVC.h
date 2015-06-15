//
//  SideMenuVC.h
//  Heart Rate Monitor
//
//  Created by Oneclick IT Solution on 6/11/15.
//  Copyright (c) 2015 One Click IT Consultancy . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SideMenuCell.h"

#import "AsyncImageView.h"
@interface SideMenuVC : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_menuItems;
    UITableView *_menuTableView;
    UIView * headerView;
    AsyncImageView * profileImg;
    UILabel * lblUser;
    
    NSMutableArray * arraySelected;
    NSMutableArray * arrayTempSelected;

}

@end
