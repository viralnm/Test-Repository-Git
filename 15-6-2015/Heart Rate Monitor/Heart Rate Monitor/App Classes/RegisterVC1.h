//
//  RegisterVC1.h
//  Heart Rate Monitor
//
//  Created by Oneclick IT Solution on 6/9/15.
//  Copyright (c) 2015 One Click IT Consultancy . All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RegisterVC2.h"

@interface RegisterVC1 : UIViewController<UIScrollViewDelegate,UITextFieldDelegate,UIPickerViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>
{
    UIScrollView * scrlContent;
    
    UIImageView * imgProfileImage;
    UIButton * btnProfileImage;
    
    UITextField * txtFirstname;
    UITextField * txtLastname;
    UITextField * txtPhone;
    
    UIImageView * imgFirstnameCheck;
    UIImageView * imgLastnameCheck;
    UIImageView * imgPhoneCheck;
    
    BOOL isFirstnameValidated;
    BOOL isLastnameValidated;
    BOOL isPhoneValidated;
    
    BOOL isProfileImageChanged;
    
    UIButton * btnContinue;
    UIButton * btnNext;
}

@property(nonatomic,strong)NSMutableDictionary * userDetailDict;

@end
