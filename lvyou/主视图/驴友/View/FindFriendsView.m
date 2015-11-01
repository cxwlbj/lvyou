//
//  FindFriendsView.m
//  lvyou
//
//  Created by imac on 15/10/5.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "FindFriendsView.h"

@implementation FindFriendsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor orangeColor];
        _bgImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _bgImageView.contentMode = UIViewContentModeScaleAspectFit;
        _bgImageView.image = [UIImage imageNamed:@"nolikeAl.png"];
        [self addSubview:_bgImageView];
    }
    return self;
}

@end
