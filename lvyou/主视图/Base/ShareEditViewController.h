//
//  ShareEditViewController.h
//  lvyou
//
//  Created by imac on 15/10/9.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "BaseViewController.h"

@interface ShareEditViewController : BaseViewController
{
    UITextView *textView;
}

@property(nonatomic, copy)NSString *shareUrl;
@property(nonatomic, copy)NSString *time;
@property(nonatomic, copy)NSString *where;
@property(nonatomic, copy)NSString *yid;
@property(nonatomic, copy)NSString *share;


@end
