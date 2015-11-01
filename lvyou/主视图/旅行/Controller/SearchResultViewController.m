//
//  SearchResultViewController.m
//  lvyou
//
//  Created by imac on 15/10/7.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "SearchResultViewController.h"
#import "YQQTableViewCell.h"
#import "YQQModel.h"
#import "DetailViewController.h"
@interface SearchResultViewController ()

@end

@implementation SearchResultViewController

- (void)loadSearchResultData{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.keyWords, @"keywords",@(1),@"page",@(50), @"num", nil];
    
    [DataService requestWithURL:searchResult_url params:params httpMethod:@"GET" finishBlock:^(AFHTTPRequestOperation *operation, id result) {
       
        id items = result[@"Items"];
        if ([items isKindOfClass:[NSNull class]]) {
            
            return;
        }
        NSMutableArray *mArr = [NSMutableArray array];
        for (NSDictionary *dic in items) {
            YQQModel *model = [[YQQModel alloc] initContentWithDic:dic];
            [mArr addObject:model];
        }
        self.resultData = mArr;
        [_tableView reloadData];
        
    } failuerBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _textField.text = self.keyWords;
    [self _initSearchResultTableView];
    self.navigationItem.leftBarButtonItem.customView.userInteractionEnabled = NO;
    [_textField setEnabled:NO];
    UIButton *button = (UIButton *)self.navigationItem.rightBarButtonItem.customView;
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [self loadSearchResultData];
    
    if (self.status) {
        [self _initView];
        _tableView.top = 30;
    }
}

- (void)_initSearchResultTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - 64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.resultData.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *searchResultID = @"searchResultID";
    YQQTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:searchResultID];
    if (cell == nil) {
        cell = [[YQQTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:searchResultID];
    }
    
    cell.model = self.resultData[indexPath.row];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 0, 30)];
    label.text = @"一起去";
    label.backgroundColor = [UIColor orangeColor];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:16];
    return label;
}

//计算单元格高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YQQModel *model = self.resultData[indexPath.row];
    CGRect textRect = [self getTextSize:model.Remark font:[UIFont systemFontOfSize:14]];
    CGRect requestRect = [self getTextSize:model.Require font:[UIFont systemFontOfSize:12]];
    
//    if (model.picList.count == 0) {
//        
//        return ( 20 + textRect.size.height + requestRect.size.height + 10 + ((KScreenWidth - 20 * 3) / 3.0));
//        
//    }
    return (90 + 80 + textRect.size.height + requestRect.size.height + 10 + ((KScreenWidth - 20 * 3) / 3.0));
}

- (CGRect)getTextSize:(NSString *)text font:(UIFont *)font{
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(KScreenWidth - 40, KScreenHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName] context:nil];
    
    return rect;
}

#pragma mark  单元格点击的方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    YQQModel *model = self.resultData[indexPath.row];
    //    detailVC.model = model;
    detailVC.yid =  model.Yid;
    detailVC.like_count = model.YueyouLikeCount;
    detailVC.comment_count = model.YueyouReplyCount;
    detailVC.join_count = model.YueyouJoinCount;
    [self.navigationController pushViewController:detailVC animated:YES];
    
}



#pragma mark  创建选择的视图
- (void)_initView{
    _selectView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 50)];
    //    _selectView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_selectView];
    //两个按钮
    
    _yqqButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _yqqButton.frame = CGRectMake(0, 0, KScreenWidth / 2, 30);
    _yqqButton.backgroundColor = [UIColor orangeColor];
    [_yqqButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _yqqButton.tag = 2015;
    [_yqqButton setTitle:@"找线路" forState:UIControlStateNormal];
    [_yqqButton addTarget:self action:@selector(yqqButton:) forControlEvents:UIControlEventTouchUpInside];
    [_selectView addSubview:_yqqButton];
    
    _lytButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _lytButton.frame = CGRectMake(_yqqButton.right, 0, KScreenWidth / 2, 30);
    _lytButton.tag = 2016;
    [_lytButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    _lytButton.backgroundColor = [UIColor whiteColor];
    [_lytButton setTitle:@"找人" forState:UIControlStateNormal];
    [_lytButton addTarget:self action:@selector(lytButton:) forControlEvents:UIControlEventTouchUpInside];
    [_selectView addSubview:_lytButton];
}

- (void)yqqButton:(UIButton *)button{
    
    
    [UIView animateWithDuration:0.5 animations:^{
      
        _lytButton.backgroundColor = [UIColor whiteColor];
        [_lytButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor orangeColor];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        _searchFriends.alpha = 0;
        _tableView.alpha = 1;
    } completion:^(BOOL finished) {
        
        _searchFriends = nil;
        [_searchFriends removeFromSuperview];
    }];
}

- (void)lytButton:(UIButton *)button{
    
    [UIView animateWithDuration:0.5 animations:^{
        _yqqButton.backgroundColor = [UIColor whiteColor];
        [_yqqButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor orangeColor];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        if (_searchFriends == nil) {
            [self _searchFriendsTableView];
        }
        _searchFriends.alpha = 1;
        _tableView.alpha = 0;
    }];
    
    [self _requestSearchFriends];
}


//构建找人的视图
- (void)_searchFriendsTableView{
    
    _searchFriends = [[SearchFriendsTableView alloc] initWithFrame:CGRectMake(0, 30, KScreenWidth, KScreenHeight - 64 - 30) style:UITableViewStylePlain];
    [self.view addSubview:_searchFriends];
}

- (void)_requestSearchFriends{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:self.keyWords forKey:@"keywords"];
    
    [DataService requestWithURL:searchFriends_url params:params httpMethod:@"GET" finishBlock:^(AFHTTPRequestOperation *operation, id result) {
        
        id items = result[@"Items"];
        if ([items isKindOfClass:[NSNull class]]) {
            return;
        }
        NSMutableArray *mArr = [NSMutableArray array];
        for (NSDictionary *dic in items) {
            ReplyModel *model = [[ReplyModel alloc] initContentWithDic:dic];
            [mArr addObject:model];
        }
        self.friendsData = mArr;
        _searchFriends.data = self.friendsData;
        [_searchFriends reloadData];
    } failuerBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}


@end
