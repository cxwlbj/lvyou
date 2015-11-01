//
//  UIView+ViewController.m
//  8-18-04
//
//  Created by imac on 15/8/18.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "UIView+ViewController.h"

@implementation UIView (ViewController)

- (UIViewController *)viewController{

    UIResponder *next = self.nextResponder;
    
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = next.nextResponder;
    } while (next);
    return nil;
}

@end
