//
//  MessageViewController.h
//  lvyou
//
//  Created by imac on 15/9/28.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "BaseViewController.h"
#import "MesViewController.h"
@interface MessageViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_tableView;
}

@property(nonatomic, strong)NSArray *imgs;
@property(nonatomic, strong)NSArray *titles;

@end
