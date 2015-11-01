//
//  SectionCollectionViewCell.m
//  lvyou
//
//  Created by imac on 15/9/29.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "SectionCollectionViewCell.h"

@implementation SectionCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //
        imgView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
        imgView.layer.cornerRadius = 5.0;
        imgView.layer.masksToBounds = YES;
        [self.contentView addSubview:imgView];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake((self.contentView.width - 50) / 2, (self.contentView.height - 30) / 2, 50, 30)];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont boldSystemFontOfSize:20];
        label.textColor = [UIColor orangeColor];
        label.backgroundColor = [UIColor clearColor];
//        [self.contentView insertSubview:label aboveSubview:imgView];
    }
    return self;
}

- (void)setModel:(TopicModel *)model{
    
    if (_model != model) {
        _model = model;
        
        [self setNeedsLayout];
    }
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    imgView.frame = self.contentView.bounds;
    label.frame = CGRectMake((self.contentView.width - 50) / 2, (self.contentView.height - 30) / 2, 50, 30);
    [imgView sd_setImageWithURL:[NSURL URLWithString:self.model.PicUrl]];
    label.text = self.model.Title;
    
}

@end
