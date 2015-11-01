//
//  TogetherView.h
//  lvyou
//
//  Created by imac on 15/9/28.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CycleScrollView.h"
#import "SectionCollectionView.h"
#import "YQQTableViewCell.h"
#import "DetailViewController.h"
@interface TogetherView : UIView<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_tableView;
    UIView *_headerView;
    CycleScrollView *_cycleScrollView;
    UIPageControl *_pageControl;
    
    SectionCollectionView *collectionView;
}

@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSArray *itemsData;
@property(nonatomic, strong)NSArray *bannerData;
@property(nonatomic, strong)NSArray *topicData;

@end
