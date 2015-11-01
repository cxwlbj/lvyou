//
//  DetailViewController.m
//  lvyou
//
//  Created by imac on 15/9/30.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "DetailViewController.h"
#import "ProfileViewController.h"
#import "ShareEditViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)_loadData{
    
    NSLog(@"%@", self.yid);
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:self.yid forKey:@"yid"];
    [DataService requestWithURL:detail_url
                         params:params
                     httpMethod:@"GET"
                    finishBlock:^(AFHTTPRequestOperation *operation, id result) {
                        
//                        NSLog(@"------------%@", result);
//                        NSMutableArray *mArr = [NSMutableArray array];
                        
                        //一起去的数据
                        NSDictionary *items = result[@"Items"];
//                        for (NSDictionary *dic in items) {
//                            YQQModel *yiqiquModel = [[YQQModel alloc] initContentWithDic:dic];
//                            [mArr addObject:yiqiquModel];
//                        }
//                        self.commentData = mArr;
//                        mArr = nil;
//                        dispatch_async(dispatch_get_main_queue(), ^{
                        
                            self.model = [[YQQModel alloc] initContentWithDic:items];

//                        });
                    }
                   failuerBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
                       NSLog(@"error%@", error);
                       NSLog(@"yid %@", self.yid);
                   }];
    
}

- (void)_loadJson{
    NSDictionary *result = [DataService getDictionaryFromJsonData:detail];
    //一起去的数据
    NSDictionary *items = result[@"Items"];
    self.model = [[YQQModel alloc] initContentWithDic:items];
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"线路详情";
    self.view.backgroundColor = [UIColor whiteColor];
    
    //导航栏右边的视图
//    [self _initRightItem];
    
    //创建底部视图
    [self _creatBottomView];
    
    //创建分享视图
//    [self _shareView];
    
    [self _loadData];
    
//    [self _loadJson];
    
}



//定制底部标签栏样式
- (void)_creatBottomView{
    _footView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bottom - 49 - 64, KScreenWidth, 49)];
    _footView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_footView];
    
    likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    likeButton.frame = CGRectMake(0, 0, (self.view.width / 3.0 / 2.0), 49);
    [likeButton setImage:[UIImage imageNamed:@"noliked.png"] forState:UIControlStateNormal];
    [likeButton setImage:[UIImage imageNamed:@"mineLike.png"] forState:UIControlStateSelected];
    [likeButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [likeButton setImageEdgeInsets:UIEdgeInsetsMake(-18, 10, 0, 0)];
    [likeButton setTitleEdgeInsets:UIEdgeInsetsMake(20, -25, 0, 0)];
    [_footView addSubview:likeButton];
    
    commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    commentButton.frame = CGRectMake(likeButton.right, 0, (self.view.width / 3.0 / 2.0), 49);
    [commentButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    
    [commentButton setTitleEdgeInsets:UIEdgeInsetsMake(20, 0, 0, 34)];
    [_footView addSubview:commentButton];
    UILabel *labels = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, commentButton.width, 30)];
    labels.text = @"评论";
    labels.font = [UIFont systemFontOfSize:16];
    [commentButton addSubview:labels];
    
    UIButton *chatButton = [UIButton buttonWithType:UIButtonTypeCustom];
    chatButton.frame = CGRectMake(commentButton.right, 0, self.view.width / 3.0, 49);
    chatButton.backgroundColor = [UIColor colorWithRed:255 green:180 / 255.0 blue:0 alpha:1];
    [chatButton setTitle:@"聊天" forState:UIControlStateNormal];
    chatButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [_footView addSubview:chatButton];
    
    UIButton *joinButton = [UIButton buttonWithType:UIButtonTypeCustom];
    joinButton.frame = CGRectMake(chatButton.right, 0, self.view.width / 3.0, 49);
    joinButton.backgroundColor = [UIColor orangeColor];
    [joinButton setTitle:@"立即入伙" forState:UIControlStateNormal];
    joinButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [_footView addSubview:joinButton];
}


- (void)_initTableView{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - 64 - 49) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view insertSubview:_tableView belowSubview:_footView];
    
    //设置头视图
    [self _creatHeaderView];
}

#pragma mark UITableViewDataSource, UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return self.section1.count;
    }
    if (section == 1) {
        return self.section2.count;
    }
    
    if (section == 2) {
        
        return [self.comment_count integerValue];
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        //第三组
        static NSString *identi = @"section3";
        
        DetailSection3TableViewCell *sectionCell = [tableView dequeueReusableCellWithIdentifier:identi];
        if (sectionCell == nil) {
            sectionCell = [[DetailSection3TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identi];
        }
        if (self.comment_count != 0) {
            sectionCell.model = self.model.replyList[indexPath.row];
        }
        return sectionCell;
    }
    static NSString *identifier = @"DetailCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    if (indexPath.section == 0) {
        //第一组
        cell.textLabel.textColor = [UIColor blueColor];
        cell.textLabel.text = [NSString stringWithFormat:@"%@  %@",self.section1[indexPath.row], self.contents1[indexPath.row]];
    }
    if (indexPath.section == 1) {
        //第二组
        
        cell.textLabel.textColor = [UIColor orangeColor];
        cell.textLabel.text = [NSString stringWithFormat:@"%@  %@", self.section2[indexPath.row], self.contents2[indexPath.row]];
    }
    return cell;
    
}

//定制头视图
- (void)_creatHeaderView{
    
    CGRect textRect = [self getTextSize:self.model.Remark font:[UIFont systemFontOfSize:14]];
    CGRect requestRect = [self getTextSize:self.model.Require font:[UIFont systemFontOfSize:12]];
    CGFloat height = textRect.size.height + requestRect.size.height + 10 + ((KScreenWidth - 20 * 3) / 3.0) + 60;
    _tableViewHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, height + 175)];
    _tableViewHeaderView.backgroundColor = [UIColor whiteColor];
    _tableView.tableHeaderView = _tableViewHeaderView;
    
    //用户头像
    _userImage = [UIButton buttonWithType:UIButtonTypeCustom];
    [_userImage addTarget:self action:@selector(imageClick:) forControlEvents:UIControlEventTouchUpInside];
    _userImage.frame = CGRectMake(15, 15, 50, 50);
    _userImage.layer.cornerRadius = 25.0;
    _userImage.layer.masksToBounds = YES;
    _userImage.backgroundColor = [UIColor redColor];
    [_tableViewHeaderView addSubview:_userImage];
    
    //用户名
    _userName = [[UILabel alloc] initWithFrame:CGRectZero];
    _userName.backgroundColor = [UIColor grayColor];
    _userName.font = [UIFont systemFontOfSize:16];
    [_tableViewHeaderView addSubview:_userName];
    //性别和年龄
    _sexAge = [[UIView alloc] initWithFrame:CGRectZero];
    //    _sexAge.backgroundColor = [UIColor blueColor];
    [_tableViewHeaderView addSubview:_sexAge];
    
    
    _maritalStatus = [[UILabel alloc] initWithFrame:CGRectZero];
    _maritalStatus.font = [UIFont systemFontOfSize:14];
    _maritalStatus.textColor = [UIColor darkGrayColor];
    [_tableViewHeaderView addSubview:_maritalStatus];
    _want = [[UILabel alloc] initWithFrame:CGRectZero];
    _want.textColor = [UIColor darkGrayColor];
    _want.font = [UIFont systemFontOfSize:14];
    [_tableViewHeaderView addSubview:_want];
    image = [[UIImageView alloc] initWithFrame:CGRectMake(5, (20 - 15)/2, 15, 15)];
    [_sexAge addSubview:image];
    label = [[UILabel alloc] initWithFrame:CGRectMake(image.right + 5, 0, 40, 20)];
    label.font = [UIFont systemFontOfSize:14];
    [_sexAge addSubview:label];
    
    view = [[UIView alloc] initWithFrame:CGRectMake(0, _content.bottom, KScreenWidth, 40)];
    [_tableViewHeaderView addSubview:view];
    
    //喜欢
    _like = [UIButton buttonWithType:UIButtonTypeCustom];
    _like.frame = CGRectMake(0, 0, 80, 40);
    
    [_like setTitle:[NSString stringWithFormat:@"喜欢%@", self.like_count] forState:UIControlStateNormal];
    [_like setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    _like.titleLabel.font = [UIFont systemFontOfSize:14];
    [view addSubview:_like];
    
    //评论
    _comment = [UIButton buttonWithType:UIButtonTypeCustom];
    _comment.frame = CGRectMake(_like.right, _like.top, 80, 40);
    [_comment setTitle:[NSString stringWithFormat:@"评论%@", self.comment_count] forState:UIControlStateNormal];
    [_comment setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    _comment.titleLabel.font = [UIFont systemFontOfSize:14];
    [view addSubview:_comment];
    
    //加入
    _join = [UIButton buttonWithType:UIButtonTypeCustom];
    _join.frame = CGRectMake(_comment.right, _comment.top, 80, 40);
    [_join setTitle:[NSString stringWithFormat:@"已入伙%@", self.join_count] forState:UIControlStateNormal];
    [_join setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    _join.titleLabel.font = [UIFont systemFontOfSize:14];
    [view addSubview:_join];
    
    [likeButton setTitle:[NSString stringWithFormat:@"%@", self.model.YueyouLikeCount] forState:UIControlStateNormal];
    
    [commentButton setTitle:[NSString stringWithFormat:@"%@", self.model.YueyouReplyCount] forState:UIControlStateNormal];
}

#pragma mark  点击头像的事件
- (void)imageClick:(UIButton *)button{
    
    ProfileViewController *profile = [[ProfileViewController alloc] init];
    profile.name = self.model.Nickname;
    profile.sex = self.model.Gender;
    profile.age = self.model.Age;
    [self.navigationController pushViewController:profile animated:YES];
}

- (void)setModel:(YQQModel *)model{
    if (_model != model) {
        _model = model;
        
        self.section1 = @[@"出发时间:", @"返回时间:", @"出 发 地:", @"目 的 地:", @"集合地点:", @"截止时间:"];
        self.contents1 = @[self.model.StartDate, self.model.EndDate, self.model.From, self.model.Destination, self.model.FromMark, self.model.EndTime];
        self.section2 = @[@"费用说明：", @"约伴要求："];
        self.contents2 = @[self.model.MoneyType, self.model.Require];
        
        //创建tableView
        [self _initTableView];
        
        [self _addData];
//        NSLog(@"model is ====%@",model);
        [_tableView reloadData];
    }
}


- (void)_addData{
    [_userImage sd_setImageWithURL:[NSURL URLWithString:self.model.HeadUrl] forState:UIControlStateNormal];
    
    CGRect rect = [self getTextSize:self.model.Nickname font:[UIFont systemFontOfSize:16]];
    _userName.frame = CGRectMake(_userImage.right + 10, _userImage.top, rect.size.width + 20, 20);
    _userName.text = self.model.Nickname;
    
    //性别和年龄
    _sexAge.frame = CGRectMake(_userName.right + 10, _userName.top, 60, 20);
    
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
    
    CGRect marRect = [self getTextSize:self.model.MaritalStatus font:[UIFont systemFontOfSize:14]];
    
    _maritalStatus.frame = CGRectMake(_userName.left, _userName.bottom, marRect.size.width, 20);
    _maritalStatus.text = self.model.MaritalStatus;
    
    CGRect wantRect = [self getTextSize:self.model.WantGo font:[UIFont systemFontOfSize:14]];
    _want.frame = CGRectMake(_maritalStatus.right + 10, _maritalStatus.top, wantRect.size.width + 30, 20);
    _want.text = [NSString stringWithFormat:@"想去%@",self.model.WantGo];
    
    //内容
    //内容
    
    CGRect textRect = [self getTextSize:self.model.Remark font:[UIFont systemFontOfSize:14]];
    CGRect requestRect = [self getTextSize:self.model.Require font:[UIFont systemFontOfSize:12]];
    CGFloat height = textRect.size.height + requestRect.size.height + 10 + ((KScreenWidth - 20 * 3) / 3.0) + 60;
    _content = [[ContentView alloc] initWithFrame:CGRectMake(15, _userImage.bottom + 10, KScreenWidth - 30, height)];
    [_tableViewHeaderView addSubview:_content];
    _content.model = self.model;
    
    view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    view.frame = CGRectMake(0, _content.bottom + 10, KScreenWidth, 40);
    //显示头像视图
    imgView = [[UIView alloc] initWithFrame:CGRectMake(0, view.bottom, KScreenWidth, 50)];
    imgView.backgroundColor = [UIColor orangeColor];
    [_tableViewHeaderView addSubview:imgView];
    
//    _tableViewHeaderView.height = height + 100;
//    _tableView.tableHeaderView.height = height + 100;
}

- (CGRect)getTextSize:(NSString *)text font:(UIFont *)font{
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(KScreenWidth - 60, KScreenHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName] context:nil];
    
    return rect;
}

//设置组的头视图高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 2) {
        //
        if (self.comment_count != 0) {
            ReplyModel *model = self.model.replyList[indexPath.row];
            CGRect rect = [self getTextSize:model.Content font:[UIFont systemFontOfSize:16]];
            return rect.size.height + 80;
        }
        
    }
    return 40;
}


-(void)dealloc{
    
    NSLog(@"detail dealoc");
}

- (void)shareToSinaButtonClick:(UIButton *)button{
    [super shareToSinaButtonClick:button];
    
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:user_message];
    if (dic.count == 0) {
        
        [self _login];
        
    }else{
        
        //获取微博用户名、uid、token等
        //进入你的分享内容编辑页面
        ShareEditViewController *shareEdit = [[ShareEditViewController alloc] init];
        shareEdit.shareUrl = [share_url stringByAppendingFormat:@"?yid=%@", self.model.Yid];
        shareEdit.time = self
        .model.StartDate;
        shareEdit.where = self.model.Destination;
        shareEdit.share = @"sina";
        [self.navigationController pushViewController:shareEdit animated:YES];
        
    }
    
//    [UMSocialAccountManager isOauthAndTokenNotExpired:UMShareToSina];
//    //进入授权页面
//    [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina].loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
//        if (response.responseCode == UMSResponseCodeSuccess) {
//            //获取微博用户名、uid、token等
//            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
//            NSLog(@"username is %@, uid is %@, token is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken);
//            //进入你的分享内容编辑页面
//            ShareEditViewController *shareEdit = [[ShareEditViewController alloc] init];
//            shareEdit.yid = self.model.Yid;
//            shareEdit.time = self
//            .model.StartDate;
//            shareEdit.where = self.model.Destination;
//            [self.navigationController pushViewController:shareEdit animated:YES];
//        }
//    });
}

- (void)shareToQzoneButtonClick:(UIButton *)button{
    [super shareToQzoneButtonClick:button];
    
    //进入你的分享内容编辑页面
    ShareEditViewController *shareEdit = [[ShareEditViewController alloc] init];
    shareEdit.yid = self.model.Yid;
    shareEdit.time = self
    .model.StartDate;
    shareEdit.where = self.model.Destination;
    shareEdit.share = @"Qzone";
    [self.navigationController pushViewController:shareEdit animated:YES];
    
}




@end
