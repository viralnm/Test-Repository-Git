//
//  RegisterVC2.m
//  Heart Rate Monitor
//
//  Created by Oneclick IT Solution on 6/9/15.
//  Copyright (c) 2015 One Click IT Consultancy . All rights reserved.
//

#import "RegisterVC2.h"

@interface RegisterVC2 ()

@end

@implementation RegisterVC2

@synthesize detailDict;
@synthesize imgProfile;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    addDelegate =(AppDelegate *) [[UIApplication sharedApplication] delegate];
    
    arrHeightFeet = [[NSMutableArray alloc] initWithObjects:@"3",@"4",@"5",@"6",@"7", nil];
    arrHeightInch = [[NSMutableArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12", nil];
    
    arrGender = [[NSMutableArray alloc] initWithObjects:@"Male",@"Female", nil];
    
    [self setHeaderViewFrame];
    
    [self setScrollViewContent];

    [self setDetailPickerViews];
}



-(void)setHeaderViewFrame
{
    UIView * viewHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 64)];
    [viewHeader setBackgroundColor:[APP_DELEGATE colorWithHexString:light_green_color]];
    [self.view addSubview:viewHeader];
    
    UILabel * lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(60, 20, 200, 44)];
    [lblTitle setText:@"Physical Setting"];
    [lblTitle setTextAlignment:NSTextAlignmentCenter];
    [lblTitle setTextColor:[UIColor blackColor]];
    [lblTitle setBackgroundColor:[UIColor clearColor]];
    [lblTitle setFont:[UIFont boldSystemFontOfSize:18]];
    [viewHeader addSubview:lblTitle];
    
    
    UIButton * btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnBack setFrame:CGRectMake(5, 20, 44, 44)];
    [btnBack setBackgroundColor:[UIColor clearColor]];
    [btnBack setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(btnBackClicekd:) forControlEvents:UIControlEventTouchUpInside];
    [viewHeader addSubview:btnBack];
    
    
    btnSkip = [UIButton buttonWithType:UIButtonTypeSystem];
    [btnSkip setFrame:CGRectMake(255, 20, 60, 44)];
    [btnSkip setBackgroundColor:[UIColor clearColor]];
    btnSkip.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [btnSkip setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnSkip setTitle:@"Skip" forState:UIControlStateNormal];
    btnSkip.showsTouchWhenHighlighted = YES;
    [btnSkip addTarget:self action:@selector(btnNextClicked:) forControlEvents:UIControlEventTouchUpInside];
    [viewHeader addSubview:btnSkip];
}

-(void)setScrollViewContent
{
    if (IS_IPHONE_5) {
        scrlContent = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 80, 320, 568-80)];
    }else{
        scrlContent = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 80, 320, 480-80)];
    }
    [scrlContent setBackgroundColor:[UIColor clearColor]];
    scrlContent.delegate = self;
    scrlContent.showsHorizontalScrollIndicator = NO;
    scrlContent.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrlContent];
    
    int yy = 0;
    
    
    UIImageView * imgIcon = [[UIImageView alloc] initWithFrame:CGRectMake(115, yy+15, 90, 90)];
    [imgIcon setImage:[UIImage imageNamed:@"heart_icon1.png"]];
    imgIcon.contentMode = UIViewContentModeScaleAspectFit;
    [scrlContent addSubview:imgIcon];
    
    
    yy = yy+115;
    
//    lblStaticHeight = [[UILabel alloc] initWithFrame:CGRectMake(30, yy, 90, 30)];
//    [lblStaticHeight setBackgroundColor:[UIColor clearColor]];
//    [lblStaticHeight setTextColor:[UIColor lightGrayColor]];
//    [lblStaticHeight setTextAlignment:NSTextAlignmentLeft];
//    [lblStaticHeight setText:@"Career"];
//    [lblStaticHeight setFont:[UIFont fontWithName:CustomRegularFont size:13]];
//    [scrlContent addSubview:lblStaticHeight];
    
    UIImageView * imgHeightIcon = [[UIImageView alloc] initWithFrame:CGRectMake(15, yy+5, 25, 25)];
    [imgHeightIcon setImage:[UIImage imageNamed:@"height_icon.png"]];
    imgHeightIcon.contentMode = UIViewContentModeScaleAspectFit;
    [scrlContent addSubview:imgHeightIcon];
    
    txtHeight = [[UITextField alloc] initWithFrame:CGRectMake(55, yy, 250, 35)];
    txtHeight.delegate = self;
    [txtHeight setTintColor:[APP_DELEGATE colorWithHexString:yellow_color]];
    [txtHeight setBackgroundColor:[UIColor clearColor]];
    [txtHeight setTextColor:[UIColor grayColor]];
    [txtHeight setPlaceholder:@"Height"];
    [txtHeight setTextAlignment:NSTextAlignmentLeft];
    [txtHeight setFont:[UIFont fontWithName:CustomRegularFont size:15]];
    [scrlContent addSubview:txtHeight];
    
    UIButton * btnHeight = [UIButton buttonWithType:UIButtonTypeSystem];
    [btnHeight setFrame:CGRectMake(50, yy, 260, 40)];
    [btnHeight setBackgroundColor:[UIColor clearColor]];
    [btnHeight addTarget:self action:@selector(btnHeightClicked:) forControlEvents:UIControlEventTouchUpInside];
    [scrlContent addSubview:btnHeight];
    
    yy = yy+40;
    
    UILabel * lblLine1 = [[UILabel alloc] initWithFrame:CGRectMake(0, yy, 320, 0.3)];
    [lblLine1 setBackgroundColor:[UIColor darkGrayColor]];
    [scrlContent addSubview:lblLine1];
    
    yy = yy+15;
    
//    lblStaticWeight = [[UILabel alloc] initWithFrame:CGRectMake(30, yy, 90, 30)];
//    [lblStaticWeight setBackgroundColor:[UIColor clearColor]];
//    [lblStaticWeight setTextColor:[UIColor lightGrayColor]];
//    [lblStaticWeight setTextAlignment:NSTextAlignmentLeft];
//    [lblStaticWeight setText:@"Career"];
//    [lblStaticWeight setFont:[UIFont fontWithName:CustomRegularFont size:13]];
//    [scrlContent addSubview:lblStaticWeight];
    
    UIImageView * imgWeightIcon = [[UIImageView alloc] initWithFrame:CGRectMake(15, yy+5, 25, 25)];
    [imgWeightIcon setImage:[UIImage imageNamed:@"weight_icon.png"]];
    imgWeightIcon.contentMode = UIViewContentModeScaleAspectFit;
    [scrlContent addSubview:imgWeightIcon];
    
    txtWeight = [[UITextField alloc] initWithFrame:CGRectMake(55, yy, 250, 35)];
    txtWeight.delegate = self;
    [txtWeight setTintColor:[APP_DELEGATE colorWithHexString:yellow_color]];
    [txtWeight setBackgroundColor:[UIColor clearColor]];
    [txtWeight setTextColor:[UIColor grayColor]];
    [txtWeight setPlaceholder:@"Weight"];
    txtWeight.keyboardType = UIKeyboardTypeNumberPad;
    [txtWeight setTextAlignment:NSTextAlignmentLeft];
    [txtWeight setFont:[UIFont fontWithName:CustomRegularFont size:15]];
    [scrlContent addSubview:txtWeight];
    
    yy = yy+40;
    
    UILabel * lblLine2 = [[UILabel alloc] initWithFrame:CGRectMake(0, yy, 320, 0.3)];
    [lblLine2 setBackgroundColor:[UIColor darkGrayColor]];
    [scrlContent addSubview:lblLine2];
    
    yy = yy+15;
    
//    lblStaticBirthdate = [[UILabel alloc] initWithFrame:CGRectMake(30, yy, 90, 30)];
//    [lblStaticBirthdate setBackgroundColor:[UIColor clearColor]];
//    [lblStaticBirthdate setTextColor:[UIColor lightGrayColor]];
//    [lblStaticBirthdate setTextAlignment:NSTextAlignmentLeft];
//    [lblStaticBirthdate setText:@"Career"];
//    [lblStaticBirthdate setFont:[UIFont fontWithName:CustomRegularFont size:13]];
//    [scrlContent addSubview:lblStaticBirthdate];
    
    UIImageView * imgBirthDateIcon = [[UIImageView alloc] initWithFrame:CGRectMake(15, yy+5, 25, 25)];
    [imgBirthDateIcon setImage:[UIImage imageNamed:@"dob_icon.png"]];
    imgBirthDateIcon.contentMode = UIViewContentModeScaleAspectFit;
    [scrlContent addSubview:imgBirthDateIcon];
    
    txtBirthdate = [[UITextField alloc] initWithFrame:CGRectMake(55, yy, 250, 35)];
    txtBirthdate.delegate = self;
    [txtBirthdate setTintColor:[APP_DELEGATE colorWithHexString:yellow_color]];
    [txtBirthdate setBackgroundColor:[UIColor clearColor]];
    [txtBirthdate setTextColor:[UIColor grayColor]];
    [txtBirthdate setPlaceholder:@"Date of Birth"];
    [txtBirthdate setTextAlignment:NSTextAlignmentLeft];
    [txtBirthdate setFont:[UIFont fontWithName:CustomRegularFont size:15]];
    [scrlContent addSubview:txtBirthdate];
    
    
    UIButton * btnBirthdate = [UIButton buttonWithType:UIButtonTypeSystem];
    [btnBirthdate setFrame:CGRectMake(50, yy, 260, 40)];
    [btnBirthdate setBackgroundColor:[UIColor clearColor]];
    [btnBirthdate addTarget:self action:@selector(btnBirthdateClicked:) forControlEvents:UIControlEventTouchUpInside];
    [scrlContent addSubview:btnBirthdate];
    
    yy = yy+40;
    
    UILabel * lblLine3 = [[UILabel alloc] initWithFrame:CGRectMake(0, yy, 320, 0.3)];
    [lblLine3 setBackgroundColor:[UIColor darkGrayColor]];
    [scrlContent addSubview:lblLine3];
    
    yy = yy+15;
    
    
//    lblStaticGender = [[UILabel alloc] initWithFrame:CGRectMake(30, yy, 90, 30)];
//    [lblStaticGender setBackgroundColor:[UIColor clearColor]];
//    [lblStaticGender setTextColor:[UIColor lightGrayColor]];
//    [lblStaticGender setTextAlignment:NSTextAlignmentLeft];
//    [lblStaticGender setText:@"Career"];
//    [lblStaticGender setFont:[UIFont fontWithName:CustomRegularFont size:13]];
//    [scrlContent addSubview:lblStaticGender];
    
    UIImageView * imgGenderIcon = [[UIImageView alloc] initWithFrame:CGRectMake(15, yy+5, 25, 25)];
    [imgGenderIcon setImage:[UIImage imageNamed:@"gender_icon.png"]];
    imgGenderIcon.contentMode = UIViewContentModeScaleAspectFit;
    [scrlContent addSubview:imgGenderIcon];
    
    txtGender = [[UITextField alloc] initWithFrame:CGRectMake(55, yy, 250, 35)];
    txtGender.delegate = self;
    [txtGender setTintColor:[APP_DELEGATE colorWithHexString:yellow_color]];
    [txtGender setBackgroundColor:[UIColor clearColor]];
    [txtGender setTextColor:[UIColor grayColor]];
    [txtGender setPlaceholder:@"Sex"];
    [txtGender setTextAlignment:NSTextAlignmentLeft];
    [txtGender setFont:[UIFont fontWithName:CustomRegularFont size:15]];
    [scrlContent addSubview:txtGender];
    
    
    UIButton * btnGender = [UIButton buttonWithType:UIButtonTypeSystem];
    [btnGender setFrame:CGRectMake(50, yy, 260, 40)];
    [btnGender setBackgroundColor:[UIColor clearColor]];
    [btnGender addTarget:self action:@selector(btnGenderClicked:) forControlEvents:UIControlEventTouchUpInside];
    [scrlContent addSubview:btnGender];
    
    yy = yy+40;
    
    UILabel * lblLine4 = [[UILabel alloc] initWithFrame:CGRectMake(0, yy, 320, 0.3)];
    [lblLine4 setBackgroundColor:[UIColor darkGrayColor]];
    [scrlContent addSubview:lblLine4];
    
    yy = yy+15;
    
    btnContinue = [UIButton buttonWithType:UIButtonTypeCustom];
    if (IS_IPHONE_5) {
        [btnContinue setFrame:CGRectMake(0 , 568-44, 320, 44)];
    }else{
        [btnContinue setFrame:CGRectMake(0 , 480-44, 320, 44)];
    }
    [btnContinue setBackgroundColor:[APP_DELEGATE colorWithHexString:light_green_color]];
    [btnContinue setTitle:@"Save" forState:UIControlStateNormal];
    [btnContinue setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnContinue setTag:2];
    [btnContinue addTarget:self action:@selector(btnNextClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnContinue];
}

-(void)setDetailPickerViews
{
    if (IS_IPHONE_5) {
        viewHeight = [[UIView alloc] initWithFrame:CGRectMake(0, 568, 320, 250)];
    }else{
        viewHeight = [[UIView alloc] initWithFrame:CGRectMake(0, 480, 320, 250)];
    }
    [viewHeight setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:viewHeight];
    
    pickerHeight = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 34, 320, 216)];
    [pickerHeight setBackgroundColor:[UIColor clearColor]];
    [pickerHeight setDelegate:self];
    [pickerHeight setDataSource:self];
    [viewHeight addSubview:pickerHeight];
    
    UIButton * btnDone1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnDone1 setFrame:CGRectMake(0 , 0, 320, 34)];
    [btnDone1 setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [btnDone1 setTitle:@"Done" forState:UIControlStateNormal];
    [btnDone1 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [btnDone1 setTag:1];
    [btnDone1 addTarget:self action:@selector(btnDoneClicekd:) forControlEvents:UIControlEventTouchUpInside];
    [viewHeight addSubview:btnDone1];
    
    
    
    
    viewBirthday = [[UIView alloc] initWithFrame:CGRectMake(0, 568, 320, 250)];
    [viewBirthday setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:viewBirthday];
    
    UIButton * btnDone2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnDone2 setFrame:CGRectMake(0 , 0, 320, 34)];
    [btnDone2 setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [btnDone2 setTitle:@"Done" forState:UIControlStateNormal];
    [btnDone2 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [btnDone2 setTag:2];
    [btnDone2 addTarget:self action:@selector(btnDoneClicekd:) forControlEvents:UIControlEventTouchUpInside];
    [viewBirthday addSubview:btnDone2];
    
    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 34, 320, 216)];
    [datePicker setBackgroundColor:[UIColor whiteColor]];
    [datePicker setDatePickerMode:UIDatePickerModeDate];
    [datePicker addTarget:self action:@selector(updateDate:) forControlEvents:UIControlEventValueChanged];
    [datePicker setMaximumDate:[NSDate date]];
    [viewBirthday addSubview:datePicker];
    
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *dateStr = [dateFormatter stringFromDate:date];
    selectedDate=dateStr;
    NSLog(@"selectedDate====>%@",selectedDate);
    [datePicker setDate:[dateFormatter dateFromString:selectedDate]];
    
    
    
    viewGender = [[UIView alloc] initWithFrame:CGRectMake(0, 568, 320, 250)];
    [viewGender setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:viewGender];
    
    pickerGender = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 34, 320, 216)];
    [pickerGender setBackgroundColor:[UIColor whiteColor]];
    [pickerGender setDelegate:self];
    [pickerGender setDataSource:self];
    [viewGender addSubview:pickerGender];
    
    UIButton * btnDone3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnDone3 setFrame:CGRectMake(0 , 0, 320, 34)];
    [btnDone3 setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [btnDone3 setTitle:@"Done" forState:UIControlStateNormal];
    [btnDone3 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [btnDone3 setTag:2];
    [btnDone3 addTarget:self action:@selector(btnDoneClicekd:) forControlEvents:UIControlEventTouchUpInside];
    [viewGender addSubview:btnDone3];
    
}

-(void)updateDate:(id)sender
{
    UIDatePicker *datePicker1 = (UIDatePicker *)sender;
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSLog(@"datePicker1.date--%@",datePicker1.date);
    selectedDate = [df stringFromDate: datePicker1.date];
    NSLog(@"selectedDate--%@",selectedDate);
}

#pragma mark - Button Click
-(void)btnBackClicekd:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)btnNextClicked:(id)sender
{
    [detailDict setValue:txtHeight.text forKey:@"height"];
    [detailDict setValue:txtWeight.text forKey:@"weight"];
    [detailDict setValue:txtBirthdate.text forKey:@"birthdate"];
    [detailDict setValue:txtGender.text forKey:@"gender"];
    
    [self registerAccountWebService];
}

-(void)btnDoneClicekd:(id)sender
{
    if ([sender tag] == 1)
    {
        [self showDatePicker:NO andView:viewHeight];
        
        NSString *selectedFeet = [arrHeightFeet objectAtIndex:[pickerHeight selectedRowInComponent:0]];
        NSString *selectedInch = [arrHeightInch objectAtIndex:[pickerHeight selectedRowInComponent:1]];
        [txtHeight setText:[NSString stringWithFormat:@"%@ft %@in",selectedFeet,selectedInch]] ;
    }
    else if ([sender tag] ==2)
    {
        [self showDatePicker:NO andView:viewBirthday];
       
        NSDate * date = [datePicker date];
        
        NSDateFormatter * df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"yyyy-MM-dd"];
        selectedDate = [df stringFromDate:date];
        NSLog(@"selectedDate===%@",selectedDate);
        
        [txtBirthdate setText:selectedDate];
    }
    else if ([sender tag]==3)
    {
        [self showDatePicker:NO andView:viewGender];
       
        NSString *selectedTitle = [arrGender objectAtIndex:[pickerGender selectedRowInComponent:0]];
        NSLog(@"%@", selectedTitle);
        [txtGender setText:selectedTitle];
    }
    
    
    [self hideKeyBoard];
    [self hidePickerViews];
}

-(void)btnHeightClicked:(id)sender
{
    [self hideKeyBoard];
    
    [self showDatePicker:YES andView:viewHeight];
}

-(void)btnBirthdateClicked:(id)sender
{
    [self hideKeyBoard];
    
    [self showDatePicker:YES andView:viewBirthday];
}

-(void)btnGenderClicked:(id)sender
{
    [self hideKeyBoard];
    
    [self showDatePicker:YES andView:viewGender];
}

#pragma mark - PickerView Delegate
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (pickerView == pickerHeight) {
        return 2;
    }else{
        return 1;
    }
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        if (pickerView == pickerHeight) {
            return [arrHeightFeet count];
        }else {
            return [arrGender count];
        }
    }else{
        return [arrHeightInch count];
    }
}

/*-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
 {
 return [arrInterest objectAtIndex:row];
 }*/

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label = (UILabel*) view;
    if (label == nil)
    {
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, pickerView.frame.size.width, 44)];
    }
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor darkGrayColor];
    label.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:17];
    label.tag = row;
    
    if (component == 0)
    {
        if (pickerView == pickerHeight) {
            [label setFrame:CGRectMake(0, 0, 120, 44)];
            label.text = [NSString stringWithFormat:@"%@ ft",[arrHeightFeet objectAtIndex:row]];
            label.textAlignment = NSTextAlignmentRight;
        }else {
            label.text = [NSString stringWithFormat:@"%@",[arrGender objectAtIndex:row]];
        }
    }
    else
    {
        label.textAlignment = NSTextAlignmentLeft;
        label.text = [NSString stringWithFormat:@"%@ in",[arrHeightInch objectAtIndex:row]];
        [label setFrame:CGRectMake(40, 0, 120, 44)];
    }
    return label;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0)
    {
        if (pickerView == pickerHeight)
        {
            NSString *selectedFeet = [arrHeightFeet objectAtIndex:[pickerHeight selectedRowInComponent:0]];
            NSString *selectedInch = [arrHeightInch objectAtIndex:[pickerHeight selectedRowInComponent:1]];
            [txtHeight setText:[NSString stringWithFormat:@"%@ft %@in",selectedFeet,selectedInch]] ;
        }
        else
        {
            [txtGender setText:[arrGender objectAtIndex:row]];
        }
    }
    else
    {
        NSString *selectedFeet = [arrHeightFeet objectAtIndex:[pickerHeight selectedRowInComponent:0]];
        NSString *selectedInch = [arrHeightInch objectAtIndex:[pickerHeight selectedRowInComponent:1]];
        [txtHeight setText:[NSString stringWithFormat:@"%@ft %@in",selectedFeet,selectedInch]] ;
    }
}


#pragma mark - Animations
-(void)showDatePicker:(BOOL)isShow andView:(UIView *)myView
{
    if (isShow == YES)
    {
        [UIView transitionWithView:myView duration:0.4
                           options:UIViewAnimationOptionCurveEaseIn
                        animations:^{
                            if (IS_IPHONE_5) {
                                [myView setFrame:CGRectMake(0, 568-250, 320, 250)];
                            }else{
                                [myView setFrame:CGRectMake(0, 480-250, 320, 250)];
                            }
                        }
                        completion:^(BOOL finished) {
                        }];
    }
    else
    {
        [UIView transitionWithView:myView duration:0.4
                           options:UIViewAnimationOptionTransitionNone
                        animations:^{
                            if (IS_IPHONE_5) {
                                [myView setFrame:CGRectMake(0, 568, 320, 250)];
                            }else{
                                [myView setFrame:CGRectMake(0, 480, 320, 250)];
                            }
                        }
                        completion:^(BOOL finished) {
                        }];
    }
}

#pragma mark - hideKeyBoard
-(void)hideKeyBoard
{
    [txtHeight resignFirstResponder];
    [txtWeight resignFirstResponder];
    [txtBirthdate resignFirstResponder];
    [txtGender resignFirstResponder];
}

#pragma mark - hidePickerViews
-(void)hidePickerViews
{
    [self showDatePicker:NO andView:viewHeight];
    [self showDatePicker:NO andView:viewBirthday];
    [self showDatePicker:NO andView:viewGender];
}

#pragma mark - TextField Delegate
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self hidePickerViews];
    
    if (IS_IPHONE_5) {
        [scrlContent setContentSize:CGSizeMake(320, 568+250)];
    }else{
        [scrlContent setContentSize:CGSizeMake(320, 480+250)];
    }
    
//    [scrlContent setContentOffset:CGPointMake(0, 300) animated:NO];
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (IS_IPHONE_5) {
        [scrlContent setContentSize:CGSizeMake(320, 568)];
    }else{
        [scrlContent setContentSize:CGSizeMake(320, 480)];
    }
    
    [self hideKeyBoard];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self hideKeyBoard];
    
    if (IS_IPHONE_5) {
        [scrlContent setContentSize:CGSizeMake(320, 568)];
    }else{
        [scrlContent setContentSize:CGSizeMake(320, 480)];
    }
    
    return YES;
}


#pragma mark - Web Service
-(void)registerAccountWebService
{
    NSLog(@"detailDict====%@",detailDict);
    [HUD show:YES];
    NSString * webServiceName = @"signup";
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    if (deviceTokenStr) {
        [dict setObject:deviceTokenStr forKey:@"device_token"];
    }
    [dict setObject:@"0" forKey:@"device_type"];
    [dict setObject:appLatitude forKey:@"current_latitude"];
    [dict setObject:appLongitude forKey:@"current_longitude"];
    [dict setObject:[APP_DELEGATE getUTCFormateDate:[NSDate date]] forKey:@"created_date"];
    
    NSData* data = UIImageJPEGRepresentation(imgProfile, 0.2f);
    NSString *encodedImage =[data base64Encoding];
    [dict setObject:encodedImage forKey:@"photo"];
    
    if ([detailDict valueForKey:@"sessionUserId"])
    {
        [dict setObject:[detailDict valueForKey:@"sessionUserId"] forKey:@"twitter_id"];
    }
    
    if ([detailDict valueForKey:@"phone"])
    {
        [dict setObject:[detailDict valueForKey:@"phone"] forKey:@"phone"];
    }
    
    if ([detailDict valueForKey:@"first_name"])
    {
        [dict setObject:[detailDict valueForKey:@"first_name"] forKey:@"first_name"];
    }
    
    if ([detailDict valueForKey:@"last_name"])
    {
        [dict setObject:[detailDict valueForKey:@"last_name"] forKey:@"last_name"];
    }
    
    if ([detailDict valueForKey:@"height"])
    {
        if ([detailDict valueForKey:@"height"] !=[NSNull null] && [detailDict valueForKey:@"height"] != NULL && ![[detailDict valueForKey:@"height"] isEqualToString:@""]) {
            [dict setObject:[detailDict valueForKey:@"height"] forKey:@"height"];
        }
    }
    
    if ([detailDict valueForKey:@"weight"])
    {
        if ([detailDict valueForKey:@"weight"] !=[NSNull null] && [detailDict valueForKey:@"weight"] != NULL && ![[detailDict valueForKey:@"weight"] isEqualToString:@""]) {
            [dict setObject:[detailDict valueForKey:@"weight"] forKey:@"weight"];
        }
    }
    
    if ([detailDict valueForKey:@"birthdate"])
    {
        [dict setObject:[detailDict valueForKey:@"birthdate"] forKey:@"birthdate"];
    }
    
    
    if ([detailDict valueForKey:@"gender"])
    {
        [dict setObject:[[detailDict valueForKey:@"gender"] lowercaseString] forKey:@"gender"];
    }
    
    NSLog(@"dictionaryprint:%@",dict);
    
    URLManager *manager = [[URLManager alloc] init];
    manager.delegate = self;
    manager.commandName = @"registerAccount";
    [manager urlCall:[NSString stringWithFormat:@"%@%@",WEB_SERVICE_URL,webServiceName]  withParameters:dict];
}

#pragma mark Response
- (void)onResult:(NSDictionary *)result
{
    [HUD hide:YES];
    
    NSLog(@"Result :%@",result);
    if([[result valueForKey:@"commandName"] isEqualToString:@"registerAccount"])
    {
        if([[[[result valueForKey:@"result"] valueForKey:@"data"] valueForKey:@"response"] isEqualToString:@"false"])
        {
            URBAlertView *alertView = [[URBAlertView alloc] initWithTitle:ALERT_TITLE message:[[[result valueForKey:@"result"] valueForKey:@"data"]valueForKey:@"msg"] cancelButtonTitle:OK_BTN otherButtonTitles: nil, nil];
            [alertView setMessageFont:[UIFont fontWithName:@"Arial" size:14]];
            [alertView setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView) {
                [alertView hideWithCompletionBlock:^{
                    NSLog(@"buttonIndex====>%ld",(long)buttonIndex);
                }];
            }];
            [alertView showWithAnimation:Alert_Animation_Type];
        }
        else
        {
            [self setUserDefaultWhenLogIn:[[[result valueForKey:@"result"] valueForKey:@"data"] valueForKey:@"response_data"]];
            
//            HomeVC * home = [[HomeVC alloc] initWithNibName:@"HomeVC" bundle:nil];
//            [self.navigationController pushViewController:home animated:YES];
            
            _sideMenuViewController = [[SideMenuVC alloc] init];
            container = [MFSideMenuContainerViewController containerWithCenterViewController:[self navigationController] leftMenuViewController:_sideMenuViewController rightMenuViewController:nil];
            addDelegate.window.rootViewController = container;
        }
    }
    
}

- (void)onError:(NSError *)error
{
    [HUD hide:YES];
    NSLog(@"The error is...%@", error);
    
    NSInteger ancode = [error code];
    [APP_DELEGATE ShowNoNetworkConnectionPopUpWithErrorCode:ancode];
}

-(void)setUserDefaultWhenLogIn:(NSDictionary*)result
{
    NSLog(@"LoginUser dict ====%@",result);
    NSUserDefaults *LoginUser=[NSUserDefaults standardUserDefaults];
    
    [LoginUser setValue:[result valueForKey:@"app_user_id"] forKey:@"userId"];
    
    if ([result valueForKey:@"twitter_id"]!=[NSNull null] && ![[result valueForKey:@"twitter_id"] isEqualToString:@""])
    {
        [LoginUser setValue:[result valueForKey:@"twitter_id"] forKey:@"CURRENT_User_Twitter_Session_Id"];
    }else{
        [LoginUser setValue:@"" forKey:@"CURRENT_User_Twitter_Session_Id"];
    }
    
    if ([result valueForKey:@"first_name"]!=[NSNull null] && ![[result valueForKey:@"first_name"] isEqualToString:@""])
    {
        [LoginUser setValue:[result valueForKey:@"first_name"] forKey:@"User_Firstname"];
    }else{
        [LoginUser setValue:@"" forKey:@"User_Firstname"];
    }
    
    if ([result valueForKey:@"last_name"]!=[NSNull null] && ![[result valueForKey:@"last_name"] isEqualToString:@""])
    {
        [LoginUser setValue:[result valueForKey:@"last_name"] forKey:@"User_Lastname"];
    }else{
        [LoginUser setValue:@"" forKey:@"User_Lastname"];
    }
    
    if ([result valueForKey:@"phone"]!=[NSNull null] && ![[result valueForKey:@"phone"] isEqualToString:@""])
    {
        [LoginUser setValue:[result valueForKey:@"phone"] forKey:@"User_Phone"];
    }else{
        [LoginUser setValue:@"" forKey:@"User_Phone"];
    }
    
    
    if ([result valueForKey:@"weight"]!=[NSNull null] && ![[result valueForKey:@"weight"] isEqualToString:@""])
    {
        [LoginUser setValue:[result valueForKey:@"weight"] forKey:@"User_Weight"];
    }else{
        [LoginUser setValue:@"" forKey:@"User_Weight"];
    }
    
    if ([result valueForKey:@"height"]!=[NSNull null] && ![[result valueForKey:@"height"] isEqualToString:@""])
    {
        [LoginUser setValue:[result valueForKey:@"height"] forKey:@"User_Height"];
    }else{
        [LoginUser setValue:@"" forKey:@"User_Height"];
    }
    
    if ([result valueForKey:@"birthdate"]!=[NSNull null] && ![[result valueForKey:@"birthdate"] isEqualToString:@""])
    {
        [LoginUser setValue:[result valueForKey:@"birthdate"] forKey:@"User_Birthdate"];
    }else{
        [LoginUser setValue:@"" forKey:@"User_Birthdate"];
    }
    
    if ([result valueForKey:@"gender"]!=[NSNull null] && ![[result valueForKey:@"gender"] isEqualToString:@""])
    {
        [LoginUser setValue:[result valueForKey:@"gender"] forKey:@"User_Gender"];
    }else{
        [LoginUser setValue:@"" forKey:@"User_Gender"];
    }
    
    if ([result valueForKey:@"photo"]!=[NSNull null] && ![[result valueForKey:@"photo"] isEqualToString:@""])
    {
        [LoginUser setValue:[result valueForKey:@"photo"] forKey:@"User_Image"];
    }else{
        [LoginUser setValue:@"" forKey:@"User_Image"];
    }
    
    NSLog(@"CURRENT_USER_ID==========%@",CURRENT_USER_ID);
    NSLog(@"CURRENT_USER_TWITTER_ID==========%@",CURRENT_USER_TWITTER_ID);
    NSLog(@"CURRENT_USER_FIRSTNAME==========%@",CURRENT_USER_FIRSTNAME);
    NSLog(@"CURRENT_USER_LASTNAME==========%@",CURRENT_USER_LASTNAME);
    NSLog(@"CURRENT_USER_Phone==========%@",CURRENT_USER_Phone);
    NSLog(@"CURRENT_USER_PROFILE_IMAGE==========%@",CURRENT_USER_PROFILE_IMAGE);
    NSLog(@"CURRENT_USER_HEIGHT==========%@",CURRENT_USER_HEIGHT);
    NSLog(@"CURRENT_USER_WEIGHT==========%@",CURRENT_USER_WEIGHT);
    NSLog(@"CURRENT_USER_BIRTHDATE==========%@",CURRENT_USER_BIRTHDATE);
    NSLog(@"CURRENT_USER_GENDER==========%@",CURRENT_USER_GENDER);

    [LoginUser synchronize];
}


#pragma mark Home view delegate
- (HomeVC *)demoController
{
    return [[HomeVC alloc] initWithNibName:@"HomeVC" bundle:nil];
}


- (UINavigationController *)navigationController
{
    return [[UINavigationController alloc] initWithRootViewController:[self demoController]];
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
