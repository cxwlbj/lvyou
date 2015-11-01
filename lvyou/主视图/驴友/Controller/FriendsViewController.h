//
//  FriendsViewController.h
//  lvyou
//
//  Created by imac on 15/9/28.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "BaseViewController.h"
#import "FriendsTableViewCell.h"
#import "FindFriendsView.h"

@interface FriendsViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate>
{
    BOOL status;   //显示身旁还是显示最热的状态
    UIImageView *selecting;
    UITableView *_tableView;
    UIControl *_headerView;
    FindFriendsView *_friendsView;
}

@property(nonatomic, strong)NSArray *hot_data;

@end
