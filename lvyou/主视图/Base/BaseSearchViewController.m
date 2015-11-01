//
//  BaseSearchViewController.m
//  lvyou
//
//  Created by imac on 15/10/7.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "BaseSearchViewController.h"
#import "SearchResultViewController.h"
@interface BaseSearchViewController ()

@end

@implementation BaseSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置导航栏的视图
    [self _creatNavigationView];
}

//设置导航栏的视图
- (void)_creatNavigationView{
    
    //    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width * 3 / 4, 40)];
    //    self.navigationItem.titleView = view;
    UIButton *imgView = [UIButton buttonWithType:UIButtonTypeCustom];
    imgView.frame = CGRectMake(0, 0, 40, 40);
    [imgView addTarget:self action:@selector(searchButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [imgView setImage:[UIImage imageNamed:@"searchbar_button2.png"] forState:UIControlStateNormal];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:imgView];
    self.navigationItem.leftBarButtonItem = leftItem;
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(imgView.right, 0, KScreenWidth - 60 - imgView.width, 30)];
//    _textField.leftView = imgView;
    _textField.placeholder = @"搜索目的地或人";
    _textField.borderStyle = UITextBorderStyleRoundedRect;
    _textField.clearButtonMode = UITextFieldViewModeUnlessEditing;
    self.navigationItem.titleView = _textField;
    //    [view addSubview:_textField];
    
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    back.frame = CGRectMake(0, 0, 50, 40);
    [back setTitle:@"取消" forState:UIControlStateNormal];
    [back addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    back.titleLabel.font = [UIFont systemFontOfSize:16];
    [back setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:back];
    self.navigationItem.rightBarButtonItem = rightItem;
}

#pragma mark  取消按钮
- (void)backButtonClick:(UIButton *)btn{
    
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark  搜索按钮
- (void)searchButtonClick:(UIButton *)btn{
    
    //如果输入框是空的就不执行
    
    if (_textField.text.length == 0) {
        //空的
        UILabel *label = nil;
        if (label == nil) {
            label = [[UILabel alloc] initWithFrame:CGRectMake((KScreenWidth - 150) / 2, 0, 150, 30)];
            label.text = @"请输入关键字!";
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:16];
            label.backgroundColor = [UIColor orangeColor];
        }
        label.alpha = 0;
        [self.view addSubview:label];
        [UIView animateWithDuration:0.5 animations:^{
            label.alpha = 1;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 animations:^{
                label.alpha = 0;
            }];
            [UIView setAnimationDelay:3];
            [label removeFromSuperview];
        }];
    }else{
        SearchResultViewController *searchResult = [[SearchResultViewController alloc] init];
        searchResult.status = YES;
        searchResult.keyWords = _textField.text;
        [self.navigationController pushViewController:searchResult animated:YES];
    }
}

@end
