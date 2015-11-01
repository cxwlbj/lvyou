//
//  Section1TableViewCell.m
//  lvyou
//
//  Created by imac on 15/10/5.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "Section1TableViewCell.h"

@implementation Section1TableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self _initView];
    }
    return self;
}


- (void)_initView{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumInteritemSpacing = 10;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.contentView addSubview:_collectionView];
    
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"collection"];
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collection" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor colorWithRed:arc4random() % 10 * 0.1 green:arc4random() % 10 * 0.1 blue:arc4random() % 10 * 0.1 alpha:1];
    return cell;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.frame = CGRectMake(0, 0, KScreenWidth, self.contentView.height);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(self.contentView.height, self.contentView.height);
}
@end
