//
//  CommentTableViewController.h
//  lvyou
//
//  Created by imac on 15/10/6.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentTableViewController : UITableViewController<UITextFieldDelegate>
{
    UITextField *_textField;
    UIView *view;
}

@property(nonatomic, copy)NSNumber *comment_count;
@property(nonatomic, copy)NSString *yid;
@property(nonatomic, strong)NSArray *replyData;
@property(nonatomic, strong)NSIndexPath *lastIndexPath;

@end
