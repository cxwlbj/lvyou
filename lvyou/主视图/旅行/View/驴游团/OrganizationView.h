//
//  OrganizationView.h
//  lvyou
//
//  Created by imac on 15/9/28.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYTTableViewCell.h"
#import "WebViewController.h"
@interface OrganizationView : UIView<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_tableView;
}

@property(nonatomic, strong)NSArray *data;

@end
