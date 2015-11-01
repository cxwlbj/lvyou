//
//  SearchCollectionViewCell.m
//  lvyou
//
//  Created by imac on 15/10/7.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "SearchCollectionViewCell.h"

@implementation SearchCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //
        _label = [[UILabel alloc] initWithFrame:CGRectZero];
        _label.font = [UIFont systemFontOfSize:15];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.textColor = [UIColor colorWithRed:10 / 255.0 green:70 / 255.0 blue:1 alpha:1];
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderWidth = 1;
        self.layer.cornerRadius = 4;
        [self.contentView addSubview:_label];
    }
    return self;
}

-(void)setTitle:(NSString *)title{
    if (_title != title) {
        _title = title;
        [self setNeedsLayout];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _label.frame = self.contentView.bounds;
    _label.text = self.title;
}

@end
