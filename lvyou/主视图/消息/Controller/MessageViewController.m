//
//  MessageViewController.m
//  lvyou
//
//  Created by imac on 15/9/28.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "MessageViewController.h"

@interface MessageViewController ()

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"消息中心";
    _imgs = @[@"sys_mes.png", @"love_mes.png", @"signup_mes.png", @"chatlist_mes.png", @"attention_mes.png", @"comments_mes.png"];
    _titles = @[@" 系统消息", @" 喜欢提醒", @" 报名提醒", @" 聊天", @" 关注提醒", @" 评论提醒"];
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 65;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.bounces = NO;
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.imgs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.imageView setImage:[UIImage imageNamed:self.imgs[indexPath.row]]];
    cell.textLabel.text = self.titles[indexPath.row];
    cell.textLabel.textColor = [UIColor colorWithRed:150 / 255.0 green:134 / 255.0 blue:130 / 255.0 alpha:1];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line_topic.png"]];
    imgView.frame = CGRectMake(0, 64, KScreenWidth, 1);
    imgView.alpha = 0.6;
    [cell.contentView addSubview:imgView];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MesViewController *mesVC = [[MesViewController alloc] init];
    mesVC.title = self.titles[indexPath.row];
    if (indexPath.row == 1 || indexPath.row == 5) {
        mesVC.show = YES;
    }else{
        mesVC.show = NO;
    }
    
    [self.navigationController pushViewController:mesVC animated:YES];
    
}

@end
