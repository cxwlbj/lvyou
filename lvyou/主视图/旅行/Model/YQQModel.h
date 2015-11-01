//
//  YQQModel.h
//  lvyou
//
//  Created by imac on 15/9/28.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "BaseModel.h"
#import "PicListModel.h"
#import "JoinListModel.h"
#import "ReplyModel.h"
#import "LikeModel.h"
@interface YQQModel : BaseModel

@property(nonatomic, copy)NSString *Yid;
@property(nonatomic, copy)NSString *Uid;
@property(nonatomic, copy)NSString *Destination;
@property(nonatomic, copy)NSString *From;
@property(nonatomic, copy)NSString *FromMark;
@property(nonatomic, copy)NSString *StartDate;
@property(nonatomic, copy)NSString *EndDate;
@property(nonatomic, copy)NSString *EndTime;
@property(nonatomic, copy)NSString *Require;
@property(nonatomic, copy)NSString *MoneyType;
@property(nonatomic, strong)NSNumber *Latitude;
@property(nonatomic, strong)NSNumber *Longitude;
@property(nonatomic, copy)NSString *Remark;
@property(nonatomic, strong)NSNumber *YueyouJoinCount;
@property(nonatomic, strong)NSNumber *YueyouLikeCount;
@property(nonatomic, strong)NSNumber *YueyouReplyCount;
@property(nonatomic, strong)NSNumber *Status;
@property(nonatomic, strong)NSString *Nickname;
@property(nonatomic, strong)NSString *HeadUrl;
@property(nonatomic, strong)NSString *Created;
@property(nonatomic, strong)NSArray *joinModel;
@property(nonatomic, strong)NSArray *picList;
@property(nonatomic, strong)NSArray *replyList;
@property(nonatomic, strong)NSArray *likeList;
@property(nonatomic, strong)NSNumber *Age;
@property(nonatomic, copy)NSString *Gender;
@property(nonatomic, copy)NSString *UserTags;
@property(nonatomic, copy)NSString *Work;
@property(nonatomic, strong)NSNumber *IsLike;
@property(nonatomic, strong)NSNumber *Distance;
@property(nonatomic, copy)NSString *Gid;
@property(nonatomic, copy)NSString *GroupName;
@property(nonatomic, copy)NSString *MaritalStatus;
@property(nonatomic, copy)NSString *WantGo;
@property(nonatomic, strong)NSNumber *IsGroup;
@property(nonatomic, strong)NSNumber *IsTop;
@property(nonatomic, strong)NSNumber *IsJoin;
@property(nonatomic, copy)NSString *Content;

@end
