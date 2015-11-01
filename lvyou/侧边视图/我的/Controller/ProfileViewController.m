//
//  ProfileViewController.m
//  lvyou
//
//  Created by imac on 15/10/5.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "ProfileViewController.h"
#import "Section1TableViewCell.h"
@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}


- (void)_loadProfileData{
    
    //判断是否登录？
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:user_message];
    if (dic == nil) {
        //没有登录
        [self _login];
        return;
    }
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:dic];
    [param setObject:self.uid forKey:@"uid"];
    
    [DataService requestWithURL:user_url params:param httpMethod:@"GET" finishBlock:^(AFHTTPRequestOperation *operation, id result) {
        
        id items = result[@"Items"];
        if ([items isKindOfClass:[NSNull class]]) {
            return;
        }
        
        self.model = [[ProfileModel alloc] initContentWithDic:items];
        
    } failuerBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"个人主页";
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - 64 - 40) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.bounces = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    
    _section3 = @[@"家乡", @"职业", @"生活在", @"工作在", @"个人标签"];
    
    //头视图
    [self _initHeaderView];
    
    //设置标签栏
    [self _initBottomView];
    
    [self _loadProfileData];
}
//设置头视图
- (void)_initHeaderView{
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 250)];
    header.backgroundColor = [UIColor colorWithRed:15 / 255.0 green:120 / 255.0 blue:190 / 255.0 alpha:1];
    _tableView.tableHeaderView = header;
    
    _userImage = [[ZoomImageView alloc] initWithFrame:CGRectMake((KScreenWidth - 50) / 2, 50, 50, 50)];
    _userImage.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _userImage.layer.borderWidth = 2;
    _userImage.layer.cornerRadius = 25;
    _userImage.layer.masksToBounds = YES;
    [header addSubview:_userImage];
    
    _userName = [[UILabel alloc] initWithFrame:CGRectMake((KScreenWidth - 150) / 2, _userImage.bottom + 10, 150, 30)];
//    _userName.text = self.name;
    _userName.textColor = [UIColor orangeColor];
    _userName.textAlignment = NSTextAlignmentCenter;
    _userName.font = [UIFont systemFontOfSize:16];
    [header addSubview:_userName];
    
    //性别和年龄
    _sexAge = [[UIView alloc] initWithFrame:CGRectZero];
    //    _sexAge.backgroundColor = [UIColor blueColor];
    [header addSubview:_sexAge];
    image = [[UIImageView alloc] initWithFrame:CGRectMake(2, (20 - 15)/2, 15, 15)];
    [_sexAge addSubview:image];
    label = [[UILabel alloc] initWithFrame:CGRectMake(image.right + 2, 0, 20, 20)];
    label.font = [UIFont systemFontOfSize:12];
    [_sexAge addSubview:label];
    
    //性别和年龄
    _sexAge.frame = CGRectMake(_userImage.right - 15, _userImage.bottom - 15, 45, 20);
    
    _sexAge.backgroundColor = [UIColor clearColor];
    image.image = nil;
    label.text = nil;
    
    
    NSArray *titles = @[@"关注", @"粉丝", @"情感", @"想去"];
    for (int i = 0; i < 4; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 2015 + i;
        button.frame = CGRectMake((KScreenWidth / 4.0) * i, header.bottom - 40, KScreenWidth / 4.0, 40);
        button.backgroundColor = [UIColor colorWithRed:arc4random() % 10 * 0.1 green:arc4random() % 10 * 0.1 blue:arc4random() % 10 * 0.1 alpha:1];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        [button setTitleEdgeInsets:UIEdgeInsetsMake(-15, 0, 0, 0)];
        [header addSubview:button];
            UILabel *_countLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, button.height - 20, button.width, 20)];
            _countLabel.tag = 200;
            _countLabel.text = @"0";
            _countLabel.textAlignment = NSTextAlignmentCenter;
            _countLabel.font = [UIFont systemFontOfSize:14];
            [button addSubview:_countLabel];
    }
}

#pragma mark  UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 3) {
        return 5;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        Section1TableViewCell *cell = [[Section1TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];        
        
        return cell;
    }
    if (indexPath.section == 1) {
        
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        
        [cell.imageView setImage:[UIImage imageNamed:@"mineStart.png"]];
        cell.textLabel.text = @"TA发起的约游";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    if (indexPath.section == 2) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        
        [cell.imageView setImage:[UIImage imageNamed:@"dynamic.png"]];
        cell.textLabel.text = @"TA的动态";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    leftLabel.font = [UIFont systemFontOfSize:14];
    leftLabel.textAlignment = NSTextAlignmentCenter;
    leftLabel.text = _section3[indexPath.row];
    [cell.contentView addSubview:leftLabel];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(leftLabel.right + 5, 10, 1, cell.contentView.height - 20)];
    imgView.backgroundColor = [UIColor lightGrayColor];
    image.alpha = 0.5;
    [cell.contentView addSubview:imgView];
    
    UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftLabel.right + 20, 0, cell.contentView.width - leftLabel.width - 10, 44)];
    rightLabel.backgroundColor = [UIColor colorWithRed:arc4random() % 10 * 0.1 green:arc4random() % 10 * 0.1 blue:arc4random() % 10 * 0.1 alpha:1];
    [cell.contentView addSubview:rightLabel];
    
    return cell;
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return @"图片墙";
            break;
        case 1:
            return @"TA的约游";
            break;
        case 2:
            return @"动态";
            break;
        case 3:
            return @"个人资料";
            break;
        default:
            break;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 80;
    }
    
    return 44;
}


#pragma mark  设置标签栏
- (void)_initBottomView{
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, KScreenHeight - 64 - 40, KScreenWidth, 40)];
//    bottomView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:bottomView];
    
    UIButton *_leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _leftButton.frame = CGRectMake(0, 0, (KScreenWidth - 1) / 2.0 , 40);
    [_leftButton setImage:[UIImage imageNamed:@"focus.png"] forState:UIControlStateNormal];
    [_leftButton setTitle:@"  关注" forState:UIControlStateNormal];
    [_leftButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [bottomView addSubview:_leftButton];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(_leftButton.right, 10, 1, bottomView.height - 20)];
    imgView.backgroundColor = [UIColor lightGrayColor];
    image.alpha = 0.5;
    [bottomView addSubview:imgView];
    
    UIButton *_rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightButton.frame = CGRectMake(_leftButton.right + 1, 0, (KScreenWidth - 1) / 2.0 , 40);
    [_rightButton setImage:[UIImage imageNamed:@"chat_ico.png"] forState:UIControlStateNormal];
    [_rightButton setTitle:@"  聊天" forState:UIControlStateNormal];
    [_rightButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [bottomView addSubview:_rightButton];
}


- (void)setModel:(YQQModel *)model{
    if (_model != model) {
        _model = model;
       
        [_userImage sd_setImageWithURL:[NSURL URLWithString:self.model.HeadUrl]];

        _userName.text = self.model.Nickname;

        if ([self.model.Gender isEqualToString:@"女"]) {
            _sexAge.backgroundColor = [UIColor colorWithRed:218 / 255.0 green:112 / 255.0 blue:214 / 255.0 alpha:1];
            image.image = [UIImage imageNamed:@"new_woman.png"];
            
        }else if ([self.model.Gender isEqualToString:@"男"]){
            _sexAge.backgroundColor = [UIColor colorWithRed:65 / 255.0 green:105 / 255.0 blue:225 / 255.0 alpha:0.7];
            image.image = [UIImage imageNamed:@"new_man.png"];
        }
        
        if (self.age == 0) {
            label.hidden = YES;
            _sexAge.width = 20;
        }
        label.text = [NSString stringWithFormat:@" %@", self.model.Age];
    }
}

@end
