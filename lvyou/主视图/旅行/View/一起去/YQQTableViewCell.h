//
//  YQQTableViewCell.h
//  lvyou
//
//  Created by imac on 15/9/28.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentView.h"
#import "YQQModel.h"
@interface YQQTableViewCell : UITableViewCell
{
    UIButton *_userImage;  //用户头像
    UILabel *_userName;   //用户名
    UIView *_sexAge;   //用户性别和年龄
    UIImageView *image;
    UILabel *label;
    UILabel *_time;    //发表时间
    UILabel *_distance;  //距离
    ContentView *_content;  //内容
    
    UIButton *_like;  //喜欢
    UIButton *_comment;  //评论
    UIButton *_join;  //加入
    
    UIImageView *line;
    UIImageView *line1;
    UIView *view1;
    UIView *view2;
}

@property(nonatomic, strong)YQQModel *model;

@end
