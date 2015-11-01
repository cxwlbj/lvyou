//
//  ProfileViewController.h
//  lvyou
//
//  Created by imac on 15/10/5.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "BaseViewController.h"
#import "YQQModel.h"
@interface ProfileViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_tableView;
    ZoomImageView *_userImage;
    UILabel *_userName;
    UIView *_sexAge;   //用户性别和年龄
    UIImageView *image;
    UILabel *label;
    NSArray *_section3;
}
@property(nonatomic, copy)NSString *name;
@property(nonatomic, copy)NSString *sex;
@property(nonatomic, copy)NSNumber *age;
@property(nonatomic, copy)NSString *imgUrl;
@property(nonatomic, copy)NSString *yid;
@property(nonatomic, copy)NSString *uid;
@property(nonatomic, strong)ProfileModel *model;

@end
