//
//  DateSelecterTableViewCell.m
//  lvyou
//
//  Created by imac on 15/10/8.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "DateSelecterTableViewCell.h"

@implementation DateSelecterTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _monthLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, KScreenWidth - 20, 30)];
        _monthLabel.backgroundColor = [UIColor orangeColor];
        [self.contentView addSubview:_monthLabel];
        
        [self _initCollectionView];
        
    }
    
    return self;
}

//创建collectionView
- (void)_initCollectionView{
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    [self.contentView addSubview:_collectionView];
    
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"DateSelecterCollection"];
    
    flowLayout.headerReferenceSize = CGSizeMake(_collectionView.width, 30);
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CollectionHeader"];
}


- (void)layoutSubviews{
    [super layoutSubviews];
    _collectionView.frame = CGRectMake(10, 30, KScreenWidth - 20, self.contentView.height - 30);
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
}



#pragma mark  UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 35;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DateSelecterCollection" forIndexPath:indexPath];
    
//    cell.backgroundColor = [UIColor colorWithRed:arc4random() % 10 * 0.1 green:arc4random() % 10 * 0.1 blue:arc4random() % 10 * 0.1 alpha:arc4random() % 10 * 0.1];
    
    UILabel *label = [[UILabel alloc] initWithFrame:cell.bounds];
    cell.layer.borderColor = [UIColor brownColor].CGColor;
    
    label.textAlignment = NSTextAlignmentCenter;
    [cell.contentView addSubview:label];
    
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(collectionView.width / 7.0, (collectionView.height - 30) / 5.0);
}

//设置collectionView组的头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
     UICollectionReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CollectionHeader" forIndexPath:indexPath];
    if (kind == UICollectionElementKindSectionHeader) {
    }
    
    reusableView.backgroundColor = [UIColor lightGrayColor];
    
    return reusableView;
}






@end
