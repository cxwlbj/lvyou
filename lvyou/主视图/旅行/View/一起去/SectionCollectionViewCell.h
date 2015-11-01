//
//  SectionCollectionViewCell.h
//  lvyou
//
//  Created by imac on 15/9/29.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopicModel.h"

@interface SectionCollectionViewCell : UICollectionViewCell

{
    UIImageView *imgView;
    UILabel *label;
}

@property(nonatomic, strong)TopicModel *model;

@end
