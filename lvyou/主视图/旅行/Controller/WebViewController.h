//
//  WebViewController.h
//  lvyou
//
//  Created by imac on 15/9/30.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "BaseSecondViewController.h"

@interface WebViewController : BaseSecondViewController
{
    UIWebView *_webView;
}

@property(nonatomic, copy)NSString *aid;

@end
