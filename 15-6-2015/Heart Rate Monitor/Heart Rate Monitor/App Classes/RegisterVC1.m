//
//  RegisterVC1.m
//  Heart Rate Monitor
//
//  Created by Oneclick IT Solution on 6/9/15.
//  Copyright (c) 2015 One Click IT Consultancy . All rights reserved.
//

#import "RegisterVC1.h"

@interface RegisterVC1 ()

@end

@implementation RegisterVC1

@synthesize userDetailDict;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    userDetailDict = [[NSMutableDictionary alloc] init];
//    [userDetailDict setObject:@"30181689371" forKey:@"sessionUserId"];
//    [userDetailDict setObject:@"+918866586171" forKey:@"mobileNumber"];
    
    isProfileImageChanged = NO;
    
    isPhoneValidated = YES;
    
    [self setHeaderViewFrame];
    
    [self setScrollViewContent];
    
    [self registerNotifications];
}

-(void)registerNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextFieldTextDidChangeNotification object:txtFirstname];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextFieldTextDidChangeNotification object:txtLastname];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextFieldTextDidChangeNotification object:txtPhone];
}

-(void)setHeaderViewFrame
{
    UIView * viewHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 64)];
    [viewHeader setBackgroundColor:[APP_DELEGATE colorWithHexString:light_green_color]];
    [self.view addSubview:viewHeader];
    
    UILabel * lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(60, 20, 200, 44)];
    [lblTitle setText:@"Register"];
    [lblTitle setTextAlignment:NSTextAlignmentCenter];
    [lblTitle setTextColor:[UIColor blackColor]];
    [lblTitle setBackgroundColor:[UIColor clearColor]];
    [lblTitle setFont:[UIFont boldSystemFontOfSize:18]];
    [viewHeader addSubview:lblTitle];
    
    btnNext = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnNext setFrame:CGRectMake(260, 20, 60, 44)];
    [btnNext setBackgroundColor:[UIColor clearColor]];
    [btnNext setTitle:@"Next" forState:UIControlStateNormal];
    btnNext.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [btnNext setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnNext addTarget:self action:@selector(btnNextClicekd:) forControlEvents:UIControlEventTouchUpInside];
    [viewHeader addSubview:btnNext];
}

-(void)setScrollViewContent
{
    if (IS_IPHONE_5) {
        scrlContent = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 85, 320, 568-85)];
    }else{
        scrlContent = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 85, 320, 480-85)];
    }
    [scrlContent setBackgroundColor:[UIColor clearColor]];
    scrlContent.delegate = self;
    scrlContent.showsHorizontalScrollIndicator = NO;
    scrlContent.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrlContent];
    
    int yy = 0;
    
    imgProfileImage = [[UIImageView alloc] initWithFrame:CGRectMake(115, yy+5, 90 , 90)];
    [imgProfileImage setImage:[UIImage imageNamed:@"profile_men.png"]];
    imgProfileImage.layer.cornerRadius = 45;
    imgProfileImage.layer.borderColor = [UIColor lightGrayColor].CGColor;
    imgProfileImage.layer.borderWidth = 0.5;
    imgProfileImage.clipsToBounds = YES;
    imgProfileImage.contentMode = UIViewContentModeScaleAspectFill;
    [scrlContent addSubview:imgProfileImage];
    
    btnProfileImage = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnProfileImage setFrame:CGRectMake(115, yy+5, 90, 90)];
    [btnProfileImage addTarget:self action:@selector(btnProfileImageClicked:) forControlEvents:UIControlEventTouchUpInside];
    [scrlContent addSubview:btnProfileImage];
    
    yy = yy + 110;
    
    UIImageView * imgFirstNameIcon = [[UIImageView alloc] initWithFrame:CGRectMake(15, yy+5, 25, 25)];
    [imgFirstNameIcon setImage:[UIImage imageNamed:@"fname_icon.png"]];
    imgFirstNameIcon.contentMode = UIViewContentModeScaleAspectFit;
    [scrlContent addSubview:imgFirstNameIcon];
    
    txtFirstname = [[UITextField alloc] initWithFrame:CGRectMake(55, yy, 250, 35)];
    txtFirstname.delegate = self;
    [txtFirstname setTintColor:[APP_DELEGATE colorWithHexString:yellow_color]];
    [txtFirstname setBackgroundColor:[UIColor clearColor]];
    [txtFirstname setTextColor:[UIColor darkGrayColor]];
    [txtFirstname setPlaceholder:@"Firstname"];
    [txtFirstname setFont:[UIFont fontWithName:CustomRegularFont size:15]];
    [scrlContent addSubview:txtFirstname];
    
    imgFirstnameCheck = [[UIImageView alloc] initWithFrame:CGRectMake(290, yy+15, 10 , 10)];
    [imgFirstnameCheck setImage:[UIImage imageNamed:@"tick.png"]];
    [scrlContent addSubview:imgFirstnameCheck];
    
    yy = yy+40;
    
    UILabel * lblLine1 = [[UILabel alloc] initWithFrame:CGRectMake(0, yy, 320, 0.3)];
    [lblLine1 setBackgroundColor:[UIColor darkGrayColor]];
    [scrlContent addSubview:lblLine1];
    
    yy = yy+15;
    
    UIImageView * imgLastNameIcon = [[UIImageView alloc] initWithFrame:CGRectMake(15, yy+5, 25, 25)];
    [imgLastNameIcon setImage:[UIImage imageNamed:@"fname_icon.png"]];
    imgLastNameIcon.contentMode = UIViewContentModeScaleAspectFit;
    [scrlContent addSubview:imgLastNameIcon];
    
    txtLastname = [[UITextField alloc] initWithFrame:CGRectMake(55, yy, 250, 35)];
    txtLastname.delegate = self;
    [txtLastname setTintColor:[APP_DELEGATE colorWithHexString:yellow_color]];
    [txtLastname setBackgroundColor:[UIColor clearColor]];
    [txtLastname setTextColor:[UIColor darkGrayColor]];
    txtLastname.autocapitalizationType = UITextAutocapitalizationTypeNone;
    txtLastname.keyboardType = UIKeyboardTypeEmailAddress;
    [txtLastname setPlaceholder:@"Lastname"];
    [txtLastname setFont:[UIFont fontWithName:CustomRegularFont size:15]];
    [scrlContent addSubview:txtLastname];
    
    imgLastnameCheck = [[UIImageView alloc] initWithFrame:CGRectMake(290, yy+15, 10 , 10)];
    [imgLastnameCheck setImage:[UIImage imageNamed:@"tick.png"]];
    [scrlContent addSubview:imgLastnameCheck];
    
    yy = yy+40;
    
    UILabel * lblLine2 = [[UILabel alloc] initWithFrame:CGRectMake(0, yy, 320, 0.3)];
    [lblLine2 setBackgroundColor:[UIColor darkGrayColor]];
    [scrlContent addSubview:lblLine2];
    
    yy = yy+15;
    
    UIImageView * imgPhoneIcon = [[UIImageView alloc] initWithFrame:CGRectMake(15, yy+5, 25, 25)];
    [imgPhoneIcon setImage:[UIImage imageNamed:@"contact_icon.png"]];
    imgPhoneIcon.contentMode = UIViewContentModeScaleAspectFit;
    [scrlContent addSubview:imgPhoneIcon];
    
    txtPhone = [[UITextField alloc] initWithFrame:CGRectMake(55, yy, 250, 35)];
    txtPhone.delegate = self;
    [txtPhone setTintColor:[APP_DELEGATE colorWithHexString:yellow_color]];
    [txtPhone setBackgroundColor:[UIColor clearColor]];
    [txtPhone setTextColor:[UIColor darkGrayColor]];
    [txtPhone setPlaceholder:@"Phone Number"];
    [txtPhone setFont:[UIFont fontWithName:CustomRegularFont size:15]];
    [scrlContent addSubview:txtPhone];
    [txtPhone setUserInteractionEnabled:NO];
    [txtPhone setText:[userDetailDict valueForKey:@"phone"]];
    
    imgPhoneCheck = [[UIImageView alloc] initWithFrame:CGRectMake(290, yy+15, 10 , 10)];
    [imgPhoneCheck setImage:[UIImage imageNamed:@"tick.png"]];
    [scrlContent addSubview:imgPhoneCheck];
    
    yy = yy+40;
    
    UILabel * lblLine3 = [[UILabel alloc] initWithFrame:CGRectMake(0, yy, 320, 0.3)];
    [lblLine3 setBackgroundColor:[UIColor darkGrayColor]];
    [scrlContent addSubview:lblLine3];
    
    yy = yy+50;
    
//    btnContinue = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btnContinue setFrame:CGRectMake(0, yy, 320, 40)];
//    [btnContinue setBackgroundColor:[UIColor clearColor]];
//    [btnContinue setImage:[UIImage imageNamed:@"continue-yellow.png"] forState:UIControlStateNormal];
//    [btnContinue addTarget:self action:@selector(btnNextClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [scrlContent addSubview:btnContinue];
}

#pragma mark - Button Click
-(void)btnProfileImageClicked:(id)sender
{
    UIActionSheet *imagePickerType= [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:ALERT_CANCEL destructiveButtonTitle:nil otherButtonTitles: ACTION_TAKE_PHOTO ,ACTION_LIBRARY_PHOTO, nil];
    imagePickerType.tag = 3;
    [imagePickerType  showInView:self.view];
}

-(void)btnNextClicekd:(id)sender
{
    [self hideKeyBoard];

    [userDetailDict setValue:txtFirstname.text forKey:@"first_name"];
    [userDetailDict setValue:txtLastname.text forKey:@"last_name"];
//    [userDetailDict setValue:txtPhone.text forKey:@"phone"];
    
    if (!isProfileImageChanged)
    {
        URBAlertView *alertView = [[URBAlertView alloc] initWithTitle:ALERT_TITLE message:@"Please upload your profile picture." cancelButtonTitle:OK_BTN otherButtonTitles: nil, nil];
        [alertView setMessageFont:[UIFont fontWithName:@"Arial" size:12]];
        [alertView setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView) {
            NSLog(@"button tapped: index=%ld", (long)buttonIndex);
            [alertView hideWithCompletionBlock:^{
                
            }];
        }];
        [alertView showWithAnimation:Alert_Animation_Type];
    }
    else if (!isFirstnameValidated)
    {
        URBAlertView *alertView = [[URBAlertView alloc] initWithTitle:ALERT_TITLE message:@"Please insert your firstname." cancelButtonTitle:OK_BTN otherButtonTitles: nil, nil];
        [alertView setMessageFont:[UIFont fontWithName:@"Arial" size:12]];
        [alertView setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView) {
            NSLog(@"button tapped: index=%ld", (long)buttonIndex);
            [alertView hideWithCompletionBlock:^{
                
            }];
        }];
        [alertView showWithAnimation:Alert_Animation_Type];
    }
    else if (!isLastnameValidated)
    {
        URBAlertView *alertView = [[URBAlertView alloc] initWithTitle:ALERT_TITLE message:@"Please insert your lastname." cancelButtonTitle:OK_BTN otherButtonTitles: nil, nil];
        [alertView setMessageFont:[UIFont fontWithName:@"Arial" size:12]];
        [alertView setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView) {
            NSLog(@"button tapped: index=%ld", (long)buttonIndex);
            [alertView hideWithCompletionBlock:^{
                
            }];
        }];
        [alertView showWithAnimation:Alert_Animation_Type];
    }
    else if (!isPhoneValidated)
    {
        URBAlertView *alertView = [[URBAlertView alloc] initWithTitle:ALERT_TITLE message:@"Please insert your Phone Number." cancelButtonTitle:OK_BTN otherButtonTitles: nil, nil];
        [alertView setMessageFont:[UIFont fontWithName:@"Arial" size:12]];
        [alertView setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView) {
            NSLog(@"button tapped: index=%ld", (long)buttonIndex);
            [alertView hideWithCompletionBlock:^{
                
            }];
        }];
        [alertView showWithAnimation:Alert_Animation_Type];
    }
    else
    {
        RegisterVC2 * register_view2 = [[RegisterVC2 alloc]initWithNibName:@"RegisterVC2" bundle:nil];
        register_view2.detailDict = [userDetailDict mutableCopy];
        if (isProfileImageChanged == YES)
        {
            register_view2.imgProfile = imgProfileImage.image;
        } else{
            register_view2.imgProfile = nil;
        }
        [self.navigationController pushViewController:register_view2 animated:YES];
    }
}

#pragma mark - hideKeyBoard
-(void)hideKeyBoard
{
    [txtFirstname resignFirstResponder];
    [txtFirstname resignFirstResponder];
    [txtPhone resignFirstResponder];
}
#pragma mark - TextField Delegate
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
   
    if (IS_IPHONE_5) {
        [scrlContent setContentSize:CGSizeMake(320, 568+250)];
    }else{
        [scrlContent setContentSize:CGSizeMake(320, 480+250)];
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (IS_IPHONE_5) {
        [scrlContent setContentSize:CGSizeMake(320, 568)];
    }else{
        [scrlContent setContentSize:CGSizeMake(320, 480)];
    }
    
    if (textField == txtFirstname)
    {
        if ([textField.text length]>0) {
            [imgFirstnameCheck setImage:[UIImage imageNamed:@"selected-tick.png"]];
            isFirstnameValidated = YES;
        }else{
            [imgFirstnameCheck setImage:[UIImage imageNamed:@"tick.png"]];
            isFirstnameValidated = NO;
        }
    }
    else if (textField == txtLastname)
    {
        if ([textField.text length]>0) {
            [imgLastnameCheck setImage:[UIImage imageNamed:@"selected-tick.png"]];
            isLastnameValidated = YES;
        }else{
            [imgLastnameCheck setImage:[UIImage imageNamed:@"tick.png"]];
            isLastnameValidated = NO;
        }
    }
    else if (textField == txtPhone)
    {
        if ([textField.text length]>0) {
            [imgPhoneCheck setImage:[UIImage imageNamed:@"selected-tick.png"]];
            isPhoneValidated = YES;
        }else{
            [imgPhoneCheck setImage:[UIImage imageNamed:@"tick.png"]];
            isPhoneValidated = NO;
        }
    }
    
    if (isFirstnameValidated == YES && isLastnameValidated ==YES && isPhoneValidated== YES )
    {
        [btnNext setImage:[UIImage imageNamed:@"yellow_arrow_right.png"] forState:UIControlStateNormal];
    }else{
        [btnNext setImage:[UIImage imageNamed:@"gray_arrow_right.png"] forState:UIControlStateNormal];
    }
    
    [self hideKeyBoard];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];

    if (IS_IPHONE_5) {
        [scrlContent setContentSize:CGSizeMake(320, 568)];
    }else{
        [scrlContent setContentSize:CGSizeMake(320, 480)];
    }
    
    if (textField == txtFirstname)
    {
        if ([textField.text length]>0) {
            [imgFirstnameCheck setImage:[UIImage imageNamed:@"selected-tick.png"]];
            isFirstnameValidated = YES;
        }else{
            [imgFirstnameCheck setImage:[UIImage imageNamed:@"tick.png"]];
            isFirstnameValidated = NO;
        }
    }
    else if (textField == txtLastname)
    {
        if ([textField.text length]>0) {
            [imgLastnameCheck setImage:[UIImage imageNamed:@"selected-tick.png"]];
            isLastnameValidated = YES;
        }else{
            [imgLastnameCheck setImage:[UIImage imageNamed:@"tick.png"]];
            isLastnameValidated = NO;
        }
    }
    else if (textField == txtPhone)
    {
        if ([textField.text length]>0) {
            [imgPhoneCheck setImage:[UIImage imageNamed:@"selected-tick.png"]];
            isPhoneValidated = YES;
        }else{
            [imgPhoneCheck setImage:[UIImage imageNamed:@"tick.png"]];
            isPhoneValidated = NO;
        }
    }
    
    if (isFirstnameValidated == YES && isLastnameValidated ==YES && isPhoneValidated== YES )
    {
        [btnNext setImage:[UIImage imageNamed:@"yellow_arrow_right.png"] forState:UIControlStateNormal];
    }else{
        [btnNext setImage:[UIImage imageNamed:@"gray_arrow_right.png"] forState:UIControlStateNormal];
    }
    
    return YES;
}

#pragma mark - textDidChange notification
- (void)textDidChange:(NSNotification *)note
{
    UITextField * textField = note.object;
    
    if (textField == txtFirstname)
    {
        if ([textField.text length]>0) {
            [imgFirstnameCheck setImage:[UIImage imageNamed:@"selected-tick.png"]];
            isFirstnameValidated = YES;
        }else{
            [imgFirstnameCheck setImage:[UIImage imageNamed:@"tick.png"]];
            isFirstnameValidated = NO;
        }
    }
    else if (textField == txtLastname)
    {
        if ([textField.text length]>0) {
            [imgLastnameCheck setImage:[UIImage imageNamed:@"selected-tick.png"]];
            isLastnameValidated = YES;
        }else{
            [imgLastnameCheck setImage:[UIImage imageNamed:@"tick.png"]];
            isLastnameValidated = NO;
        }
    }
    else if (textField == txtPhone)
    {
        if ([textField.text length]>0) {
            [imgPhoneCheck setImage:[UIImage imageNamed:@"selected-tick.png"]];
            isPhoneValidated = YES;
        }else{
            [imgPhoneCheck setImage:[UIImage imageNamed:@"tick.png"]];
            isPhoneValidated = NO;
        }
    }
    
    if (isFirstnameValidated == YES && isLastnameValidated ==YES && isPhoneValidated== YES )
    {
        [btnNext setImage:[UIImage imageNamed:@"yellow_arrow_right.png"] forState:UIControlStateNormal];
    }else{
        [btnNext setImage:[UIImage imageNamed:@"gray_arrow_right.png"] forState:UIControlStateNormal];
    }
   
}


#pragma mark - ActionSheet Delegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(actionSheet.tag == 3)
    {
        if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:ALERT_CANCEL])
            return;
        
        UIImagePickerController *imagePicker =[[UIImagePickerController alloc] init];
        imagePicker.delegate    =self;
        imagePicker.allowsEditing = YES;
        if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:ACTION_TAKE_PHOTO])
        {
//            isFacebookClicked = NO;
            if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
                imagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;
                
                [self presentViewController:imagePicker animated:YES completion:nil];
            }
            else {
                imagePicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
                //            if (IS_IPAD) {
                //                popVC = [[UIPopoverController alloc] initWithContentViewController:imagePicker];
                //                [popVC presentPopoverFromRect:adsphotoImg.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
                //            }else
                [self presentViewController:imagePicker animated:YES completion:nil];
            }
        }
        else if([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:ACTION_LIBRARY_PHOTO])
        {
//            isFacebookClicked = NO;
            imagePicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
            //        if (IS_IPAD) {
            //            popVC = [[UIPopoverController alloc] initWithContentViewController:imagePicker];
            //            [popVC presentPopoverFromRect:adsphotoImg.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            //        }else
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
    }
}

-(void) actionSheetCancel:(UIActionSheet *)actionSheet
{
//    isFacebookClicked = NO;
}

#pragma mark - Image Picker Controller Delegate
-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    
    if(image == nil)
    {
        
    }
    else
    {
        isProfileImageChanged = YES;
        
        imgProfileImage.image = image;
        
        //        [self addUserImageWebServiceWithImage:image];
    }
    
    [picker dismissModalViewControllerAnimated:YES];
}

-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

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
