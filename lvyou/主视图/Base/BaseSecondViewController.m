//
//  BaseSecondViewController.m
//  lvyou
//
//  Created by imac on 15/9/30.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "BaseSecondViewController.h"
@interface BaseSecondViewController ()

@end

@implementation BaseSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self _initRightItem];
    [self _shareView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)_initRightItem{
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 0, 70, 20)];
    [rightButton addTarget:self action:@selector(shareButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setImage:[UIImage imageNamed:@"more.png"] forState:UIControlStateNormal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    self.navigationItem.rightBarButtonItem = rightItem;
}

#pragma mark  分享视图
- (void)_shareView{
    
    _shareView = [[UIView alloc] initWithFrame:CGRectMake(0, KScreenHeight, KScreenWidth, 200)];
    _shareView.backgroundColor = [UIColor lightGrayColor];
    
     AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    [delegate.window addSubview:_shareView];
    
    //分享按钮
    
    UIButton *shareToSinaButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shareToSinaButton.frame = CGRectMake(10, 10, 50, 50);
    [shareToSinaButton addTarget:self action:@selector(shareToSinaButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [shareToSinaButton setImage:[UIImage imageNamed:@"shareSelectSina.png"] forState:UIControlStateNormal];
    [_shareView addSubview:shareToSinaButton];
    
    UIButton *shareToQzoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shareToQzoneButton.frame = CGRectMake(shareToSinaButton.right + 10, 10, 50, 50);
    [shareToQzoneButton addTarget:self action:@selector(shareToQzoneButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [shareToQzoneButton setImage:[UIImage imageNamed:@"shareSelectQQZone.png"] forState:UIControlStateNormal];
    [_shareView addSubview:shareToQzoneButton];
}


//导航栏的上button点击事件
- (void)shareButtonClick:(UIButton *)button{
    
    button.selected = !button.selected;
    
    //创建一个遮罩视图
    if (_hiddenView == nil) {
        _hiddenView = [[UIView alloc] initWithFrame:CGRectMake(0, - 64, KScreenWidth, KScreenHeight)];
        _hiddenView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [delegate.window insertSubview:_hiddenView belowSubview:_shareView];
        _hiddenView.hidden = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        _hiddenView.userInteractionEnabled = YES;
        [_hiddenView addGestureRecognizer:tap];
    }
    if (button.selected) {
        [UIView animateWithDuration:0.5 animations:^{
            _hiddenView.hidden = NO;
            _shareView.bottom = KScreenHeight;
        }];
    }else{
    }
    
}

- (void)tapAction:(UITapGestureRecognizer *)tap{
    
    [UIView animateWithDuration:0.5 animations:^{
        _hiddenView.hidden = YES;
        _shareView.top = KScreenHeight;
    }];
    [_hiddenView removeFromSuperview];
    _hiddenView = nil;
    
}


- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [UIView animateWithDuration:0.5 animations:^{
        _hiddenView.hidden = YES;
        _shareView.top = KScreenHeight;
    }];
    [_hiddenView removeFromSuperview];
    _hiddenView = nil;
    
}


- (void)shareToSinaButtonClick:(UIButton *)button{
    
  //  //第一种使用第三方提供的分享视图
//    //注意：分享到微信好友、微信朋友圈、微信收藏、QQ空间、QQ好友、来往好友、来往朋友圈、易信好友、易信朋友圈、Facebook、Twitter、Instagram等平台需要参考各自的集成方法
//    //如果需要分享回调，请将delegate对象设置self，并实现下面的回调方法
////    [UMSocialConfig setSupportedInterfaceOrientations:UIInterfaceOrientationMaskLandscape];
//    
//    [UMSocialSnsService presentSnsIconSheetView:self
//                                         appKey:UMAppKey
//                                      shareText:@"友盟社会化分享让您快速实现分享等社会化功能，http://umeng.com/social"
//                                     shareImage:[UIImage imageNamed:@"icon"]
//                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,nil]
//                                       delegate:self];
    
//    //第二种自定义分享视图，跳转到第三方提供的分享编辑视图
//    //注意：分享到微信好友、微信朋友圈、微信收藏、QQ空间、QQ好友、来往好友、来往朋友圈、易信好友、易信朋友圈、Facebook、Twitter、Instagram等平台需要参考各自的集成方法
//    [[UMSocialControllerService defaultControllerService] setShareText:@"分享内嵌文字" shareImage:[UIImage imageNamed:@"icon"] socialUIDelegate:self];        //设置分享内容和回调对象
//    [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina].snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
//    
    
 ////   没有分享编辑视图
//    //注意：分享到微信好友、微信朋友圈、微信收藏、QQ空间、QQ好友、来往好友、来往朋友圈、易信好友、易信朋友圈、Facebook、Twitter、Instagram等平台需要参考各自的集成方法
//    
//    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToSina] content:@"分享内嵌文字" image:nil location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
//        if (response.responseCode == UMSResponseCodeSuccess) {
//            NSLog(@"分享成功！");
//        }
//    }];
    
    ////自定义的分享内容编辑视图
    //判断是否授权
    //注意：分享到微信好友、微信朋友圈、微信收藏、QQ空间、QQ好友、来往好友、来往朋友圈、易信好友、易信朋友圈、Facebook、Twitter、Instagram等平台需要参考各自的集成方法
    
}

- (void)shareToQzoneButtonClick:(UIButton *)button{
    
}


@end
