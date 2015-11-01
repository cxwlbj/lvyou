//
//  CommentDetailTableViewcell.m
//  lvyou
//
//  Created by imac on 15/10/6.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "CommentDetailTableViewcell.h"
#import "ChatViewController.h"
@implementation CommentDetailTableViewcell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //
        NSArray *commentTitles = @[@"复制", @"私信", @"回复"];
        for (int i = 0; i < 3; i ++) {
            UIButton *_replyButton = [UIButton buttonWithType:UIButtonTypeCustom];
            _replyButton.layer.cornerRadius = 15;
            _replyButton.layer.masksToBounds = YES;
            _replyButton.titleLabel.font = [UIFont systemFontOfSize:12];
            _replyButton.hidden = YES;
            [_replyButton addTarget:self action:@selector(replyButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [_replyButton setTitle:commentTitles[i] forState:UIControlStateNormal];
            _replyButton.backgroundColor = [UIColor orangeColor];
            _replyButton.tag = 500 + i;
            [self.contentView addSubview:_replyButton];
        }
    }
    
    return self;
}



- (void)layoutSubviews{
    [super layoutSubviews];
    
    for (int i = 0; i < 3; i ++) {
        UIButton *btn = (UIButton *)[self.contentView viewWithTag:500 + i];
        btn.frame = CGRectMake(KScreenWidth - 40 * (3 -i), (self.contentView.height - 30) / 2, 30, 30);
    }
}

- (void)replyButtonClick:(UIButton *)btn{
    switch (btn.tag) {
        case 500:
        {
            //复制
            TextCopy *textCopy = [TextCopy textShare];
            textCopy.str = self.model.Content;
            
            UILabel *label = nil;
            if (label == nil) {
                label = [[UILabel alloc] initWithFrame:CGRectMake((KScreenWidth - 150) / 2, 0, 150, 30)];
                label.text = @"复制成功";
                label.textAlignment = NSTextAlignmentCenter;
                label.font = [UIFont systemFontOfSize:16];
                label.backgroundColor = [UIColor orangeColor];
            }
            label.alpha = 0;
            [self.viewController.view addSubview:label];
            [UIView animateWithDuration:0.5 animations:^{
                label.alpha = 0.6;
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.5 animations:^{
                    label.alpha = 0;
                }];
                [UIView setAnimationDelay:3];
                [label removeFromSuperview];
            }];
            break;
        }
        case 501:
        {
            //发私信
            ChatViewController *chatVC = [[ChatViewController alloc] init];
            chatVC.title = self.model.Nickname;
            chatVC.yid = self.model.Yrid;
            chatVC.uid = self.model.Uid;
            [self.viewController.navigationController pushViewController:chatVC animated:YES];
            
            break;
        }
        case 502:
        {
            break;
        }
        default:
            break;
    }
}

@end
