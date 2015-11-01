//
//  JoinListModel.h
//  lvyou
//
//  Created by imac on 15/9/29.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "BaseModel.h"

@interface JoinListModel : BaseModel

@property(nonatomic, copy)NSString *Uid;
@property(nonatomic, copy)NSString *Gender;
@property(nonatomic, copy)NSString *Nickname;
@property(nonatomic, copy)NSString *HeadUrl;
@property(nonatomic, copy)NSString *UserName;
@property(nonatomic, copy)NSString *UserPhone;
@property(nonatomic, copy)NSString *UserMark;
@property(nonatomic, copy)NSString *Created;
@property(nonatomic, strong)NSNumber *Status;

@end
