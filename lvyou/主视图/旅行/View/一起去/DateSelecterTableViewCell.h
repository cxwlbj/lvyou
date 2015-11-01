//
//  DateSelecterTableViewCell.h
//  lvyou
//
//  Created by imac on 15/10/8.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DateSelecterTableViewCell : UITableViewCell<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
    UILabel *_monthLabel;
    UICollectionView *_collectionView;
}


@end
