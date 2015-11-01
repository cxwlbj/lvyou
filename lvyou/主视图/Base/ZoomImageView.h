//
//  ZoomImageView.h
//  Project_weibo
//
//  Created by imac on 15/9/19.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDProgressView.h"
@interface ZoomImageView : UIImageView

{

    UIScrollView *_scrollView;   //放在window上的视图
    
    UIImageView *_fullImageView;   //放大显示的图片
    
    UITapGestureRecognizer *_tap;  //点击手势
    
    NSString *_urlStr;   //放大后的图片地址
    
    DDProgressView *_progressView;  //加载进度条

}

@property(nonatomic, assign)BOOL states;

- (void)zoomBiggerImageViewWithFullImageView:(NSString *)urlStr;



@end
