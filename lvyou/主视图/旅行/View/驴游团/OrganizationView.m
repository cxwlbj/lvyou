//
//  OrganizationView.m
//  lvyou
//
//  Created by imac on 15/9/28.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "OrganizationView.h"

@implementation OrganizationView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //
        _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self addSubview:_tableView];
        
        [_tableView addHeaderWithTarget:self action:@selector(_loadMore)];
        
        //监听通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_loadData) name:@"LYTOpen" object:nil];
    }
    return self;
}

- (void)_loadData{
    
    //请求网络数据
    [DataService requestWithURL:lvyoutuan_url params:nil httpMethod:@"GET" finishBlock:^(AFHTTPRequestOperation *operation, id result) {
        NSMutableArray *mArr = [NSMutableArray array];
        
        NSArray *items = result[@"Items"];
        for (NSDictionary *dic in items) {
            LYTModel *lytModel = [[LYTModel alloc] initContentWithDic:dic];
            [mArr addObject:lytModel];
        }
        
        self.data = mArr;
        [_tableView reloadData];
        
    } failuerBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
    }];
    
    //请求本机数据
//    [self _loadJson];
}


- (void)_loadJson{
    
    NSDictionary *result = [DataService getDictionaryFromJsonData:lvyoutuan];
    
    NSMutableArray *mArr = [NSMutableArray array];
    
    //一起去的数据
    NSArray *items = result[@"Items"];
    for (NSDictionary *dic in items) {
        LYTModel *lytModel = [[LYTModel alloc] initContentWithDic:dic];
        [mArr addObject:lytModel];
    }
    
    self.data = mArr;
    [_tableView reloadData];
}

//加载更多
- (void)_loadMore{
    
    static NSInteger page = 0;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:@(page) forKey:@"page"];
    [DataService requestWithURL:lvyoutuan_url params:params httpMethod:@"GET" finishBlock:^(AFHTTPRequestOperation *operation, id result) {
        
        NSMutableArray *mArr = [NSMutableArray array];
        
        id items = result[@"Items"];
        if ([items isKindOfClass:[NSNull class]]) {
            
            [_tableView headerEndRefreshing];
            return;
        }
        
        for (NSDictionary *dic in items) {
            LYTModel *lytModel = [[LYTModel alloc] initContentWithDic:dic];
            [mArr addObject:lytModel];
        }
        
        self.data = [self.data arrayByAddingObjectsFromArray:mArr];
        
        [_tableView reloadData];
        
        [_tableView headerEndRefreshing];
        
    } failuerBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        [_tableView headerEndRefreshing];
    }];
}

#pragma mark  UITableViewDataSource,UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identi = @"lvyoutuanCell";
    LYTTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identi];
    if (cell == nil) {
        cell = [[LYTTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identi];
    }
    cell.model = self.data[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LYTModel *model = self.data[indexPath.row];
    CGRect rect = [self getTextSize:model.Remark font:[UIFont systemFontOfSize:16]];
    
    return 370 + rect.size.height;
}


- (CGRect)getTextSize:(NSString *)text font:(UIFont *)font{
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(KScreenWidth - 30, KScreenHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName] context:nil];
    
    return rect;
}


//单元格点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LYTModel *model = self.data[indexPath.row];
    WebViewController *webVC = [[WebViewController alloc] init];
    webVC.title = model.Title;
    webVC.aid = model.Aid;
    [self.viewController.navigationController pushViewController:webVC animated:YES];
    
}

@end
