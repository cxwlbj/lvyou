//
//  ZoomImageView.m
//  Project_weibo
//
//  Created by imac on 15/9/19.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "ZoomImageView.h"

@implementation ZoomImageView

- (void)zoomBiggerImageViewWithFullImageView:(NSString *)urlStr{

    //开启点击事件
    self.userInteractionEnabled = YES;
    
    if (urlStr != nil) {
        _urlStr = urlStr;
    }
    
    //添加手势
    _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapZoomScaleBigger:)];
    [self addGestureRecognizer:_tap];
    
}

- (void)_initViews{
    
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _scrollView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.bounces = NO;
        //添加点击缩小的手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapZoomScaleSmaller:)];
        [_scrollView addGestureRecognizer:tap];
    }
    
    [self.window addSubview:_scrollView];
    
    if (_fullImageView == nil) {
        //创建放大的视图
        _fullImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _fullImageView.image = self.image;
        _fullImageView.contentMode = self.contentMode;
        [_scrollView addSubview:_fullImageView];
    }
    
    if (_progressView == nil) {
        _progressView = [[DDProgressView alloc] initWithFrame:CGRectMake(10, (KScreenHeight - 5) / 2, KScreenWidth - 20, 5)];
        //设置样式
        _progressView.innerColor = [UIColor redColor];
        _progressView.outerColor = [UIColor blueColor];
        _progressView.emptyColor = [UIColor greenColor];
    }
    _progressView.hidden = YES;

    [self.window addSubview:_progressView];
    
}

//点击放大的手势
- (void)tapZoomScaleBigger:(UITapGestureRecognizer *)tap{

    self.states = YES;
    if (self.image == nil) {
        return;
    }
    
    //初始化视图
    [self _initViews];
    
    //给子视图_fullImageView设置frame
    //获取该视图相对于另一个视图的frame
     _fullImageView.frame = [self convertRect:self.bounds toView:self.window];
    
    
   
    //实现放大的动画
    [UIView animateWithDuration:0.5
                     animations:^{
                         //发起通知
                         [[NSNotificationCenter defaultCenter] postNotificationName:@"imageScaleBigger" object:nil userInfo:nil];
                         
                         CGFloat height = KScreenWidth / (self.image.size.width / self.image.size.height);
                         //设置放大后的视图的frame
                         _fullImageView.frame = CGRectMake(0, 0, KScreenWidth, MAX(height, KScreenHeight));
                         //设置scrollView的内容尺寸
                         _scrollView.contentSize = CGSizeMake(KScreenWidth, height);
                     }
                     completion:^(BOOL finished) {
                         
                         if (_urlStr == nil) {
                             return;
                         }
                         
                         //加载高清图片
                         
                         [_fullImageView sd_setImageWithURL:[NSURL URLWithString:_urlStr]
                                           placeholderImage:self.image
                                                    options:SDWebImageRetryFailed
                                                   progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                                       //显示加载进度
                                                       _progressView.hidden = NO;
                                                       _progressView.progress = (CGFloat)receivedSize / expectedSize;
                                                   }
                                                  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                                      //加载完成后
                                                      _progressView.hidden = YES;
                                                      [_progressView removeFromSuperview];
                                                      _progressView = nil;
                                                  }];
                         
                     }];
    
    
}



//点击缩小
- (void)tapZoomScaleSmaller:(UITapGestureRecognizer *)tap{

    self.states = NO;
    
    
    _progressView.hidden = YES;
    [_progressView removeFromSuperview];
    [UIView animateWithDuration:0.5
                     animations:^{
                         //发起通知
                         [[NSNotificationCenter defaultCenter] postNotificationName:@"imageScaleSmaller" object:nil userInfo:nil];
                         

                         _fullImageView.frame = [self convertRect:self.bounds toView:self.window];
                         _scrollView.backgroundColor = [UIColor clearColor];
                     }
                     completion:^(BOOL finished) {
                         
                         //移除放大的图片视图
                         [_fullImageView removeFromSuperview];
                         _fullImageView = nil;
                         
                         //移除scrollView
                         [_scrollView removeFromSuperview];
                         _scrollView = nil;
                        
                     }];
}


@end
