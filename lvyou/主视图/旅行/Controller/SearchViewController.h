//
//  SearchViewController.h
//  lvyou
//
//  Created by imac on 15/10/7.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "BaseSearchViewController.h"

@interface SearchViewController : BaseSearchViewController<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
    UICollectionView *_collectionView;
}

@property(nonatomic, strong)NSArray *searchData;
@end
