//
//  SpecialViewController.m
//  lvyou
//
//  Created by imac on 15/10/4.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "SpecialViewController.h"

@interface SpecialViewController ()

@end

@implementation SpecialViewController

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
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - 64)];
    
    [self.view addSubview:_webView];
    
    //构造URL
    NSString *url = [NSString stringWithFormat:@"http://m.miaotu.com/App32/theme/?tid=%@", self.tid];
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

@end
