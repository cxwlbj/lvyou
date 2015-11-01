//
//  ShareEditViewController.m
//  lvyou
//
//  Created by imac on 15/10/9.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "ShareEditViewController.h"

@interface ShareEditViewController ()

@end

@implementation ShareEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"图文分享";
    
    //设置导航栏右侧按钮
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 60, 40);
    [rightButton setTitle:@"分享" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    if ([self.share isEqualToString:@"sina"]) {
        [rightButton addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    }
    if ([self.share isEqualToString:@"Qzone"]) {
        [rightButton addTarget:self action:@selector(shareToQzone:) forControlEvents:UIControlEventTouchUpInside];
    }
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
    textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - 64)];
    textView.font = [UIFont systemFontOfSize:18];
    
    textView.text = [textView.text stringByAppendingFormat:@"%@去%@，不跟团，自由行，有人一起吗？%@", self.time,self.where,_shareUrl];
    [self.view addSubview:textView];
    
    
    
}

- (void)share:(UIButton *)button{
    
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToSina] content:textView.text image:nil location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *shareResponse){
        if (shareResponse.responseCode == UMSResponseCodeSuccess) {
            NSLog(@"分享成功！");
            
            UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:nil message:@"分享成功" preferredStyle:UIAlertControllerStyleAlert];
            
            [self presentViewController:alertCtrl animated:YES completion:^{
                [alertCtrl performSelector:@selector(dismissViewControllerAnimated:completion:) withObject:nil afterDelay:1];
                
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }
    }];
}

- (void)shareToQzone:(UIButton *)btn{
    
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQzone] content:textView.text image:nil location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess) {
            NSLog(@"分享成功！");
            
            UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:nil message:@"分享成功" preferredStyle:UIAlertControllerStyleAlert];
            
            [self presentViewController:alertCtrl animated:YES completion:^{
                [alertCtrl performSelector:@selector(dismissViewControllerAnimated:completion:) withObject:nil afterDelay:1];
                
                [self.navigationController popViewControllerAnimated:YES];
            }];

        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
