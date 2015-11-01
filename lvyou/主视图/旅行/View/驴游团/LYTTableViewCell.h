//
//  LYTTableViewCell.h
//  lvyou
//
//  Created by imac on 15/9/30.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYTModel.h"
@interface LYTTableViewCell : UITableViewCell
{
    UIImageView *_picImageView;  //景区图片
    UIButton *_likeButton; //喜欢的按钮
    UIButton *_locationButton;  //位置的按钮
    UILabel *_priceLable;  //价格
    UILabel *_sourceLable; //来源
    UILabel *_topicLable; // 话题
    
    UILabel *_timeLable;  //时间
    UILabel *_durationLable;  //多长时间
    UILabel *_remarkLable;  //标记
    
    
    UIButton *_like;  //分享
    UIButton *_comment;  //评论
    UIButton *_join;  //加入
    
    UIImageView *line;
    UIImageView *line1;
    UIView *view1;
    UIView *view2;
}

@property(nonatomic, strong)LYTModel *model;

@end
