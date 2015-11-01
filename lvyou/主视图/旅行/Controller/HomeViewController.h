//
//  HomeViewController.h
//  lvyou
//
//  Created by imac on 15/9/28.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "BaseViewController.h"
#import "TogetherView.h"
#import "OrganizationView.h"
#import "YQQModel.h"
#import "BannerModel.h"
#import "TopicModel.h"
@interface HomeViewController : BaseViewController
{
//    UIImageView *_selectedView;  //导航栏选中的按钮下的视图
//    NSInteger lastSelectedButton; //上次选中的按钮
//    UIButton *sequence; //导航栏右侧的视图
    
    UIImageView *sequenceView;  //筛选视图
    
    TogetherView *_yiqiqu;
    OrganizationView *_lvyoutuan;
}

@property(nonatomic, strong)NSMutableArray *itemsData;
@property(nonatomic, strong)NSArray *bannerData;
@property(nonatomic, strong)NSArray *topicData;

@property(nonatomic, copy)NSString *str;

@end
