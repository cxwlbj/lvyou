//
//  MainTabBarController.m
//  lvyou
//
//  Created by imac on 15/9/26.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "MainTabBarController.h"
#import "TabBarButton.h"
@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImageView *splashView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
    //将图片添加到UIImageView对象中
    splashView.image=[UIImage imageNamed:@"Default"];
    [self.view addSubview:splashView];
    [self.view bringSubviewToFront:splashView];
    
    [UIView animateWithDuration:3 animations:^{
        splashView.alpha = 0.1;
    } completion:^(BOOL finished) {
        [splashView removeFromSuperview];
    }];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //移除系统的tabBar
    [self _removeSystemTabBar];

    
    if (_selectedView == nil) {
        //构建自定义的tabBar
        [self _creatCustomButton];
    }
}

//移除系统的标签控制器
- (void)_removeSystemTabBar{
    
    //取到子视图
    NSArray *subViews = self.tabBar.subviews;
    //循环遍历子视图，取出子视图上的标项
    for (UIView *view in subViews) {
        //通过反射机制，构建UITabBarButton的对象，这个UITabBarButton是一个私有的类，因此要用反射机制构建出来
        Class tabBarButton = NSClassFromString(@"UITabBarButton");
        //如果是UITabBarButton这个类，就把它从父视图上边移除
        if ([view isKindOfClass:[tabBarButton class]]) {
            [view removeFromSuperview];
        }
    }
}


//构建自定义的标签控制器作为系统的标签控制器
- (void)_creatCustomButton{
    
    self.tabBar.backgroundImage = [UIImage imageNamed:@"rectFrame@3x.png"];
    
    NSArray *imageName = @[@"publishAddress.png", @"publishAddress.png", @"publishAddress.png"];
    NSArray *selectedImageName = @[@"publishAddress.png", @"publishAddress.png", @"publishAddress.png"];
    NSArray *title = @[@"驴行", @"驴友", @"消息"];
    
    _selectedView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"selectedRect@2x.png"]];
    [self.tabBar addSubview:_selectedView];
    _selectedView.frame = CGRectMake(0, 0, 49, 49);
    _selectedView.layer.cornerRadius = 15;
    
    for (int i = 0; i < imageName.count; i++) {
        TabBarButton *button = [[TabBarButton alloc] initWithFrame:CGRectMake((float)KScreenWidth / imageName.count * i, 0, (float)KScreenWidth / imageName.count, 49) imageName:imageName[i] selectedImageName:selectedImageName[i] title:title[i]];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 1000 + i;
//        button.backgroundColor = [UIColor colorWithRed:arc4random() % 10 * 0.1 green:arc4random() % 10 * 0.1 blue:arc4random() % 10 * 0.1 alpha:1];
        [self.tabBar addSubview:button];
        
        if (i == 0) {
            _selectedView.center = button.center;
        }
    }
    
}

- (void)buttonClick:(UIButton *)button{
    
    [UIView animateWithDuration:0.3 animations:^{
        button.selected = !button.selected;
        self.selectedViewController = self.viewControllers[button.tag - 1000];
        _selectedView.center = button.center;
    }];
}

@end
