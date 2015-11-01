//
//  SectionCollectionView.m
//  lvyou
//
//  Created by imac on 15/9/28.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "SectionCollectionView.h"

static NSString *identifier = @"collectionCell";
@implementation SectionCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        //..
        self.delegate = self;
        self.dataSource = self;
        
        self.backgroundColor = [UIColor clearColor];
        [self registerClass:[SectionCollectionViewCell class] forCellWithReuseIdentifier:identifier];
        
    }
    return self;
}



#pragma mark  UICollectionViewDelegateFlowLayout
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.topicData.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(90, 70);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SectionCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
//    cell.backgroundColor = [UIColor colorWithRed:arc4random() % 10 * 0.1 green:arc4random() % 10 * 0.1 blue:arc4random() % 10 * 0.1 alpha:1];
    
    cell.model = self.topicData[indexPath.row];
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SpecialViewController *special = [[SpecialViewController alloc] init];
    TopicModel *model = self.topicData[indexPath.row];
    special.tid = model.Tid;
    special.title = @"专题";
    [self.viewController.navigationController pushViewController:special animated:YES];
}

- (void)setTopicData:(NSArray *)topicData{
    
    if (_topicData != topicData) {
        _topicData = topicData;
        NSLog(@"SELF %ld", self.topicData.count);

        [self reloadData];
    }
}



@end
