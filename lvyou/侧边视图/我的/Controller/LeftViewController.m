//
//  LeftViewController.m
//  lvyou
//
//  Created by imac on 15/9/28.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "LeftViewController.h"
#import "ProfileViewController.h"
#import "BaseNavigationController.h"
@interface LeftViewController ()

@end

@implementation LeftViewController

-(void)getLoginMessage:(NSMutableDictionary *)params{
    
    [DataService requestWithURL:login_url params:params httpMethod:@"POST" finishBlock:^(AFHTTPRequestOperation *operation, id result) {
        
        id items = result[@"Items"];
        if ([items isKindOfClass:[NSNull class]]) {
            return ;
        }
        
        self.model = [[ProfileModel alloc] initContentWithDic:items];
        
        
    } failuerBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:20/ 255.0 green:140 / 255.0 blue:1 alpha:1];
    self.view.width = 200;
    
    logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:logoutButton];
    
    loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:loginButton];
    

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //获取本地的账号信息
    userMessage = [[NSUserDefaults standardUserDefaults] objectForKey:user_message];
    
    if (userMessage.count == 0) {
        //没有登录
        [self _isNoLogin];
        
    }else{
        //已经登录
        [self _initPersonView];
        
        NSString *usid = [userMessage objectForKey:user_id];
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:usid forKey:@"usid"];
        [self getLoginMessage:params];
    }
}

//没有登录显示的视图
- (void)_isNoLogin{
    
    _tableView.hidden = YES;
    loginButton.hidden = YES;
    logoutButton.hidden = NO;

    [logoutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    logoutButton.titleLabel.font = [UIFont systemFontOfSize:16];
    logoutButton.backgroundColor = [UIColor orangeColor];
    logoutButton.layer.cornerRadius = 5;
    logoutButton.layer.masksToBounds = YES;
    
    
    logoutButton.frame = CGRectMake((200 - 150) / 2, 200, 150, 40);
    [logoutButton setTitle:@"账号登录" forState:UIControlStateNormal];
    [logoutButton addTarget:self action:@selector(_login) forControlEvents:UIControlEventTouchUpInside];
}

//已经登录显示的视图
- (void)_initPersonView{
    
    _tableView.hidden = NO;
    loginButton.hidden = NO;
    logoutButton.hidden = YES;
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginButton.titleLabel.font = [UIFont systemFontOfSize:16];
    loginButton.backgroundColor = [UIColor orangeColor];
    loginButton.layer.cornerRadius = 5;
    loginButton.layer.masksToBounds = YES;
    
    
    [loginButton setTitle:@"退出登录" forState:UIControlStateNormal];
    loginButton.frame = CGRectMake((200 - 150) / 2, self.view.height - 100, 150, 40);
    [loginButton addTarget:self action:@selector(regist) forControlEvents:UIControlEventTouchUpInside];
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, 200, self.view.height - 100) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.bounces = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.hidden = NO;
        [self.view addSubview:_tableView];

        _tableTitle = @[@[@"个人主页", @"我发起的约游", @"我发布的动态"], @[@"红包"], @[@"设置"]];
        _tableImgs = @[@[@"mine_selected", @"mineStart", @"dynamic"], @[@"bonus_bag"], @[@"tabbar_settingHL"]];
    }
    
    
    if (_headerView == nil) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 120)];
        _tableView.tableHeaderView = _headerView;
        
        //用户头像
        _userImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
        //    [_userImage sd_setImageWithURL:[NSURL URLWithString:[userMessage objectForKey:user_icon]]];
        _userImage.layer.cornerRadius = 25.0;
        _userImage.layer.masksToBounds = YES;
        _userImage.backgroundColor = [UIColor redColor];
        [_headerView addSubview:_userImage];
        
        //用户名
        _userName = [[UILabel alloc] initWithFrame:CGRectMake(_userImage.right + 10, _userImage.top + 10, 100, 20)];
        _userName.font = [UIFont systemFontOfSize:15];
//        _userName.backgroundColor = [UIColor grayColor];
        _userName.font = [UIFont systemFontOfSize:16];
        [_headerView addSubview:_userName];
        
        //    _userName.text = [userMessage objectForKey:user_name];
        
        //性别和年龄
        _sexAge = [[UIView alloc] initWithFrame:CGRectMake(_userImage.right - 15, _userImage.bottom - 10, 40, 15)];
        _sexAge.layer.cornerRadius = 5;
        _sexAge.layer.masksToBounds = YES;
        //    _sexAge.backgroundColor = [UIColor blueColor];
        [_headerView addSubview:_sexAge];
        
        image = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, 15, 15)];
        [_sexAge addSubview:image];
        label = [[UILabel alloc] initWithFrame:CGRectMake(image.right, 0, 20, 15)];
        label.font = [UIFont systemFontOfSize:14];
        [_sexAge addSubview:label];
        
        //编辑
        _editButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _editButton.frame = CGRectMake(_headerView.right - 35, _userName.top, 30, 30);
        //    [_editButton setTitle:@"编辑资料" forState:UIControlStateNormal];
        [_editButton setImage:[UIImage imageNamed:@"orderEdit.png"] forState:UIControlStateNormal];
        [_editButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        _editButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_headerView addSubview:_editButton];
        
        //想去
        _want = [[UILabel alloc] initWithFrame:CGRectMake(_userName.left + 20, _userName.bottom, 100, 30)];
        _want.font = [UIFont italicSystemFontOfSize:14];
        [_headerView addSubview:_want];
        
        UIImageView *imgView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line_topic.png"]];
        imgView1.frame = CGRectMake(0, _headerView.bottom - 41, _headerView.width, 1);
        [_headerView addSubview:imgView1];
        
        _friends = [UIButton buttonWithType:UIButtonTypeCustom];
        _friends.frame = CGRectMake(0, _headerView.bottom - 40, _headerView.width / 2, 40);
        [_friends setTitleEdgeInsets:UIEdgeInsetsMake(-10, 0, 0, 0)];
//        _friends.backgroundColor = [UIColor purpleColor];
        _friends.titleLabel.font = [UIFont systemFontOfSize:13];
        [_headerView addSubview:_friends];
        UILabel *title1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 22, _friends.width, 18)];
        title1.font = [UIFont systemFontOfSize:12];
        title1.textAlignment = NSTextAlignmentCenter;
        title1.text = @"关注";
        [_friends addSubview:title1];
        
        _follower = [UIButton buttonWithType:UIButtonTypeCustom];
        _follower.frame = CGRectMake(_friends.right, _headerView.bottom - 40, _headerView.width / 2, 40);
//        _follower.backgroundColor = [UIColor yellowColor];
        [_follower setTitleEdgeInsets:UIEdgeInsetsMake(-10, 0, 0, 0)];
        _follower.titleLabel.font = [UIFont systemFontOfSize:13];
        [_headerView addSubview:_follower];
        UILabel *title2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 22, _follower.width, 18)];
        title2.font = [UIFont systemFontOfSize:12];
        title2.textAlignment = NSTextAlignmentCenter;
        title2.text = @"粉丝";
        [_follower addSubview:title2];
        
        UIImageView *imgView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line_topic.png"]];
        imgView2.frame = CGRectMake(0, _headerView.bottom - 1, _headerView.width, 1);
        [_headerView addSubview:imgView2];
    }

    
    
}


#pragma mark  UITableViewDataSource, UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _tableTitle.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray *arr = _tableTitle[section];
    
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    NSArray *imgs = _tableImgs[indexPath.section];
    [cell.imageView setImage:[UIImage imageNamed:imgs[indexPath.row]]];
    NSArray *texts = _tableTitle[indexPath.section];
    cell.textLabel.text = texts[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.textLabel.textColor = [UIColor orangeColor];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                {
                    ProfileViewController *profile = [[ProfileViewController alloc] init];
                    profile.name = [userMessage objectForKey:user_name];
                    profile.imgUrl = [userMessage objectForKey:user_icon];
                    
//                    [self presentViewController:profile animated:YES completion:nil];
                    break;
                }
                case 1:
                {
                    break;
                }
                case 2:
                {
                    break;
                }
                default:
                    break;
            }
            break;
        }
        case 1:
        {
            break;
        }
        case 2:
        {
            break;
        }
        default:
            break;
    }
}


//退出登录
- (void)regist{
    
    [self _logout];
    
    [self viewWillAppear:YES];
    
}

- (void)setModel:(ProfileModel *)model{
    
    if (_model != model) {
        _model = model;
        
        [_userImage sd_setImageWithURL:[NSURL URLWithString:self.model.HeadUrl]];
        _userName.text = self.model.Nickname;
        
        _want.text = self.model.WantGo;
        
        [_friends setTitle:[NSString stringWithFormat:@"%@", self.model.LikeCount] forState:UIControlStateNormal];
        [_follower setTitle:[NSString stringWithFormat:@"%@", self.model.LikedCount] forState:UIControlStateNormal];
        
        if ([self.model.Gender isEqualToString:@"女"]) {
            _sexAge.backgroundColor = [UIColor colorWithRed:218 / 255.0 green:112 / 255.0 blue:214 / 255.0 alpha:1];
            image.image = [UIImage imageNamed:@"new_woman.png"];
            
        }else if ([self.model.Gender isEqualToString:@"男"]){
            _sexAge.backgroundColor = [UIColor colorWithRed:65 / 255.0 green:105 / 255.0 blue:225 / 255.0 alpha:0.7];
            image.image = [UIImage imageNamed:@"new_man.png"];
        }
        label.text = [NSString stringWithFormat:@"%@", self.model.Age];

    }
}


@end
