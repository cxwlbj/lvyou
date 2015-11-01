//
//  SearchViewController.m
//  lvyou
//
//  Created by imac on 15/10/7.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchCollectionViewCell.h"
#import "SearchResultViewController.h"
@interface SearchViewController ()

@end

@implementation SearchViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

//请求网络
- (void)_loadSearchData{
    
    [DataService requestWithURL:search_url params:nil httpMethod:@"GET" finishBlock:^(AFHTTPRequestOperation *operation, id result) {
        self.searchData = result[@"Items"];
        [_collectionView reloadData];
    } failuerBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //构建collectionView
    [self _initCollectionView];
    
    //请求网络
    [self _loadSearchData];
    
}


- (void)_initCollectionView{
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(100, 40);
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.minimumLineSpacing = 10;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(20, 20, KScreenWidth - 40, KScreenHeight) collectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_collectionView];
    
    [_collectionView registerClass:[SearchCollectionViewCell class] forCellWithReuseIdentifier:@"searchCollection"];
    
    //设置组的头视图
    //先设置组的头视图大小
    flowLayout.headerReferenceSize = CGSizeMake(_collectionView.width, 30);

    //注册组的头视图
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SearchSectionView"];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.searchData.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SearchCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"searchCollection" forIndexPath:indexPath];
    
    cell.title = self.searchData[indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    _textField.text = self.searchData[indexPath.row];
    SearchResultViewController *searchResult = [[SearchResultViewController alloc] init];
    searchResult.status = NO;
    searchResult.keyWords = self.searchData[indexPath.row];
    [self.navigationController pushViewController:searchResult animated:YES];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SearchSectionView" forIndexPath:indexPath];
    if (kind == UICollectionElementKindSectionHeader) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, reusableView.width, 30)];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:14];
        label.text = @"— 热门搜索 —";
        [reusableView addSubview:label];
    }
    
    return reusableView;
}



@end
