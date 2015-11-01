//
//  ChatViewController.m
//  lvyou
//
//  Created by imac on 15/10/7.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "ChatViewController.h"
#import "ProfileViewController.h"
@interface ChatViewController ()

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置导航栏右边的按钮
    [self _initRightButtonItem];
    
}

- (void)_initRightButtonItem{
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setTitle:@"资料" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    rightButton.frame = CGRectMake(0, 0, 60, 40);
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    self.navigationItem.rightBarButtonItem = item;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)rightButtonClick:(UIButton *)btn{
    
    ProfileViewController *profile = [[ProfileViewController alloc] init];
    profile.yid = self.yid;
    profile.uid = self.uid;
    [self.navigationController pushViewController:profile animated:YES];
}

@end
