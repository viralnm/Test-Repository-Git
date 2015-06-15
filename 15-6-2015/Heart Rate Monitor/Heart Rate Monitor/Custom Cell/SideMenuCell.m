//
//  SideMenuCell.m
//  Heart Rate Monitor
//
//  Created by One Click IT Consultancy  on 6/12/15.
//  Copyright (c) 2015 One Click IT Consultancy . All rights reserved.
//

#import "SideMenuCell.h"

@implementation SideMenuCell
@synthesize imgType,lblTypeName,imgArrow,lblUpper,lblLower;
- (void)awakeFromNib {
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
       
        
        lblUpper = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, .3)];
     

        imgType = [[AsyncImageView alloc] initWithFrame:CGRectMake(20, 10, 30, 30)];
        [imgType setContentMode:UIViewContentModeScaleAspectFit];
        
        imgArrow = [[AsyncImageView alloc] initWithFrame:CGRectMake(70, 0, 6, 50)];
        [imgArrow setContentMode:UIViewContentModeScaleAspectFit];
        
        lblTypeName = [[UILabel alloc] initWithFrame:CGRectMake(95, 0, 200, 50)];
        [lblTypeName setBackgroundColor:[UIColor clearColor]];
        [lblTypeName setTextColor:[UIColor grayColor]];
        [lblTypeName setFont:[UIFont fontWithName:@"Arial" size:15]];
        
        lblLower = [[UILabel alloc] initWithFrame:CGRectMake(0, 49.7, 320, 0.3)];
        

        
    }
    
    [self.contentView addSubview:imgType];
    [self.contentView addSubview:imgArrow];
    [self.contentView addSubview:lblTypeName];
    [self.contentView addSubview:lblUpper];
    [self.contentView addSubview:lblLower];
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
