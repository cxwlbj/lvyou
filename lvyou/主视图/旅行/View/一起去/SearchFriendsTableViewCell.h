//
//  SearchFriendsTableViewCell.h
//  lvyou
//
//  Created by imac on 15/10/7.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReplyModel.h"
@interface SearchFriendsTableViewCell : UITableViewCell
{
    UIButton *_userImage;  //用户头像
    UILabel *_userName;   //用户名
}

@property(nonatomic, strong)ReplyModel *model;

@end
