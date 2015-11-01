//
//  WebViewController.m
//  lvyou
//
//  Created by imac on 15/9/30.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "WebViewController.h"
#import "ShareEditViewController.h"
@interface WebViewController ()

@end

@implementation WebViewController

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
    // http://m.miaotu.com/App32/detail/?aid=000030
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - 64)];
    [self.view addSubview:_webView];
    
    //构造URL
    NSString *url = [NSString stringWithFormat:@"http://m.miaotu.com/App32/detail/?aid=%@", self.aid];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    
    [_webView request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)shareToSinaButtonClick:(UIButton *)button{
    
    [super shareToSinaButtonClick:button];
    
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:user_message];
    if (dic.count == 0) {
        
        
        [self _login];
        
    }else{
        
        //获取微博用户名、uid、token等
        //进入你的分享内容编辑页面
        ShareEditViewController *shareEdit = [[ShareEditViewController alloc] init];
        shareEdit.shareUrl = [NSString stringWithFormat:@"http://m.miaotu.com/ShareLine32/custom/?aid=%@", self.aid];
        [self.navigationController pushViewController:shareEdit animated:YES];
        
    }
}


@end
