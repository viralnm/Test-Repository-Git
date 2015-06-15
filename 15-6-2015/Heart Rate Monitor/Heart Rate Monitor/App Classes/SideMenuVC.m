//
//  SideMenuVC.m
//  Heart Rate Monitor
//
//  Created by Oneclick IT Solution on 6/11/15.
//  Copyright (c) 2015 One Click IT Consultancy . All rights reserved.
//

#import "SideMenuVC.h"

@interface SideMenuVC ()

@end

@implementation SideMenuVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray * attay =[[NSArray alloc]initWithObjects:@"Home",@"Profile",@"Services",@"Contacts",@"Settings",@"Logout", nil];
    
    _menuItems=[[NSMutableArray alloc]init];
    for (int i=0; i<attay.count; i++) {
        NSMutableDictionary * dict=[[NSMutableDictionary alloc] init];
        [dict setObject:[attay objectAtIndex:i] forKey:@"type"];
        [dict setObject:@"no" forKey:@"isSelected"];
        
        [_menuItems addObject:dict];
    }

    
    
    UIImageView * backBg = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 320, 568)];
//    [backBg setImage:[UIImage imageNamed:@"overlay-bg.png"]];
    [backBg setBackgroundColor:[UIColor darkGrayColor]];
    [self.view addSubview:backBg];
    
    
    
    if (IS_IPAD) {
        _menuTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, 768, 1024-20) style:UITableViewStylePlain];
        [backBg setFrame:CGRectMake(0,-1, 768, 1026)];
    } else {
        if (IS_IPHONE_5) {
            _menuTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, 320, 548) style:UITableViewStylePlain];
            [backBg setFrame:CGRectMake(0, -1, 320, 570)];
        }else{
            _menuTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, 320, 548-88) style:UITableViewStylePlain];
            [backBg setFrame:CGRectMake(0, -1, 320, 482)];
        }
    }
    _menuTableView.delegate = self;
    _menuTableView.dataSource = self;
    _menuTableView.backgroundColor = [UIColor clearColor];
    _menuTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _menuTableView.separatorColor = [UIColor darkGrayColor];
    [self.view addSubview:_menuTableView];
    
    
    if (IS_IPAD) {
        headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 360, 180)];
    } else {
        headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 180)];
    }
    [headerView setBackgroundColor:[UIColor clearColor]];
    
    profileImg = [[AsyncImageView alloc] initWithFrame:CGRectMake(90, 40, 90, 90)];
    [profileImg setImage:[UIImage imageNamed:@"profile_men.png"]];
    profileImg.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",CURRENT_USER_PROFILE_IMAGE]];
    [profileImg setBackgroundColor:[UIColor whiteColor]];
    profileImg.layer.cornerRadius = 45;
    profileImg.layer.borderColor = [UIColor whiteColor].CGColor;
    profileImg.layer.borderWidth = 2.0;
    [profileImg setContentMode:UIViewContentModeScaleAspectFill];
    profileImg.layer.masksToBounds = YES;
    [headerView addSubview:profileImg];
    
    UILabel * lblUsername = [[UILabel alloc] initWithFrame:CGRectMake(10, 135, 250, 35)];
    //    [lblUsername setText:[NSString stringWithFormat:@"%@ %@",CURRENT_USER_FIRSTNAME,CURRENT_USER_LASTNAME]];
    [lblUsername setText:[NSString stringWithFormat:@"%@",CURRENT_USER_FIRSTNAME]];
    [lblUsername setTextColor:[UIColor whiteColor]];
    [lblUsername setNumberOfLines:2];
    [lblUsername setBackgroundColor:[UIColor clearColor]];
    [lblUsername setTextAlignment:NSTextAlignmentCenter];
    [headerView addSubview:lblUsername];
    
//    UILabel * lblLine1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, 400, 0.5)];
//    [lblLine1 setBackgroundColor:[UIColor darkGrayColor]];
//    [headerView addSubview:lblLine1];
    
    
//    if (IS_IPAD) {
//        [profileImg setFrame:CGRectMake(15, 15, 80, 80)];
//        profileImg.layer.cornerRadius = 40;
//        [lblUsername setFrame:CGRectMake(110, 25, 250, 45)];
//        [lblUsername setFont:[UIFont fontWithName:@"Arial" size:20]];
//        [lblLine1 setFrame:CGRectMake(0, 120, 400, 0.5)];
//    } else {
//        [profileImg setFrame:CGRectMake(15, 15, 70, 70)];
//        profileImg.layer.cornerRadius = 35;
//        [lblUsername setFrame:CGRectMake(90, 25, 170, 45)];
//        [lblUsername setFont:[UIFont fontWithName:@"Arial" size:15]];
//        [lblLine1 setFrame:CGRectMake(0, 100, 400, 0.5)];
//    }
    
    _menuTableView.tableHeaderView = headerView;
}

#pragma mark- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _menuItems.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (IS_IPAD) {
        return 90.0f;
    }else{
        return 50.0f;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SideMenuCell *cell =[tableView dequeueReusableCellWithIdentifier:@"ReusableCellID"];
    if (cell == nil) {
        cell = [[SideMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ReusableCellID"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //    _menuItems = @[@"Home",@"Cases",@"Reminders",@"Profile",@"Sign Out"];
    
    if (IS_IPAD) {
        [cell.lblTypeName setFont:[UIFont systemFontOfSize:22]];
    } else {
        [cell.lblTypeName setFont:[UIFont systemFontOfSize:18]];
    }
    
    cell.lblTypeName.text = [NSString stringWithFormat:@"%@",[[_menuItems objectAtIndex:indexPath.row] valueForKey:@"type"]];
    
    cell.backgroundColor = [UIColor clearColor];
    
    if([[[_menuItems objectAtIndex:indexPath.row]valueForKey:@"isSelected"]isEqualToString:@"no"])
    {
        cell.lblUpper.backgroundColor = [UIColor clearColor];
        cell.lblLower.backgroundColor = [UIColor lightGrayColor];
        if (indexPath.row==_menuItems.count-1)
        {
            //cell.lblLower.backgroundColor = [UIColor clearColor];
        }
        else
        {
            if ([[[_menuItems objectAtIndex:indexPath.row+1]valueForKey:@"isSelected"]isEqualToString:@"yes"])
            {
                cell.lblLower.backgroundColor = [UIColor clearColor];
            }
            else
            {
                cell.lblLower.backgroundColor = [UIColor lightGrayColor];
            }
        }
        
    }
    else
    {
        cell.lblUpper.backgroundColor = [APP_DELEGATE colorWithHexString:light_green_color];
        cell.lblLower.backgroundColor = [APP_DELEGATE colorWithHexString:light_green_color];
    }

    
    if (indexPath.row ==0)
    {
        if([[[_menuItems objectAtIndex:indexPath.row]valueForKey:@"isSelected"]isEqualToString:@"no"])
        {
             cell.imgType.image = [UIImage imageNamed:@"home_icon.png"];
             cell.imgArrow.image = [UIImage imageNamed:@""];
            cell.lblTypeName.textColor = [UIColor whiteColor];
//            cell.lblUpper.backgroundColor = [UIColor clearColor];
//            cell.lblLower.backgroundColor = [UIColor whiteColor];

        }
        else
        {
            cell.imgType.image = [UIImage imageNamed:@"home_icon_selected.png"];
            cell.imgArrow.image = [UIImage imageNamed:@"green_arrow_line.png"];
            cell.lblTypeName.textColor = [APP_DELEGATE colorWithHexString:light_green_color];
        }
    }else if (indexPath.row ==1)
    {
        if([[[_menuItems objectAtIndex:indexPath.row]valueForKey:@"isSelected"]isEqualToString:@"no"])
        {
            cell.imgType.image = [UIImage imageNamed:@"profile_icon.png"];
            cell.imgArrow.image = [UIImage imageNamed:@""];
            cell.lblTypeName.textColor = [UIColor whiteColor];
//            cell.lblUpper.backgroundColor = [UIColor clearColor];
//            cell.lblLower.backgroundColor = [UIColor whiteColor];

        }
        else
        {
            cell.imgType.image = [UIImage imageNamed:@"profile_icon_selected.png"];
            cell.imgArrow.image = [UIImage imageNamed:@"green_arrow_line.png"];
            cell.lblTypeName.textColor = [APP_DELEGATE colorWithHexString:light_green_color];
//            cell.lblUpper.backgroundColor = [APP_DELEGATE colorWithHexString:light_green_color];
//            cell.lblLower.backgroundColor = [APP_DELEGATE colorWithHexString:light_green_color];

        }
    }
    else if (indexPath.row ==2)
    {
        if([[[_menuItems objectAtIndex:indexPath.row]valueForKey:@"isSelected"]isEqualToString:@"no"])
        {
            cell.imgType.image = [UIImage imageNamed:@"services_icon.png"];
            cell.imgArrow.image = [UIImage imageNamed:@""];
            cell.lblTypeName.textColor = [UIColor whiteColor];
//            cell.lblUpper.backgroundColor = [UIColor clearColor];
//            cell.lblLower.backgroundColor = [UIColor whiteColor];

            
        }
        else
        {
            cell.imgType.image = [UIImage imageNamed:@"services_icon_selected.png"];
            cell.imgArrow.image = [UIImage imageNamed:@"green_arrow_line.png"];
            cell.lblTypeName.textColor = [APP_DELEGATE colorWithHexString:light_green_color];
//            cell.lblUpper.backgroundColor = [APP_DELEGATE colorWithHexString:light_green_color];
//            cell.lblLower.backgroundColor = [APP_DELEGATE colorWithHexString:light_green_color];

        }
    }
    else if (indexPath.row ==3)
    {
        if([[[_menuItems objectAtIndex:indexPath.row]valueForKey:@"isSelected"]isEqualToString:@"no"])
        {
            cell.imgType.image = [UIImage imageNamed:@"profile_icon.png"];
            cell.imgArrow.image = [UIImage imageNamed:@""];
            cell.lblTypeName.textColor = [UIColor whiteColor];
            //            cell.lblUpper.backgroundColor = [UIColor clearColor];
            //            cell.lblLower.backgroundColor = [UIColor whiteColor];
            
        }
        else
        {
            cell.imgType.image = [UIImage imageNamed:@"profile_icon_selected.png"];
            cell.imgArrow.image = [UIImage imageNamed:@"green_arrow_line.png"];
            cell.lblTypeName.textColor = [APP_DELEGATE colorWithHexString:light_green_color];
            //            cell.lblUpper.backgroundColor = [APP_DELEGATE colorWithHexString:light_green_color];
            //            cell.lblLower.backgroundColor = [APP_DELEGATE colorWithHexString:light_green_color];
            
        }
    }
    else if (indexPath.row ==4)
    {
        if([[[_menuItems objectAtIndex:indexPath.row]valueForKey:@"isSelected"]isEqualToString:@"no"])
        {
            cell.imgType.image = [UIImage imageNamed:@"setting_icon.png"];
            cell.imgArrow.image = [UIImage imageNamed:@""];
            cell.lblTypeName.textColor = [UIColor whiteColor];
            //            cell.lblUpper.backgroundColor = [UIColor clearColor];
            //            cell.lblLower.backgroundColor = [UIColor whiteColor];
            
        }
        else
        {
            cell.imgType.image = [UIImage imageNamed:@"setting_icon_selected.png"];
            cell.imgArrow.image = [UIImage imageNamed:@"green_arrow_line.png"];
            cell.lblTypeName.textColor = [APP_DELEGATE colorWithHexString:light_green_color];
            //            cell.lblUpper.backgroundColor = [APP_DELEGATE colorWithHexString:light_green_color];
            //            cell.lblLower.backgroundColor = [APP_DELEGATE colorWithHexString:light_green_color];
            
        }
    }
    else if (indexPath.row ==5)
    {
        if([[[_menuItems objectAtIndex:indexPath.row]valueForKey:@"isSelected"]isEqualToString:@"no"])
        {
            cell.imgType.image = [UIImage imageNamed:@"logout_icon.png"];
            cell.imgArrow.image = [UIImage imageNamed:@""];
            cell.lblTypeName.textColor = [UIColor whiteColor];
            //            cell.lblUpper.backgroundColor = [UIColor clearColor];
            //            cell.lblLower.backgroundColor = [UIColor whiteColor];
            
        }
        else
        {
            cell.imgType.image = [UIImage imageNamed:@"logout_icon_selected.png"];
            cell.imgArrow.image = [UIImage imageNamed:@"green_arrow_line.png"];
            cell.lblTypeName.textColor = [APP_DELEGATE colorWithHexString:light_green_color];
            //            cell.lblUpper.backgroundColor = [APP_DELEGATE colorWithHexString:light_green_color];
            //            cell.lblLower.backgroundColor = [APP_DELEGATE colorWithHexString:light_green_color];
            
        }
    }
   
    return cell;
}

#pragma mark- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if([[[_menuItems objectAtIndex:indexPath.row]valueForKey:@"isSelected"]isEqualToString:@"no"])
    {
        for (int i=0; i<_menuItems.count; i++)
        {
            [[_menuItems objectAtIndex:i]setObject:@"no" forKey:@"isSelected"];
        }
        
        [[_menuItems objectAtIndex:indexPath.row]setValue:@"yes" forKey:@"isSelected"];
    }
    else
    {
        [[_menuItems objectAtIndex:indexPath.row]setValue:@"no" forKey:@"isSelected"];
    }
    [_menuTableView reloadData];
    if (indexPath.row == 0){
        
        HomeVC *demoController = [[HomeVC alloc] initWithNibName:@"HomeVC" bundle:nil];
        UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
        NSArray *controllers = [NSArray arrayWithObject:demoController];
        navigationController.viewControllers = controllers;
        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
        
    }else if (indexPath.row == 1) {
        
//        MSGCasesViewController *demoController = [[MSGCasesViewController alloc] initWithNibName:@"MSGCasesViewController" bundle:nil];
//        demoController.isFromLeftMenu = YES;
//        UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
//        
//        NSArray *controllers = [NSArray arrayWithObject:demoController];
//        navigationController.viewControllers = controllers;
//        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
        
    }else if (indexPath.row == 2){
//        ReminderVC *demoController = [[ReminderVC alloc] initWithNibName:@"ReminderVC" bundle:nil];
//        UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
//        
//        NSArray *controllers = [NSArray arrayWithObject:demoController];
//        navigationController.viewControllers = controllers;
//        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
        
    }else if (indexPath.row == 3){
        
//        EditProfileVC *demoController = [[EditProfileVC alloc] initWithNibName:@"EditProfileVC" bundle:nil];
//        UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
//        NSArray *controllers = [NSArray arrayWithObject:demoController];
//        navigationController.viewControllers = controllers;
//        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
        
    }else if (indexPath.row == 4){
        //[self logoutWebServices];
    }else if (indexPath.row == 5){
        
        [self clearUserInformation];
        
    }
}

-(void)clearUserInformation
{
    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setValue:@"" forKey:@"userId"];
    [userDefault setValue:@"" forKey:@"CURRENT_User_Twitter_Session_Id"];
    [userDefault setValue:@"" forKey:@"User_Firstname"];
    [userDefault setValue:@"" forKey:@"User_Lastname"];
    [userDefault setValue:@"" forKey:@"User_Phone"];
    [userDefault setValue:@"" forKey:@"User_Image"];
    [userDefault setValue:@"" forKey:@"User_Height"];
    [userDefault setValue:@"" forKey:@"User_Weight"];
    [userDefault setValue:@"" forKey:@"User_Birthdate"];
    [userDefault setValue:@"" forKey:@"User_Gender"];
    
    [userDefault synchronize];
    
    AppDelegate *application =(AppDelegate *)[[UIApplication sharedApplication]delegate];
    StartUpScreenNew * start_up = [[StartUpScreenNew alloc] initWithNibName:@"StartUpScreenNew" bundle:nil];
    UINavigationController *nav =[[UINavigationController alloc] initWithRootViewController:start_up];
    application.window.rootViewController =nav;
    nav.navigationBarHidden=YES;
    [application.window makeKeyAndVisible];
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
