//
//  RegisterVC2.h
//  Heart Rate Monitor
//
//  Created by Oneclick IT Solution on 6/9/15.
//  Copyright (c) 2015 One Click IT Consultancy . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeVC.h"

#import "MBProgressHUD.h"
#import "URLManager.h"

#import "MFSideMenu.h"
#import "SideMenuVC.h"

@class AppDelegate;

@interface RegisterVC2 : UIViewController<UIScrollViewDelegate,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource,URLManagerDelegate>
{
    MBProgressHUD * HUD;
    
    UIButton * btnSkip;
    UIScrollView * scrlContent;
    
    UILabel * lblStaticHeight;
    UILabel * lblStaticWeight;
    UILabel * lblStaticBirthdate;
    UILabel * lblStaticGender;
    
    
    UITextField * txtHeight;
    UITextField * txtWeight;
    UITextField * txtBirthdate;
    UITextField * txtGender;
    
    UIButton * btnContinue;
    
    
    UIView * viewBirthday;
    UIDatePicker * datePicker;
    UIView * viewHeight;
    UIPickerView * pickerHeight;
    
    UIView * viewGender;
    UIPickerView * pickerGender;
    
        
    NSMutableArray * arrHeightFeet;
    NSMutableArray * arrHeightInch;
    
    NSMutableArray * arrGender;
    
    NSString * selectedDate;
    NSString * selectedGender;
    
    AppDelegate * addDelegate;
    
    MFSideMenuContainerViewController *container;
}

@property(nonatomic,strong)NSMutableDictionary * detailDict;
@property(nonatomic,strong)UIImage * imgProfile;

@property (strong, nonatomic) SideMenuVC *sideMenuViewController;

@end
