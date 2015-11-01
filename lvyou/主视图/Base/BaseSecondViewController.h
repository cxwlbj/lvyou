//
//  BaseSecondViewController.h
//  lvyou
//
//  Created by imac on 15/9/30.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "BaseViewController.h"
#import "AppDelegate.h"
@interface BaseSecondViewController : BaseViewController<UMSocialUIDelegate>
{

    UIView *_shareView;  //分享视图
    
    UIView *_hiddenView;  //遮罩视图
}

- (void)shareToSinaButtonClick:(UIButton *)button;
- (void)shareToQzoneButtonClick:(UIButton *)button;


@end
