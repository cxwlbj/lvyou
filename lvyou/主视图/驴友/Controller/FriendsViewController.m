//
//  FriendsViewController.m
//  lvyou
//
//  Created by imac on 15/9/28.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "FriendsViewController.h"
#import "MMDrawerBarButtonItem.h"
#import "UIViewController+MMDrawerController.h"
#import "ProfileViewController.h"
@interface FriendsViewController ()

@end

@implementation FriendsViewController

//请求网络
- (void)_loadData:(NSString *)str{
    
    NSDictionary *result = [DataService getDictionaryFromJsonData:str];
    
    NSMutableArray *mArr = [NSMutableArray array];
    
    //一起去的数据
    NSArray *items = result[@"Items"];
    for (NSDictionary *dic in items) {
        YQQModel *yiqiquModel = [[YQQModel alloc] initContentWithDic:dic];
        [mArr addObject:yiqiquModel];
    }
    
    self.hot_data = mArr;
    
    [_tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置导航栏
    [self _customNavigationBar];
    
    //发起约游
    [self _addButton:@"发布动态"];
    
    //设置导航栏左侧按钮
    [self _initLeftButton];
    
    //创建tableView
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.bounces = NO;
    [self.view insertSubview:_tableView belowSubview:selecting];
    
    [self _setHeaderView];
    
    //请求数据
    [self _loadData:nearby];
    
    _friendsView = [[FindFriendsView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - 64 - 49)];
    _friendsView.right = 0;
//    _friendsView.hidden = YES;
    [self.view addSubview:_friendsView];
    
}

//设置tableView头视图
- (void)_setHeaderView{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 120)];
    bgView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
    
    _headerView = [[UIControl alloc] initWithFrame:CGRectMake(10, 10, KScreenWidth - 20, 100)];
    _headerView.layer.borderColor =  [UIColor whiteColor].CGColor;
    [_headerView addTarget:self action:@selector(headerClick) forControlEvents:UIControlEventTouchUpInside];
    _headerView.layer.borderWidth = 2;
    _headerView.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:_headerView];
    _tableView.tableHeaderView = bgView;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 30)];
    label.font = [UIFont systemFontOfSize:16];
    label.text = @"您可能感兴趣";
    [_headerView addSubview:label];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(_headerView.width - 100, 0, 100, 30);
    [_headerView addSubview:button];
    
    [button setTitle:@"找更多驴友>>" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, _headerView.bottom - 70, 50, 50)];
    imgView.layer.masksToBounds = YES;
    imgView.layer.cornerRadius = 25.0f;
    [imgView setImage:[UIImage imageNamed:@"registerAvarta.png"]];
    [_headerView addSubview:imgView];
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(imgView.right + 10, imgView.top, 100, 30)];
    name.text = @"驴游菌";
    [_headerView addSubview:name];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(imgView.right + 10, name.bottom, 100, 20)];
    label1.text = @"有事儿找我";
    label1.font = [UIFont systemFontOfSize:12];
    [_headerView addSubview:label1];
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addButton.frame = CGRectMake(_headerView.width - 50, _headerView.bottom - 70, 50, 50);
    [addButton setImage:[UIImage imageNamed:@"addFriend.png"] forState:UIControlStateNormal];
    [_headerView addSubview:addButton];
    
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 30, _headerView.width, 1)];
    line.image = [UIImage imageNamed:@"line_topic.png"];
    [_headerView addSubview:line];
    
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.hot_data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"lvyouCell";
    
    FriendsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[FriendsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.model = self.hot_data[indexPath.row];
    
    return cell;
}

//计算单元格高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YQQModel *model = self.hot_data[indexPath.row];
    
    CGRect textRect = [self getTextSize:model.Content font:[UIFont systemFontOfSize:14]];
    CGRect requestRect = [self getTextSize:model.Require font:[UIFont systemFontOfSize:12]];
    
    if (model.picList.count == 0) {
    
        return ( 20 + textRect.size.height + requestRect.size.height + 10 + ((KScreenWidth - 20 * 3) / 3.0));
    
    }
    return (70 + 80 + textRect.size.height + requestRect.size.height + 10 + ((KScreenWidth - 20 * 3) / 3.0));
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark  设置导航栏的标题视图
//设置导航栏
- (void)_customNavigationBar{
    //titleView
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 50)];
    self.navigationItem.titleView = titleView;
    
    NSArray *title = @[@"附近", @"好友"];
    
    for (int i = 0; i < title.count; i++) {
        UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        titleButton.tag = 300 + i;
        [titleButton setTitle:title[i] forState:UIControlStateNormal];
        [titleButton setTitleColor:[UIColor colorWithWhite:0 alpha:0.7] forState:UIControlStateNormal];
        titleButton.frame = CGRectMake(75 * i, 0, 75, 50);
        [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:titleButton];
        
        if (i == 0) {
            [titleButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            UIImageView *downImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_down.png"]];
            downImage.frame = CGRectMake(titleButton.right - 10, (titleButton.height - 10) / 2, 10, 10);
            [titleButton addSubview:downImage];
            
            lastSelectedButton = titleButton.tag;
            
            _selectedView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 48, 75, 2)];
            _selectedView.backgroundColor = [UIColor orangeColor];
            [titleButton addSubview:_selectedView];
            
            sequence.hidden = NO;
        }
    }
    [self sequenceView];
}

- (void)titleButtonClick:(UIButton *)button{
    
    [UIView animateWithDuration:0.3 animations:^{
        UIButton *titleButton = (UIButton *)[self.navigationItem.titleView viewWithTag:lastSelectedButton];
        titleButton.titleLabel.textColor = [UIColor colorWithWhite:0 alpha:0.7];
        [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        _selectedView.left = button.left;
    }];
    lastSelectedButton = button.tag;
    
    selecting.alpha = 0;
    if (button.tag == 300) {
        status = !status;  //控制是否显示下拉菜单
        if (status) {
            [UIView animateWithDuration:0.5 animations:^{
                selecting.alpha = 1;
                
            }];
        }else{
            [UIView animateWithDuration:0.5 animations:^{
                selecting.alpha = 0;
            }];
        }
        
        [UIView animateWithDuration:0.5 animations:^{
            _friendsView.right = 0;
            _tableView.left = 0;
//            _friendsView.hidden = YES;
//            _tableView.hidden = NO;
        }];
        
    }else{
        status = YES;
        [UIView animateWithDuration:0.5 animations:^{
            _friendsView.left = 0;
            _tableView.left = - KScreenWidth;
//            _friendsView.hidden = NO;
//            _tableView.hidden = YES;
        }];
    }

}

//点击筛选弹出的视图
- (void)sequenceView{
    selecting = [[UIImageView alloc] initWithFrame:CGRectMake((KScreenWidth - 90) / 2 - 40, -8, 90, 100)];
    selecting.alpha = 0;
    selecting.userInteractionEnabled = YES;
    UIImage *image = [UIImage imageNamed:@"chose_Item.png"];
    UIGraphicsBeginImageContext(CGSizeMake(90, 100));
    [image drawInRect:CGRectMake(0, 0, 90, 100)];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [image stretchableImageWithLeftCapWidth:50 topCapHeight:50];
    selecting.image = image;
    [self.view addSubview:selecting];
    
    NSArray *buttonTitle = @[@"身旁", @"最热"];
    for (int i = 0; i < buttonTitle.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 200 + i;
        button.frame = CGRectMake(10, (selecting.height - 20) / 2 * i + 20, selecting.width - 20, (selecting.height - 70) / 2);
        [button setTitleColor:[UIColor colorWithWhite:0 alpha:0.5] forState:UIControlStateNormal];
//        button.backgroundColor = [UIColor whiteColor];
        [button setTitle:buttonTitle[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(nearbyButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [selecting addSubview:button];
        
//        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, button.bottom + 10, selecting.width - 20, 0.5)];
//        imageView.alpha = 0.6;
//        imageView.backgroundColor = [UIColor lightGrayColor];
//        [selecting addSubview:imageView];
    }
}

- (void)nearbyButtonClick:(UIButton *)button{
    
    NSString *title = button.titleLabel.text;
    UIButton *titleButton = (UIButton *)[self.navigationItem.titleView viewWithTag:300];
    [titleButton setTitle:title forState:UIControlStateNormal];
    [UIView animateWithDuration:0.5 animations:^{
        selecting.alpha = 0;
        status = !status;
    }];
    
    if (button.tag == 200) {
        [self _loadData:nearby];
    }else if (button.tag == 201){
        [self _loadData:hot];
    }
    
}

#pragma mark  设置导航栏左侧按钮
//设置导航栏左侧按钮
- (void)_initLeftButton{
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 35, 35);
    leftButton.layer.cornerRadius = 35/2;
    leftButton.layer.masksToBounds = YES;
    leftButton.backgroundColor = [UIColor purpleColor];
    [leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
}
//左侧按钮的点击事件
- (void)leftButtonClick:(UIButton *)button{
    
    [UIView animateWithDuration:0.5 animations:^{
        [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
//        status = !status;
//        selecting.alpha = 0;
    }];
}

#pragma mark  设置侧滑是否响应
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [self.mm_drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    UIButton *leftButton = (UIButton *)self.navigationItem.leftBarButtonItem.customView;
    if (leftButton) {
        
        NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:user_message];
        if (userDic == nil) {
            //没有登录
            [leftButton setImage:[UIImage imageNamed:@"mine_selected.png"] forState:UIControlStateNormal];
        }else{
            
            [leftButton sd_setImageWithURL:[NSURL URLWithString:[userDic objectForKey:user_icon]] forState:UIControlStateNormal];
        }
    }
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.mm_drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeNone];
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
}

- (CGRect)getTextSize:(NSString *)text font:(UIFont *)font{
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(KScreenWidth - 40, KScreenHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName] context:nil];
    
    return rect;
}


#pragma mark  头视图上的点击事件
- (void)headerClick{
    
    ProfileViewController *profile = [[ProfileViewController alloc] init];
    profile.name = @"驴游菌";
    profile.sex = @"女";
    profile.age = @0;
    profile.uid = @"98fb4c9f-2126-11e5-a75b-00163e002e59";
    [self.navigationController pushViewController:profile animated:YES];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}



@end
