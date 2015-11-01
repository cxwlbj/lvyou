//
//  BaseViewController.h
//  lvyou
//
//  Created by imac on 15/9/28.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
{
    UIImageView *_selectedView;  //导航栏选中的按钮下的视图
    NSInteger lastSelectedButton; //上次选中的按钮
    UIButton *sequence; //导航栏右侧的视图
    
    UIButton *_myButton;
}

- (void)_login; //登录

- (void)_logout;  //登出

//判断有没有登录
- (BOOL)isLogin;

- (void)_addButton:(NSString *)btnTitle;
- (void)myButtonClick:(UIButton *)btn;

@end
