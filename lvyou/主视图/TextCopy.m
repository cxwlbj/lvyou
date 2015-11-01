//
//  TextCopy.m
//  lvyou
//
//  Created by imac on 15/10/7.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "TextCopy.h"
static TextCopy *textCopy = nil;
@implementation TextCopy

+ (TextCopy *)textShare{
    
    if (textCopy == nil) {
        
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            textCopy = [[TextCopy alloc] init];
        });
    }
    
    return textCopy;
}

@end
