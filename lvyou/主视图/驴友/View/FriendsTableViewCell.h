//
//  FriendsTableViewCell.h
//  lvyou
//
//  Created by imac on 15/10/4.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentView.h"
#import "YQQModel.h"
@interface FriendsTableViewCell : UITableViewCell
{
    UIButton *_userImage;  //用户头像
    UILabel *_userName;   //用户名
    UIView *_sexAge;   //用户性别和年龄
    UIImageView *image;
    UILabel *_maritalStatus; //用户描述
    UILabel *_want;
    UIButton *_like;  //喜欢
    UIButton *_comment;  //评论
    UILabel *label;
    UILabel *_time;    //发表时间
    UILabel *_distance;  //距离
    ContentView *_content;  //内容
    
    UILabel *_contentLabel;
    

}

@property(nonatomic, strong)YQQModel *model;

@end
