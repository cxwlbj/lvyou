//
//  BaseViewController.m
//  lvyou
//
//  Created by imac on 15/9/28.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "BaseViewController.h"
#import "LoginViewController.h"
@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"comment_frame1.png"]];
    self.navigationController.navigationBar.translucent = NO;
}

//实现登录
- (void)_login{
    
    LoginViewController *loginVC = [[[NSBundle mainBundle] loadNibNamed:@"LoginView" owner:nil options:nil] lastObject];
    [self presentViewController:loginVC animated:YES completion:nil];
    
}

- (void)_logout{
    
    NSMutableDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:user_message];
    if (dic != nil) {
        [dic removeAllObjects];

    }
    [[NSUserDefaults standardUserDefaults] setObject:dic forKey:user_message];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

//约游
- (void)_addButton:(NSString *)btnTitle{
    
    UIButton *_button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.alpha = 0.5;
    _button.frame = CGRectMake(self.view.right - 45, self.view.height - 100 - 64, 40, 40);
    _button.backgroundColor = [UIColor orangeColor];
    [_button setTitle:@"游" forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(yueyouButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    _button.layer.cornerRadius = 20;
    _button.layer.masksToBounds = YES;
    [self.view addSubview:_button];
    
    _myButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _myButton.frame = CGRectMake(self.view.right - 100, KScreenHeight, 100, 30);
    _myButton.layer.cornerRadius = 15;
    [_myButton setTitle:btnTitle forState:UIControlStateNormal];
    _myButton.hidden = YES;
    _myButton.backgroundColor = [UIColor orangeColor];
    [_myButton addTarget:self action:@selector(myButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_myButton];
}

- (void)yueyouButtonClick:(UIButton *)btn{
    if (btn.selected) {
        [UIView animateWithDuration:0.5 animations:^{
            _myButton.top = KScreenHeight;
            _myButton.hidden = YES;
        }];
    }else{
        _myButton.hidden = NO;
        [UIView animateWithDuration:0.5 animations:^{
            _myButton.top = btn.top  - 40;
        }];
    }
    
    btn.selected = !btn.selected;
}

- (void)myButtonClick:(UIButton *)btn{

}


- (BOOL)isLogin{
    
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:user_message];
    if (dic.count == 0) {
        
        return NO;
    }
    
    return YES;
}



@end
