//
//  ContentView.h
//  lvyou
//
//  Created by imac on 15/9/28.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZoomImageView.h"
#import "YQQModel.h"
@interface ContentView : UIView<WXLabelDelegate>
{
    WXLabel *_textLabel;
    UILabel *_requireLabel;
    UILabel *_moneyTypeLabel;
    UIImageView *img1;
    UIImageView *img2;
    
    UILabel *_imgCount;
}

@property(nonatomic, assign)BOOL isDetail;
@property(nonatomic, strong)YQQModel *model;

@end
