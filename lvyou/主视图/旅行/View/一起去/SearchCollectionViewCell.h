//
//  SearchCollectionViewCell.h
//  lvyou
//
//  Created by imac on 15/10/7.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchCollectionViewCell : UICollectionViewCell
{
    UILabel *_label;
}

@property(nonatomic, copy)NSString *title;

@end
