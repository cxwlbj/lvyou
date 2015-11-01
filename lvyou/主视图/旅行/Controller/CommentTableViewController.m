//
//  CommentTableViewController.m
//  lvyou
//
//  Created by imac on 15/10/6.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "CommentTableViewController.h"
#import "ReplyModel.h"
#import "CommentDetailTableViewcell.h"
#import "AppDelegate.h"
@interface CommentTableViewController ()

@end

@implementation CommentTableViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

//请求数据
- (void)_commentLoadData{
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObject:self.yid forKey:@"yid"];
    [param setObject:@(1000) forKey:@"num"];
    [DataService requestWithURL:replay_url params:param httpMethod:@"GET" finishBlock:^(AFHTTPRequestOperation *operation, id result) {
        
        id items = result[@"Items"];
        if ([items isKindOfClass:[NSArray class]]) {
            NSMutableArray *mArr = [NSMutableArray array];
            for (NSDictionary *dic in items) {
                ReplyModel *model = [[ReplyModel alloc] initContentWithDic:dic];
                [mArr addObject:model];
            }
            self.replyData = mArr;
            
            [self.tableView reloadData];
        }
        
    } failuerBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = [NSString stringWithFormat:@"评论%@", self.comment_count];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 50);
    [self _commentLoadData];
    
    //发表评论的视图
    view = [[UIView alloc] initWithFrame:CGRectMake(0, KScreenHeight - 50, KScreenWidth, 50)];
    view.backgroundColor = [UIColor whiteColor];
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate.window addSubview:view];
    
    UIImageView *userImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:user_message];
    [userImage sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:user_icon]]];
    userImage.layer.cornerRadius = 15;
    userImage.layer.masksToBounds = YES;
    [view addSubview:userImage];
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(userImage.right + 10, 10, KScreenWidth - 100 - 20, 30)];
    _textField.placeholder = @"在这里说点什么吧";
    _textField.delegate = self;
    [view addSubview:_textField];
    
    UIButton *sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sendButton.frame = CGRectMake(KScreenWidth - 35, 10, 30, 30);
    [sendButton addTarget:self action:@selector(sendReply:) forControlEvents:UIControlEventTouchUpInside];
    [sendButton setImage:[UIImage imageNamed:@"invited.png"] forState:UIControlStateNormal];
    [view addSubview:sendButton];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeViewFrame:) name:UIKeyboardDidChangeFrameNotification object:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.replyData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *replyDetail = @"replyCell";
    CommentDetailTableViewcell *cell = [tableView dequeueReusableCellWithIdentifier:replyDetail];
    if (cell == nil) {
        cell = [[CommentDetailTableViewcell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:replyDetail];
    }
    
    cell.model = self.replyData[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ReplyModel *model = self.replyData[indexPath.row];
    CGRect rect = [self getTextSize:model.Content font:[UIFont systemFontOfSize:16]];
    
    return rect.size.height + 100;
}

- (CGRect)getTextSize:(NSString *)text font:(UIFont *)font{
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(KScreenWidth - 60, KScreenHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName] context:nil];
    return rect;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CommentDetailTableViewcell *cell = (CommentDetailTableViewcell *)[tableView cellForRowAtIndexPath:indexPath];
    CommentDetailTableViewcell *lastCell = (CommentDetailTableViewcell *)[tableView cellForRowAtIndexPath:_lastIndexPath];
    for (int i = 0; i < 3; i ++) {
                UIButton *btn = (UIButton *)[cell.contentView viewWithTag:500 + i];
        btn.hidden = !btn.hidden;
    }
    if (self.lastIndexPath != indexPath) {
        for (int i = 0; i < 3; i++) {
            UIButton *lastBtn = (UIButton *)[lastCell.contentView viewWithTag:500 + i];
            lastBtn.hidden = YES;
        }
        self.lastIndexPath = indexPath;

    }

    [tableView reloadData];
}

- (void)sendReply:(UIButton *)btn{
    if (_textField.text.length == 0) {
        //空的
        UILabel *label = nil;
        if (label == nil) {
            label = [[UILabel alloc] initWithFrame:CGRectMake((KScreenWidth - 150) / 2, 0, 150, 30)];
            label.text = @"评论内容不能为空";
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:16];
            label.backgroundColor = [UIColor orangeColor];
        }
        label.alpha = 0;
        [self.view addSubview:label];
        [UIView animateWithDuration:0.5 animations:^{
            label.alpha = 0.6;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 animations:^{
                label.alpha = 0;
            }];
            [UIView setAnimationDelay:3];
            [label removeFromSuperview];
        }];
    }else{
        
        NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:user_message];
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:[dic objectForKey:user_token] forKey:@"token"];
        [params setObject:self.yid forKey:@"yid"];
        [params setObject:_textField.text forKey:@"content"];
        [DataService requestWithURL:replay_url params:params httpMethod:@"POST" finishBlock:^(AFHTTPRequestOperation *operation, id result) {
            
            _textField.text = nil;
            //请求数据
            [self _commentLoadData];
        } failuerBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        }];
        
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    [textField becomeFirstResponder];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    [textField resignFirstResponder];
}

- (void)changeViewFrame:(NSNotification *)notification{
    
    NSDictionary *userInfo = notification.userInfo;
    CGFloat keyBorde_y = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
    [UIView animateWithDuration:0.1 animations:^{
        view.bottom = keyBorde_y;
    }];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [view removeFromSuperview];
}


@end
