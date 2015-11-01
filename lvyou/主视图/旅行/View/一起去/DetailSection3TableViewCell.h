//
//  DetailSection3TableViewCell.h
//  lvyou
//
//  Created by imac on 15/9/30.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReplyModel.h"
@interface DetailSection3TableViewCell : UITableViewCell<WXLabelDelegate>
{
    UIButton *_userImage;  //用户头像
    UILabel *_userName;   //用户名
    UILabel *_time;    //发表时间
    WXLabel *_comment;  //内容
}

@property(nonatomic, strong)ReplyModel *model;

@end
