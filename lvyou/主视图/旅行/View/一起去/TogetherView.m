//
//  TogetherView.m
//  lvyou
//
//  Created by imac on 15/9/28.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "TogetherView.h"
@implementation TogetherView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //...
        [self _initTableView];
        [self _creatHeaderView];
        
    }
    return self;
}

- (void)_initTableView{
    _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_tableView];
    
    [self _refresh];
}

#pragma mark  下拉刷新  上拉加载更多
//下拉刷新
- (void)_refresh{
    
    [_tableView addHeaderWithCallback:^{
        //发出一个通知，让控制器执行刷新功能
        [[NSNotificationCenter defaultCenter] postNotificationName:@"refresh" object:nil];
    }];
}

#pragma mark  UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.itemsData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"yiqiquCell";
    YQQTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[YQQTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.model = self.itemsData[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YQQModel *model = self.itemsData[indexPath.row];
    
    CGRect textRect = [self getTextSize:model.Remark font:[UIFont systemFontOfSize:14]];
    CGRect requestRect = [self getTextSize:model.Require font:[UIFont systemFontOfSize:12]];
    
    return (80 + 10 + 80 + textRect.size.height + requestRect.size.height + 10 + ((KScreenWidth - 20 * 3) / 3.0));
//    return 400;
}

//设置tableView的头视图
- (void)_creatHeaderView{
    
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 210)];
    _tableView.tableHeaderView = _headerView;
    //滑动视图和pageControl
    [self _scrollView];
}

- (void)_scrollView{
    _cycleScrollView = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 200)];
    NSMutableArray *imgArr = [NSMutableArray array];
    NSArray *imageArr = @[@"everyday.jpg", @"home_headBg.png"];
    //添加UIControl
    for (int i = 0 ; i < imageArr.count; i ++) {
        //滑动视图的内容视图
        UIControl *control = [[UIControl alloc] initWithFrame:CGRectMake(_cycleScrollView.width * i, 0, _cycleScrollView.width, _cycleScrollView.height)];
        control.tag = 400 + i;
        [_cycleScrollView addSubview:control];
    }
    for (int i = 0; i < imageArr.count; i++) {
        UIImage *image = [UIImage imageNamed:imageArr[i]];
        [imgArr addObject:image];
    }
    _cycleScrollView.imgs = imgArr;
    [_headerView addSubview:_cycleScrollView];
    
    //创建滑动进度条UIPageControl
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, _cycleScrollView.bottom - 20, KScreenWidth, 20)];
    _pageControl.backgroundColor = [UIColor clearColor];

    _pageControl.pageIndicatorTintColor = [UIColor blackColor];
    _pageControl.enabled = NO;
    _pageControl.currentPageIndicatorTintColor = [UIColor lightGrayColor];
    _pageControl.numberOfPages = 2;
    [_headerView addSubview:_pageControl];
    
//    接收滑动视图下标变动的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(selectedIndexChange:)
                                                 name:@"selectedIndex"
                                               object:nil];
    
}

//滑动进度条下标变动响应
- (void)selectedIndexChange:(NSNotification *)nsno
{
    _pageControl.currentPage = [nsno.object integerValue];
}

//设置组的头部视图
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 70;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 70)];
    view.backgroundColor = [UIColor whiteColor];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 10;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    collectionView = [[SectionCollectionView alloc] initWithFrame:CGRectMake(0, 10, KScreenWidth, 70)collectionViewLayout:layout];
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.bounces = NO;
    collectionView.topicData = self.topicData;

    [view addSubview:collectionView];
    
    return view;
}


#pragma mark  单元格点击的方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    YQQModel *model = self.itemsData[indexPath.row];
    detailVC.yid =  model.Yid;
    detailVC.like_count = model.YueyouLikeCount;
    detailVC.comment_count = model.YueyouReplyCount;
    detailVC.join_count = model.YueyouJoinCount;
    [self.viewController.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark   set方法
- (void)setItemsData:(NSArray *)itemsData{
    
    if (_itemsData != itemsData) {
        _itemsData = itemsData;
        [_tableView reloadData];
    }
}

- (void)setBannerData:(NSArray *)bannerData{
    
    if (_bannerData != bannerData) {
        _bannerData = bannerData;
        [_tableView reloadData];
//        NSLog(@"self.bannerData.count %ld", self.bannerData.count);
    }
}

- (void)setTopicData:(NSArray *)topicData{
    
    if (_topicData != topicData) {
        _topicData = topicData;
        
//        NSLog(@"collectionView %ld", self.topicData.count);
    }
}


//计算大小
- (CGRect)getTextSize:(NSString *)text font:(UIFont *)font{
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(KScreenWidth - 40, KScreenHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName] context:nil];
    
    return rect;
}

@end
