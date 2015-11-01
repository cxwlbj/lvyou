//
//  DetailViewController.h
//  lvyou
//
//  Created by imac on 15/9/30.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "BaseSecondViewController.h"
#import "YQQModel.h"
#import "ContentView.h"
#import "DetailSection3TableViewCell.h"
@interface DetailViewController : BaseSecondViewController<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_tableView;
    UIView *_tableViewHeaderView;
    UIView *_footView;
    
    UIButton *_userImage;  //用户头像
    UILabel *_userName;   //用户名
    UIView *_sexAge;   //用户性别和年龄
    UILabel *_maritalStatus; //用户描述
    UILabel *_want;
    UIImageView *image;
    UILabel *label;
    UILabel *_time;    //发表时间
    UILabel *_distance;  //距离
    ContentView *_content;  //内容
    
    UIButton *_like;  //喜欢
    UIButton *_comment;  //评论
    UIButton *_join;  //加入
    UIView *view;
    UIView *imgView;  //显示头像的视图
    
    UIButton *likeButton;
    UIButton *commentButton;
    
   
}
@property(nonatomic, strong)YQQModel *model;
@property(nonatomic, copy)NSString *yid;
@property(nonatomic, strong)NSNumber *like_count;
@property(nonatomic, strong)NSNumber *comment_count;
@property(nonatomic, strong)NSNumber *join_count;
@property(nonatomic, strong)NSArray *section1;
@property(nonatomic, strong)NSArray *section2;
@property(nonatomic, strong)NSArray *section3;
@property(nonatomic, strong)NSArray *contents1;
@property(nonatomic, strong)NSArray *contents2;
@property(nonatomic, strong)NSArray *contents3;


@end
