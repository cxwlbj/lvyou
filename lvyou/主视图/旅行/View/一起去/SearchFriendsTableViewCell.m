//
//  SearchFriendsTableViewCell.m
//  lvyou
//
//  Created by imac on 15/10/7.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "SearchFriendsTableViewCell.h"
#import "ProfileViewController.h"
@implementation SearchFriendsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self _initSubViews];
    }
    return self;
}


- (void)_initSubViews{
    
    //用户头像
    _userImage = [UIButton buttonWithType:UIButtonTypeCustom];
    [_userImage addTarget:self action:@selector(imageClick:) forControlEvents:UIControlEventTouchUpInside];
    _userImage.frame = CGRectMake(15, 15, 50, 50);
    _userImage.layer.cornerRadius = 25.0;
    _userImage.layer.masksToBounds = YES;
    [_userImage setImage:[UIImage imageNamed:@"registerAvarta.png"] forState:UIControlStateNormal];
    [self.contentView addSubview:_userImage];
    
    //用户名
    _userName = [[UILabel alloc] initWithFrame:CGRectZero];
//    _userName.backgroundColor = [UIColor grayColor];
    _userName.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:_userName];
}


- (void)layoutSubviews{
    [super layoutSubviews];
    //设置fram
    [_userImage sd_setImageWithURL:[NSURL URLWithString:self.model.HeadUrl] forState:UIControlStateNormal];
    
    //用户名
    _userName.frame = CGRectMake(_userImage.right + 10, _userImage.top, KScreenWidth - 25 - _userImage.width, self.contentView.height);
    _userName.text = self.model.Nickname;

}

#pragma mark  点击头像的事件
- (void)imageClick:(UIButton *)button{
    
    ProfileViewController *profile = [[ProfileViewController alloc] init];
    profile.name = self.model.Nickname;
    profile.sex = self.model.Gender;
    //    profile.age = self.model.Age;
    [self.viewController.navigationController pushViewController:profile animated:YES];
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    //拿到画布
    CGContextRef ref = UIGraphicsGetCurrentContext();
    //拿到画笔,设置画笔的起点
    CGContextMoveToPoint(ref, 0, self.contentView.height);
    //画一条线
    CGContextAddLineToPoint(ref, self.contentView.width, self.contentView.height);
    //设置画笔颜色
    CGContextSetStrokeColorWithColor(ref, [UIColor lightGrayColor].CGColor);
    //设置画笔的宽度
    CGContextSetLineWidth(ref, 0.5);
    //画到View上
    CGContextDrawPath(ref, kCGPathStroke);

}


@end
