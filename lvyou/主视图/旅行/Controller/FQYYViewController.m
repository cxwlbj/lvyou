//
//  FQYYViewController.m
//  lvyou
//
//  Created by imac on 15/10/6.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "FQYYViewController.h"
#import "DateSelecterViewController.h"
@interface FQYYViewController ()

@end

@implementation FQYYViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    
    //日期选择器
    
    UIButton *selectDate = [UIButton buttonWithType:UIButtonTypeCustom];
    selectDate.frame = CGRectMake((KScreenWidth - 150) / 2, 10, 150, 30);
    selectDate.layer.cornerRadius = 10;
    selectDate.layer.masksToBounds = YES;
    selectDate.backgroundColor = [UIColor orangeColor];
    [selectDate setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [selectDate setTitle:@"选择日期" forState:UIControlStateNormal];
    [selectDate addTarget:self
                   action:@selector(selectDateButtonClick:)
         forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:selectDate];
    
    
}

- (void)selectDateButtonClick:(UIButton *)btn{
    
    DateSelecterViewController *dateSelecter = [[DateSelecterViewController alloc] init];
    [self.navigationController pushViewController:dateSelecter animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
