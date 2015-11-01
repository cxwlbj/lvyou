//
//  HomeViewController.m
//  lvyou
//
//  Created by imac on 15/9/28.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "HomeViewController.h"
#import "FQYYViewController.h"
#import "SearchViewController.h"
@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)_loadData:(NSMutableDictionary *)params{
    
    [DataService requestWithURL:yiqiqu_URL
                         params:params
                     httpMethod:@"GET"
                    finishBlock:^(AFHTTPRequestOperation *operation, id result) {
                        
                        NSMutableArray *mArr = [NSMutableArray array];

                        //一起去的数据
                        NSArray *items = result[@"Items"];
                        for (NSDictionary *dic in items) {
                            YQQModel *yiqiquModel = [[YQQModel alloc] initContentWithDic:dic];
                            [mArr addObject:yiqiquModel];
                        }
                        self.itemsData = mArr;
                        _yiqiqu.itemsData = self.itemsData;
                        mArr = nil;
                        
                        //头视图上的数据
                        NSArray *banner = result[@"Banner"];
                        for (NSDictionary *dic in banner) {
                            BannerModel *bannerModel = [[BannerModel alloc] initContentWithDic:dic];
                            [mArr addObject:bannerModel];
                        }
                        self.bannerData = mArr;
                        _yiqiqu.bannerData = self.bannerData;
                        mArr = nil;
                        
                        NSArray *topic = result[@"Topic"];
                        for (NSDictionary *dic in topic) {
                            TopicModel *topicModel = [[TopicModel alloc] initContentWithDic:dic];
                            [mArr addObject:topicModel];
                        }
//                        self.topicData = mArr;
//                        _yiqiqu.topicData = self.topicData;
                        mArr = nil;
                        
                    }
                   failuerBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        
                   }];
    
    NSDictionary *result = [DataService getDictionaryFromJsonData:homeJson];
    NSMutableArray *mArr3 = [NSMutableArray array];
    NSArray *topic = result[@"Topic"];
    for (NSDictionary *dic in topic) {
        TopicModel *topicModel = [[TopicModel alloc] initContentWithDic:dic];
        [mArr3 addObject:topicModel];
    }
    self.topicData = mArr3;
    _yiqiqu.topicData = mArr3;
    
}

- (void)_loadJson{
    NSDictionary *result = [DataService getDictionaryFromJsonData:self.str];
    
    NSMutableArray *mArr = [NSMutableArray array];
    
    //一起去的数据
    NSArray *items = result[@"Items"];
    for (NSDictionary *dic in items) {
        YQQModel *yiqiquModel = [[YQQModel alloc] initContentWithDic:dic];
        [mArr addObject:yiqiquModel];
    }
    [self.itemsData addObject:mArr];
    _yiqiqu.itemsData = mArr;
    NSMutableArray *mArr2 = [NSMutableArray array];
    //头视图上的数据
    NSArray *banner = result[@"Banner"];
    for (NSDictionary *dic in banner) {
        BannerModel *bannerModel = [[BannerModel alloc] initContentWithDic:dic];
        [mArr2 addObject:bannerModel];
    }
    self.bannerData = mArr2;
    _yiqiqu.bannerData = mArr2;
    
    NSMutableArray *mArr3 = [NSMutableArray array];
    NSArray *topic = result[@"Topic"];
    for (NSDictionary *dic in topic) {
        TopicModel *topicModel = [[TopicModel alloc] initContentWithDic:dic];
        [mArr3 addObject:topicModel];
    }
    self.topicData = mArr3;
    _yiqiqu.topicData = mArr3;
    
    [_yiqiqu.tableView reloadData];
    
//    NSLog(@"%ld", _yiqiqu.topicData.count);
}

- (void)_refreshData{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:@(0) forKey:@"page"];
    [DataService requestWithURL:yiqiqu_URL
                         params:params
                     httpMethod:@"GET"
                    finishBlock:^(AFHTTPRequestOperation *operation, id result) {
                        
                        NSMutableArray *mArr = [NSMutableArray array];
                        //一起去的数据
                        id items = result[@"Items"];
                        if ([items isKindOfClass:[NSNull class]]) {
                            [_yiqiqu.tableView headerEndRefreshing];
                            return;
                        }
                        for (NSDictionary *dic in items) {
                            YQQModel *yiqiquModel = [[YQQModel alloc] initContentWithDic:dic];
                            [mArr addObject:yiqiquModel];
                        }
                        
                        if (mArr != nil) {
                            
                            NSRange range = {0, mArr.count};
                            NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
                            [self.itemsData insertObjects:mArr atIndexes:indexSet];
                        }
                        _yiqiqu.itemsData = self.itemsData;
                        mArr = nil;
                        [_yiqiqu.tableView headerEndRefreshing];
                    }
                   failuerBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
                       
                       [_yiqiqu.tableView headerEndRefreshing];

                   }];
}

- (void)_loadMoreData{
    
    static NSInteger page = 2;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:@(page) forKey:@"page"];
    [DataService requestWithURL:yiqiqu_URL
                         params:params
                     httpMethod:@"GET"
                    finishBlock:^(AFHTTPRequestOperation *operation, id result) {
                        
                        NSMutableArray *mArr = [NSMutableArray array];
                        //一起去的数据
                        id items = result[@"Items"];
                        if ([items isKindOfClass:[NSNull class]]) {
                            [_yiqiqu.tableView footerEndRefreshing];
                            return;
                        }
                        for (NSDictionary *dic in items) {
                            YQQModel *yiqiquModel = [[YQQModel alloc] initContentWithDic:dic];
                            [mArr addObject:yiqiquModel];
                        }
                        
                        if (mArr != nil) {
                            
    
                            [self.itemsData addObjectsFromArray:mArr];
                        }
                        _yiqiqu.itemsData = self.itemsData;
                        mArr = nil;
                        [_yiqiqu.tableView reloadData];
                        [_yiqiqu.tableView footerEndRefreshing];
                        page ++;
                    }
                   failuerBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
                       
                       [_yiqiqu.tableView footerEndRefreshing];
                       
                   }];
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"refresh" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //添加两个视图
    [self _initView];
    
    //自定义导航栏
    [self _customNavigationBar];
    
    
    //请求网络
    [self _loadData:nil];
    
    self.str = homeJson;
    //请求本地json
//    [self _loadJson];
    
    //监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_refreshData) name:@"refresh" object:nil];
    
    //加载更多
    [_yiqiqu.tableView addFooterWithTarget:self action:@selector(_loadMoreData)];
}

- (void)_initView{

    _yiqiqu = [[TogetherView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, self.view.height - 64)];
    _yiqiqu.backgroundColor = [UIColor redColor];
    _yiqiqu.hidden = NO;
    [self.view addSubview:_yiqiqu];
    
    _lvyoutuan = [[OrganizationView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, self.view.height - 49 - 65)];
    _lvyoutuan.backgroundColor = [UIColor blueColor];
    _lvyoutuan.hidden = YES;
    [self.view addSubview:_lvyoutuan];
}

#pragma mark  设置导航栏
//设置导航栏
- (void)_customNavigationBar{
    
    //设置标题视图
    [self _initTitleView];
    
    //设置导航栏左边的视图
    [self _initLeftView];
 
    //设置导航栏右侧的视图
    [self _initRightView];
    
    //点击筛选弹出的视图
    [self sequenceView];
    
    //发起约游
    [self _addButton:@"发起约游"];
    
}


//设置标题视图
- (void)_initTitleView{
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 64)];
//    titleView.backgroundColor = [UIColor grayColor];
//    titleView.userInteractionEnabled = YES;
    
    
    NSArray *title = @[@"一起去", @"驴游团"];
    
    for (int i = 0; i < title.count; i ++) {
        UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        titleButton.frame = CGRectMake(titleView.width / title.count * i, 0, titleView.width / title.count, 64);
        titleButton.tag = 100 + i;
        [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        titleButton.titleLabel.font = [UIFont systemFontOfSize:18];
        [titleButton setTitle:title[i] forState:UIControlStateNormal];
        [titleButton setTitleColor:[UIColor colorWithWhite:0 alpha:0.7] forState:UIControlStateNormal];
        [titleView addSubview:titleButton];
        
        if (i == 0) {
            [titleButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            lastSelectedButton = titleButton.tag;
            
            _selectedView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 53, 75, 2)];
            _selectedView.backgroundColor = [UIColor orangeColor];
            [titleButton addSubview:_selectedView];
            
            sequence.hidden = NO;
        }
    }
    
    self.navigationItem.titleView = titleView;
   
}

- (void)titleButtonClick:(UIButton *)button{
    
    [UIView animateWithDuration:0.3 animations:^{
        UIButton *titleButton = (UIButton *)[self.navigationItem.titleView viewWithTag:lastSelectedButton];
        titleButton.titleLabel.textColor = [UIColor colorWithWhite:0 alpha:0.7];
        [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        _selectedView.left = button.left;
    }];
    lastSelectedButton = button.tag;
    
    if (button.tag == 100) {
        
        [UIView animateWithDuration:0.5 animations:^{
            sequence.hidden = NO;
            _yiqiqu.hidden = NO;
            _lvyoutuan.hidden = YES;
        }];
    }else{
        //驴游团
        //发起一个通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"LYTOpen" object:nil userInfo:nil];
        [UIView animateWithDuration:0.5 animations:^{
            sequence.hidden = YES;
            _yiqiqu.hidden = YES;
            _lvyoutuan.hidden = NO;
        }];
        
    }
    
    
}


//设置导航栏左边的视图
- (void)_initLeftView{
    
    UIButton *search = [UIButton buttonWithType:UIButtonTypeCustom];
    [search setImage:[UIImage imageNamed:@"searchbar_button2.png"] forState:UIControlStateNormal];
    [search addTarget:self action:@selector(searchClick:) forControlEvents:UIControlEventTouchUpInside];
    search.frame = CGRectMake(0, 0, 50, 50);
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:search];
    self.navigationItem.leftBarButtonItem = leftItem;
    
}

#pragma mark   查询按钮点击事件
- (void)searchClick:(UIButton *)button{

    SearchViewController *searchVC = [[SearchViewController alloc] init];
    [self.navigationController pushViewController:searchVC animated:YES];
}

//设置右边的视图
- (void)_initRightView{
    
    sequence = [UIButton buttonWithType:UIButtonTypeCustom];
    sequence.frame = CGRectMake(0, 20, 60, 44);
    [sequence addTarget:self action:@selector(sequenceClick:) forControlEvents:UIControlEventTouchUpInside];
    [sequence setTitle:@"筛选" forState:UIControlStateNormal];
    sequence.titleLabel.font = [UIFont systemFontOfSize:15];
    [sequence setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:sequence];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)sequenceClick:(UIButton *)button{
    
    button.selected = !button.selected;
    
    if (!button.selected) {
        [UIView animateWithDuration:0.5 animations:^{
            sequenceView.alpha = 0;
        }];
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            sequenceView.alpha = 1;
        }];
    }
    
}

//点击筛选弹出的视图
- (void)sequenceView{
    sequenceView = [[UIImageView alloc] initWithFrame:CGRectMake(KScreenWidth - 105, -8, 90, 150)];
    sequenceView.alpha = 0;
    sequenceView.userInteractionEnabled = YES;
    UIImage *image = [UIImage imageNamed:@"chose_Item.png"];
    UIGraphicsBeginImageContext(CGSizeMake(90, 150));
    [image drawInRect:CGRectMake(0, 0, 90, 150)];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [image stretchableImageWithLeftCapWidth:50 topCapHeight:50];
    sequenceView.image = image;
    UIView *view = self.view.subviews.lastObject;
    [self.view insertSubview:sequenceView aboveSubview:view];
    
    NSArray *buttonTitle = @[@"默认排序", @"按距离", @"按人气"];
    for (int i = 0; i < buttonTitle.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 200 + i;
        button.frame = CGRectMake(10, (sequenceView.height - 20) / 3 * i + 20, sequenceView.width - 20, (sequenceView.height - 70) / 3);
        [button setTitleColor:[UIColor colorWithWhite:0 alpha:0.5] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor whiteColor];
        [button setTitle:buttonTitle[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(sequenceButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [sequenceView addSubview:button];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, button.bottom + 10, sequenceView.width - 20, 0.5)];
        imageView.alpha = 0.6;
        imageView.backgroundColor = [UIColor lightGrayColor];
        [sequenceView addSubview:imageView];
        if (i == 2) {
            [imageView removeFromSuperview];
        }
    }
}

- (void)sequenceButtonClick:(UIButton *)button{
    
     NSString *title = button.titleLabel.text;
    if (button.tag != 200) {
        [sequence setTitle:title forState:UIControlStateNormal];
    }
    [UIView animateWithDuration:0.5 animations:^{
        sequenceView.alpha = 0;
        sequence.selected = !sequence.selected;
    }];
    
    NSInteger tag = button.tag;
    
    switch (tag) {
        case 200:
        {
//            self.str = homeJson;
            [self _loadData:nil];
            break;
        }
        case 201:
        {
            
//            self.str = homeForDis;
            NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:@"dis" forKey:@"filter"];
            [self _loadData:params];
            
            break;
        }
        case 202:
        {
//            self.str = homeForHot;
            NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:@"hot" forKey:@"filter"];
            [self _loadData:params];
            
            break;
        }
        default:
            break;
    }
    
//    [self _loadJson];

}


- (void)myButtonClick:(UIButton *)btn{
    [super myButtonClick:btn];
    
    FQYYViewController *fqyyVC = [[FQYYViewController alloc] init];
    [self.navigationController pushViewController:fqyyVC animated:YES];
}

@end
