//
//  RootDrawerController.m
//  Project_weibo
//
//  Created by imac on 15/9/11.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "RootDrawerController.h"
#import "MMExampleDrawerVisualStateManager.h"
@interface RootDrawerController ()

@end

static RootDrawerController *root = nil;
@implementation RootDrawerController

+(RootDrawerController *)shareRootDrawerController{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        root = [[RootDrawerController alloc] init];
    });
    return root;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    //布局
    [self _initLayout];
    
    //设置动画
    [self setAnimation];
}

- (void)_initLayout{
    //从storyboard中获取到三个视图控制器
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    
    //中间的视图控制器
    self.centerViewController = [storyboard instantiateViewControllerWithIdentifier:@"CenterVC"];
    
    //左边的视图控制器
    self.leftDrawerViewController = [storyboard instantiateViewControllerWithIdentifier:@"LeftVC"];
    
}

- (void)setAnimation{

    //设置左右显示的宽度
    [self setMaximumLeftDrawerWidth:200.0];
    //设置阴影
    [self setShowsShadow:NO];
    //设置手势的作用区域
//    [self setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
//    [self setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    //配置动画的回调函数
    [self setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
        
        MMDrawerControllerDrawerVisualStateBlock block = [[MMExampleDrawerVisualStateManager sharedManager] drawerVisualStateBlockForDrawerSide:drawerSide];
        if (block) {
            block(drawerController, drawerSide, percentVisible);
        }
    }];
    
    
    [[MMExampleDrawerVisualStateManager sharedManager] setLeftDrawerAnimationType:MMDrawerAnimationTypeSlideAndScale];
}





@end
