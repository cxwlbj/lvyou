//
//  LeftViewController.h
//  lvyou
//
//  Created by imac on 15/9/28.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "BaseViewController.h"
#import "ProfileModel.h"

@interface LeftViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_tableView;
    UIView *_headerView;
    UIImageView *_userImage;
    UIView *_sexAge;
    UIImageView *image;
    UILabel *label;
    UILabel *_userName;
    UIButton *_editButton;
    UILabel *_want;
    UIButton *_friends;
    UIButton *_follower;
    
    NSDictionary *userMessage;
    NSArray *_tableTitle;
    NSArray *_tableImgs;
    
    UIButton *loginButton;
    UIButton *logoutButton;
}
@property(nonatomic, strong)ProfileModel *model;
@property(nonatomic, assign)BOOL isLogin;

@end
