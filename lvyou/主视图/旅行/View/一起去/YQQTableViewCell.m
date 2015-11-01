//
//  YQQTableViewCell.m
//  lvyou
//
//  Created by imac on 15/9/28.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "YQQTableViewCell.h"
#import "ProfileViewController.h"
#import "CommentTableViewController.h"
#import "HomeViewController.h"
@implementation YQQTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryNone;
        [self _initView];
    }
    return self;
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
    
    //内容
    _content = [[ContentView alloc] initWithFrame:CGRectZero];
//    _content.backgroundColor = [UIColor cyanColor];
    [self.contentView addSubview:_content];
    
    //喜欢
    _like = [UIButton buttonWithType:UIButtonTypeCustom];
    [_like addTarget:self action:@selector(likeButton:) forControlEvents:UIControlEventTouchUpInside];
    [_like setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    _like.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_like];
    
    
    //评论
    _comment = [UIButton buttonWithType:UIButtonTypeCustom];
    
//    [_comment setImage:[UIImage imageNamed:@"comment.png"] forState:UIControlStateNormal];
    [_comment setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    _comment.titleLabel.font = [UIFont systemFontOfSize:14];
    [_comment addTarget:self action:@selector(commentButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_comment];
    view1 = [[UIView alloc] initWithFrame:CGRectZero];
    view1.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:view1];
    view2 = [[UIView alloc] initWithFrame:CGRectZero];
    view2.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:view2];
    
    
    //加入
    _join = [UIButton buttonWithType:UIButtonTypeCustom];
    [_join addTarget:self action:@selector(joinButton:) forControlEvents:UIControlEventTouchUpInside];
    [_join setTitle:@"加入" forState:UIControlStateNormal];
    [_join setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    _join.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_join];
    
    line = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"index_bottom_line.png"]];
    [self.contentView addSubview:line];

    line1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"index_bottom_line.png"]];
    [self.contentView addSubview:line1];

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
    
    _time.frame = CGRectMake(_userImage.right + 10, _userName.bottom + 10, 80, 20);
    _time.text = self.model.Created;
    
    _distance.frame = CGRectMake(_time.right + 10, _userName.bottom + 10, 80, 20);
    _distance.text = [NSString stringWithFormat:@"%.2fkm", [self.model.Distance floatValue]];
    
    //内容
    _content.frame = CGRectMake(15, _userImage.bottom + 10, KScreenWidth - 30, 200);
    _content.model = self.model;

    _like.frame = CGRectMake(0, self.contentView.bottom - 40, self.contentView.width / 3.0, 40);
    view1.frame = CGRectMake(_like.right, self.contentView.bottom - 35, 1, 30);
    _like.titleLabel.textColor = [UIColor darkGrayColor];
    
    
    if ([self.model.IsLike boolValue] == false) {
//        NSLog(@"self.model.IsLike  %@", self.model.IsLike);
        [_like setImage:[UIImage imageNamed:@"yqq_unlike.png"] forState:UIControlStateNormal];
    }else if([self.model.IsLike boolValue] == true){
//         NSLog(@"self.model.IsLike  %@", self.model.IsLike);
        [_like setImage:[UIImage imageNamed:@"yqq_like.png"] forState:UIControlStateNormal];
    }
    if ([self.model.YueyouLikeCount integerValue] > 0) {
        [_like setTitle:[NSString stringWithFormat:@"%@", self.model.YueyouLikeCount] forState:UIControlStateNormal];
    }
    
    
    _comment.frame = CGRectMake(_like.right + 1, self.contentView.bottom - 40, self.contentView.width / 3.0, 40);
    _comment.titleLabel.textColor = [UIColor darkGrayColor];
//    if ([self.model.YueyouReplyCount integerValue] > 0) {
        [_comment setTitle:[NSString stringWithFormat:@"评论 %@", self.model.YueyouReplyCount] forState:UIControlStateNormal];
//    }
    view2.frame = CGRectMake(_comment.right, self.contentView.bottom - 35, 1, 30);

    _join.frame = CGRectMake(_comment.right + 1, self.contentView.bottom - 40, self.contentView.width / 3.0, 40);
    _join.titleLabel.textColor = [UIColor darkGrayColor];
    
    line.frame = CGRectMake(0, _like.top - 1, self.contentView.width, 1);
    
    line1.frame = CGRectMake(0, self.contentView.bottom - 1, self.contentView.width, 1);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (CGRect)getTextSize:(NSString *)text font:(UIFont *)font{
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(KScreenWidth, KScreenHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName] context:nil];
    
    return rect;
}


#pragma mark  点击头像的事件
- (void)imageClick:(UIButton *)button{
    
    ProfileViewController *profile = [[ProfileViewController alloc] init];
    profile.uid = self.model.Uid;
    profile.name = self.model.Nickname;
    profile.sex = self.model.Gender;
    profile.age = self.model.Age;
    [self.viewController.navigationController pushViewController:profile animated:YES];
    
}

#pragma mark  喜欢--评论--加入
- (void)likeButton:(UIButton *)btn{
    
//    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:[self getUserMessage]];
     NSDictionary *params = [self getUserMessage];
    if (params.count == 0) {
        //没有登录
        [(HomeViewController *)self.viewController _login];
    }else{
        
        //请求网络
        
        NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObject:[params objectForKey:user_token] forKey:@"token"];
        [param setObject:self.model.Yid forKey:@"yid"];
        
        [self requestData:param url:yueyou_like];
    }
    
}

- (void)commentButton:(UIButton *)btn{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:[self getUserMessage]];
    if (params.count == 0) {
        //没有登录
        [(HomeViewController *)self.viewController _login];
    }else{
        
        CommentTableViewController *commentVC = [[CommentTableViewController alloc] init];
        commentVC.yid = self.model.Yid;
        commentVC.comment_count = self.model.YueyouReplyCount;
        [self.viewController.navigationController pushViewController:commentVC animated:YES];
    }
    
}

- (void)joinButton:(UIButton *)btn{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:[self getUserMessage]];
    if (params.count == 0) {
        //没有登录
        [(HomeViewController *)self.viewController _login];
    }else{
        
    }
}

- (NSDictionary *)getUserMessage{
    
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:user_message];
}

- (void)requestData:(NSMutableDictionary *)params url:(NSString *)urlStr{
    
    [DataService requestWithURL:urlStr params:params httpMethod:@"POST" finishBlock:^(AFHTTPRequestOperation *operation, id result) {
        [_like setImage:[UIImage imageNamed:@"yqq_like.png"] forState:UIControlStateNormal];
        self.model.IsLike = @(![self.model.IsLike boolValue]);
    } failuerBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

@end
