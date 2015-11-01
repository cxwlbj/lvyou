//
//  SectionCollectionView.h
//  lvyou
//
//  Created by imac on 15/9/28.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SectionCollectionViewCell.h"
#import "SpecialViewController.h"
@interface SectionCollectionView : UICollectionView<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property(nonatomic, strong)NSArray *topicData;


@end
