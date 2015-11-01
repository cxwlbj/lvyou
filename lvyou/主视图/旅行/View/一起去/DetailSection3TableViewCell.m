//
//  DetailSection3TableViewCell.m
//  lvyou
//
//  Created by imac on 15/9/30.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "DetailSection3TableViewCell.h"
#import "ProfileViewController.h"
@implementation DetailSection3TableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self _initView];
    }
    return self;
}

- (void)_initView{
    
    //用户头像
    _userImage = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_userImage addTarget:self action:@selector(imageClick:) forControlEvents:UIControlEventTouchUpInside];
    _userImage.frame = CGRectMake(15, 15, 50, 50);
    _userImage.layer.cornerRadius = 25.0;
    _userImage.layer.masksToBounds = YES;
    _userImage.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_userImage];
    
    //用户名
    _userName = [[UILabel alloc] initWithFrame:CGRectZero];
    _userName.backgroundColor = [UIColor grayColor];
    _userName.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:_userName];
    
    //时间
    _time = [[UILabel alloc] initWithFrame:CGRectZero];
    _time.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:_time];
    _time.font = [UIFont systemFontOfSize:14];
    _time.textColor = [UIColor darkGrayColor];
    _time.alpha = 0.8;
    
    //内容
    _comment = [[WXLabel alloc] initWithFrame:CGRectZero];
    _comment.numberOfLines = 0;
    _comment.wxLabelDelegate = self;
    [self.contentView addSubview:_comment];

}

- (void)setModel:(ReplyModel *)model{
    
    if (_model != model) {
        _model = model;
        [self setNeedsLayout];
    }
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    //设置fram
    [_userImage sd_setImageWithURL:[NSURL URLWithString:self.model.HeadUrl] forState:UIControlStateNormal];
    
    //用户名
    CGRect rect = [self getTextSize:self.model.Nickname font:[UIFont systemFontOfSize:16]];
    _userName.frame = CGRectMake(_userImage.right + 10, _userImage.top, rect.size.width + 20, 20);
    _userName.text = self.model.Nickname;
    
    //时间
    _time.frame = CGRectMake(_userImage.right + 10, _userName.bottom + 10, 80, 20);
    _time.text = self.model.Created;
    
    //内容
    
    CGRect commentRect = [self getTextSize:self.model.Content font:[UIFont systemFontOfSize:16]];
    _comment.frame = CGRectMake(_userImage.left, _userImage.bottom + 10, KScreenWidth - 30, commentRect.size.height + 10);
    _comment.font = [UIFont systemFontOfSize:16];
    _comment.text = self.model.Content;

}

- (CGRect)getTextSize:(NSString *)text font:(UIFont *)font{
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(KScreenWidth - 60, KScreenHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName] context:nil];
    return rect;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark  点击头像的事件
- (void)imageClick:(UIButton *)button{
    
    ProfileViewController *profile = [[ProfileViewController alloc] init];
    profile.name = self.model.Nickname;
    profile.sex = self.model.Gender;
//    profile.age = self.model.Age;
    [self.viewController.navigationController pushViewController:profile animated:YES];
}


#pragma mark -WXLabelDelegate
- (NSString *)contentsOfRegexStringWithWXLabel:(WXLabel *)wxLabel
{
    //需要添加链接字符串的正则表达式：@用户、http://、#话题#
    NSString *regex1 = @"@[.\\w\\-]+";
    NSString *regex2 = @"http(s)?://([A-Za-z0-9._-]+(/)?)*";
    NSString *regex3 = @"#.+#";
    NSString *regex = [NSString stringWithFormat:@"(%@)|(%@)|(%@)",regex1,regex2,regex3];
    return regex;
}

//设置当前链接文本的颜色
- (UIColor *)linkColorWithWXLabel:(WXLabel *)wxLabel
{
    return [UIColor orangeColor];
}

@end
