//
//  LYTTableViewCell.m
//  lvyou
//
//  Created by imac on 15/9/30.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "LYTTableViewCell.h"

@implementation LYTTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //
        [self _initView];
    }
    return self;
}

- (void)_initView{
    
    _picImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_picImageView];
    
    _locationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_picImageView addSubview:_locationButton];
    
    _likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_picImageView addSubview:_likeButton];
    
    _priceLable = [[UILabel alloc] initWithFrame:CGRectZero];
    [_picImageView addSubview:_priceLable];
    
    _sourceLable = [[UILabel alloc] initWithFrame:CGRectZero];
    [_picImageView addSubview:_sourceLable];
    
    _topicLable = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_topicLable];
    
    _timeLable  = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_timeLable];
    
    _durationLable = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_durationLable];
    
    _remarkLable = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_remarkLable];
    
    //喜欢
    _like = [UIButton buttonWithType:UIButtonTypeCustom];
    [_like setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    _like.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_like];
    
    
    //评论
    _comment = [UIButton buttonWithType:UIButtonTypeCustom];
    
//    [_comment setImage:[UIImage imageNamed:@"comment.png"] forState:UIControlStateNormal];
    [_comment setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
//    [_comment setTitle:@"评论" forState:UIControlStateNormal];
    _comment.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_comment];
    view1 = [[UIView alloc] initWithFrame:CGRectZero];
    view1.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:view1];
    view2 = [[UIView alloc] initWithFrame:CGRectZero];
    view2.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:view2];
    //加入
    _join = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_join setTitle:@"加入" forState:UIControlStateNormal];
    [_join setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    _join.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_join];
    
    line = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"index_bottom_line.png"]];
    [self.contentView addSubview:line];
    
    line1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"index_bottom_line.png"]];
    [self.contentView addSubview:line1];
}

- (void)setModel:(LYTModel *)model{
    if (_model != model) {
        _model = model;
        
        [self setNeedsLayout];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    //图片
    _picImageView.frame = CGRectMake(0, 0, KScreenWidth, 250);
    [_picImageView sd_setImageWithURL:[NSURL URLWithString:self.model.PicUrl]];
    
    //喜欢
    _likeButton.frame = CGRectMake(_picImageView.right - 90, 5, 80, 50);
    [_likeButton setImage:[UIImage imageNamed:@"noliked.png"] forState:UIControlStateNormal];
    [_likeButton setImage:[UIImage imageNamed:@"liked.png"] forState:UIControlStateSelected];
    [_likeButton setTitle:[NSString stringWithFormat:@"%@", self.model.ActivityLikeCount] forState:UIControlStateNormal];
    [_likeButton setTitle:[NSString stringWithFormat:@"%@", self.model.ActivityLikeCount] forState:UIControlStateSelected];
//    [_likeButton setImageEdgeInsets:UIEdgeInsetsMake(-20, 10, 0, 0)];
//    [_likeButton setImageEdgeInsets:UIEdgeInsetsMake(20, -33, 0, 0)];
    
    //位置
    _locationButton.frame  = CGRectMake(10, _picImageView.bottom - 50, 120, 40);
    [_locationButton setImage:[UIImage imageNamed:@"publishAddress.png"] forState:UIControlStateNormal];
    [_locationButton setTitle:self.model.Destination forState:UIControlStateNormal];
    _locationButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_locationButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    //价格
    _priceLable.frame  = CGRectMake(_picImageView.right - 90, _picImageView.bottom - 80, 80, 40);
    _priceLable.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    _priceLable.text = [NSString stringWithFormat:@"￥%@", self.model.MtPrice];
    _priceLable.textColor = [UIColor whiteColor];
    _priceLable.font = [UIFont systemFontOfSize:20];
    
    //来源
    _sourceLable.frame = CGRectMake(KScreenWidth - 160, _priceLable.bottom, 150, 40);
    _sourceLable.textAlignment = NSTextAlignmentRight;
    _sourceLable.text = [NSString stringWithFormat:@"From %@", self.model.Nickname];
    _sourceLable.font = [UIFont systemFontOfSize:12];
    _sourceLable.textColor = [UIColor whiteColor];
    
    _topicLable.frame = CGRectMake(30, _picImageView.bottom + 5, KScreenWidth, 30);
    _topicLable.textColor = [UIColor orangeColor];
    _topicLable.text = self.model.Title;
    
    _timeLable.frame = CGRectMake(_topicLable.left, _topicLable.bottom + 5, 150, 20);
    _timeLable.font = [UIFont systemFontOfSize:14];
    _timeLable.textColor = [UIColor blueColor];
    _timeLable.text = [NSString stringWithFormat:@"%@-%@", self.model.StartDate, self.model.EndDate];
    _durationLable.frame = CGRectMake(_timeLable.right + 5, _timeLable.top, 100, 20);
    _durationLable.font = [UIFont systemFontOfSize:14];
    _durationLable.textColor = [UIColor blueColor];
    _durationLable.text = self.model.Duration;
    
    CGRect rect = [self getTextSize:self.model.Remark font:[UIFont systemFontOfSize:16]];
    _remarkLable.frame = CGRectMake(_topicLable.left, _timeLable.bottom + 5, KScreenWidth - 30, rect.size.height + 5);
    _remarkLable.numberOfLines = 0;
    _remarkLable.font = [UIFont systemFontOfSize:16];
    
    _remarkLable.text = self.model.Remark;
    
    _like.frame = CGRectMake(0, self.contentView.bottom - 40, self.contentView.width / 3.0, 40);
    [_like setTitle:[NSString stringWithFormat:@"分享 %@", self.model.ShareCount] forState:UIControlStateNormal];
    view1.frame = CGRectMake(_like.right, self.contentView.bottom - 35, 1, 30);

    _comment.frame = CGRectMake(_like.right + 1, self.contentView.bottom - 40, self.contentView.width / 3.0, 40);
    _comment.titleLabel.textColor = [UIColor darkGrayColor];
    [_comment setTitle:[NSString stringWithFormat:@"评论 %@", self.model.ActivityReplyCount] forState:UIControlStateNormal];
    view2.frame = CGRectMake(_comment.right, self.contentView.bottom - 35, 1, 30);
    
    
    _join.frame = CGRectMake(_comment.right + 1, self.contentView.bottom - 40, self.contentView.width / 3.0, 40);
    _join.titleLabel.textColor = [UIColor darkGrayColor];
    
    [_join setTitle:[NSString stringWithFormat:@"报名 %@", self.model.ActivityJoinCount] forState:UIControlStateNormal];
    line.frame = CGRectMake(0, _like.top - 1, self.contentView.width, 1);
    line1.frame = CGRectMake(0, self.contentView.bottom - 1, self.contentView.width, 1);
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (CGRect)getTextSize:(NSString *)text font:(UIFont *)font{
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(KScreenWidth - 30, KScreenHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName] context:nil];
    
    return rect;
}

@end
