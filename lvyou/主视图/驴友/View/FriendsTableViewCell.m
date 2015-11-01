
//
//  FriendsTableViewCell.m
//  lvyou
//
//  Created by imac on 15/10/4.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "FriendsTableViewCell.h"
#import "ProfileViewController.h"
@implementation FriendsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        //
        [self _initView];
    }
    
    return  self;
    
}

- (void)imageClick:(UIButton *)button{
    
    ProfileViewController *profile = [[ProfileViewController alloc] init];
    profile.name = self.model.Nickname;
    profile.sex = self.model.Gender;
    profile.age = self.model.Age;
    profile.uid = self.model.Uid;
    [self.viewController.navigationController pushViewController:profile animated:YES];
}

- (void)_initView{
    
    //用户头像
    _userImage = [UIButton buttonWithType:UIButtonTypeCustom];
    [_userImage addTarget:self action:@selector(imageClick:) forControlEvents:UIControlEventTouchUpInside];
    _userImage.frame = CGRectMake(15, 15, 50, 50);
    _userImage.layer.cornerRadius = 25.0;
    _userImage.layer.masksToBounds = YES;
    _userImage.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_userImage];
    
    //用户名
    _userName = [[UILabel alloc] initWithFrame:CGRectZero];
//    _userName.backgroundColor = [UIColor grayColor];
    _userName.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:_userName];
    
    //性别和年龄
    _sexAge = [[UIView alloc] initWithFrame:CGRectZero];
    //    _sexAge.backgroundColor = [UIColor blueColor];
    [self.contentView addSubview:_sexAge];
    
    image = [[UIImageView alloc] initWithFrame:CGRectMake(5, (20 - 15)/2, 15, 15)];
    [_sexAge addSubview:image];
    label = [[UILabel alloc] initWithFrame:CGRectMake(image.right + 5, 0, 40, 20)];
    label.font = [UIFont systemFontOfSize:14];
    [_sexAge addSubview:label];
    
    //用户描述
    _maritalStatus = [[UILabel alloc] initWithFrame:CGRectZero];
    _maritalStatus.font = [UIFont systemFontOfSize:14];
    _maritalStatus.textColor = [UIColor whiteColor];
    [self.contentView addSubview:_maritalStatus];
    //想去
    _want = [[UILabel alloc] initWithFrame:CGRectZero];
    _want.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_want];
    
    //时间
    _time = [[UILabel alloc] initWithFrame:CGRectZero];
//    _time.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:_time];
    _time.font = [UIFont systemFontOfSize:14];
    _time.textColor = [UIColor darkGrayColor];
    _time.alpha = 0.8;
    
    //距离
    _distance = [[UILabel alloc] initWithFrame:CGRectZero];
//    _distance.backgroundColor = [UIColor brownColor];
    _distance.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_distance];
    _distance.textColor = [UIColor darkGrayColor];
    _distance.alpha = 0.8;
    
//    //内容
//    _content = [[ContentView alloc] initWithFrame:CGRectZero];
////    _content.backgroundColor = [UIColor cyanColor];
//    [self.contentView addSubview:_content];
    
    _contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _contentLabel.numberOfLines = 0;
    _contentLabel.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:_contentLabel];
    
    for (int i = 0; i < 3; i++) {
        ZoomImageView *imgView = [[ZoomImageView alloc] initWithFrame:CGRectMake(((KScreenWidth - 20 * 3) / 3.0 + 10) * i, 0, (KScreenWidth - 20 * 3) / 3.0, (KScreenWidth - 20 * 3) / 3.0)];
        imgView.userInteractionEnabled = YES;
        imgView.tag = 100 + i;
        [self.contentView addSubview:imgView];
    }
    
    _like = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:_like];
    _comment = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:_comment];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setModel:(YQQModel *)model{
    
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
    
    //性别和年龄
    _sexAge.frame = CGRectMake(_userName.right, _userName.top, 60, 20);
    
    _sexAge.backgroundColor = [UIColor clearColor];
    image.image = nil;
    label.text = nil;
    
    if ([self.model.Gender isEqualToString:@"女"]) {
        _sexAge.backgroundColor = [UIColor colorWithRed:218 / 255.0 green:112 / 255.0 blue:214 / 255.0 alpha:1];
        image.image = [UIImage imageNamed:@"new_woman.png"];
        
    }else if ([self.model.Gender isEqualToString:@"男"]){
        _sexAge.backgroundColor = [UIColor colorWithRed:65 / 255.0 green:105 / 255.0 blue:225 / 255.0 alpha:0.7];
        image.image = [UIImage imageNamed:@"new_man.png"];
    }
    
    label.text = [NSString stringWithFormat:@"%@岁", self.model.Age];
    
    CGRect mariRect = [self getTextSize:self.model.MaritalStatus font:[UIFont systemFontOfSize:14]];
    _maritalStatus.frame = CGRectMake(_sexAge.right + 10, _sexAge.top, mariRect.size.width, 20);
    _maritalStatus.backgroundColor = _sexAge.backgroundColor;
    
    if (self.model.WantGo.length == 0) {
        _want.hidden = YES;
    }else{
        _want.hidden = NO;
        _want.frame = CGRectMake(_userName.left, _userName.bottom, 150, 20);
        _want.textColor = [UIColor lightGrayColor];
        _want.text = [NSString stringWithFormat:@"想去 %@", self.model.WantGo];
    }
    
    _maritalStatus.text = self.model.MaritalStatus;
    
    //内容
//    _content.frame = CGRectMake(10, _userImage.bottom + 10, KScreenWidth - 20, _content.height);
//    
//    _content.model = self.model;
    
    CGRect contentRect = [self getTextSize:self.model.Content font:[UIFont systemFontOfSize:16]];
    _contentLabel.frame = CGRectMake(_userImage.left, _userImage.bottom + 10, KScreenWidth - 30, contentRect.size.height + 15);
    _contentLabel.text = self.model.Content;
    
    for (int i = 0; i < 3; i++) {
        ZoomImageView *imgView = (ZoomImageView *)[self viewWithTag:100 + i];
        if (i < self.model.picList.count) {
            imgView.hidden = NO;
            imgView.top = _contentLabel.bottom + 5;
            PicListModel *pic = self.model.picList[i];
            [imgView sd_setImageWithURL:[NSURL URLWithString:pic.Url]];
            imgView.contentMode = UIViewContentModeScaleAspectFit;
            [imgView zoomBiggerImageViewWithFullImageView:pic.Url];
        }else{
            //没有图片，隐藏对应的imgView
            //            [imgView removeFromSuperview];
            imgView.hidden = YES;
        }
        
    }
    
    
    _time.frame = CGRectMake(_userImage.left, self.contentView.bottom - 30, 80, 20);
    _time.text = self.model.Created;
    
    _distance.frame = CGRectMake(_time.right + 10, _time.top, 80, 20);
    _distance.text = [NSString stringWithFormat:@"%.2fkm", [self.model.Distance floatValue]];
    
    _like.frame =CGRectMake(self.contentView.right - 90, _want.top, 60, 30);
    [_like setImage:[UIImage imageNamed:@"dislike_icon.png"] forState:UIControlStateNormal];
    [_like setImage:[UIImage imageNamed:@"like_icon.png"] forState:UIControlStateSelected];
    
    _comment.frame = CGRectMake(self.contentView.right - 90, _time.top, 50, 20);
    _comment.backgroundColor = [UIColor darkGrayColor];
    [_comment setImage:[UIImage imageNamed:@"comment_icon.png"] forState:UIControlStateNormal];
    [_comment setTitle:@"  评论" forState:UIControlStateNormal];
    _comment.titleLabel.font = [UIFont systemFontOfSize:14];
}

- (CGRect)getTextSize:(NSString *)text font:(UIFont *)font{
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(KScreenWidth - 40, KScreenHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName] context:nil];
    
    return rect;
}

@end
