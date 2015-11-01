//
//  SearchResultViewController.h
//  lvyou
//
//  Created by imac on 15/10/7.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "BaseSearchViewController.h"
#import "SearchFriendsTableView.h"
@interface SearchResultViewController : BaseSearchViewController<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_tableView;
    UIView *_selectView;
    UIButton *_yqqButton;
    UIButton *_lytButton;
    SearchFriendsTableView *_searchFriends;
}
@property(nonatomic, assign)BOOL status;
@property(nonatomic, copy)NSString *keyWords;
@property(nonatomic, strong)NSArray *resultData;
@property(nonatomic, strong)NSArray *friendsData;

@end
