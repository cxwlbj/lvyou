//
//  TabBarButton.m
//  lvyou
//
//  Created by imac on 15/9/28.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "TabBarButton.h"

@implementation TabBarButton

- (instancetype)initWithFrame:(CGRect)frame imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImage title:(NSString *)title{
    
    self = [super initWithFrame:frame];
    if (self) {
        //
        [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:selectedImage] forState:UIControlStateSelected];
        [self setTitle:title forState:UIControlStateNormal];
        [self setTitle:title forState:UIControlStateSelected];
        //设置字体颜色
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
//        [self setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        
        //设置偏移量
        [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -15, -20, 0)];
        [self setImageEdgeInsets:UIEdgeInsetsMake(0, 25, 25, 0)];
        
        //设置标题的对齐方式
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    
    return self;
    
}






@end
