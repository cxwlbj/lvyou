//
//  LYTModel.h
//  lvyou
//
//  Created by imac on 15/9/30.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "BaseModel.h"

@interface LYTModel : BaseModel

@property(nonatomic, copy)NSString *Aid;
@property(nonatomic, copy)NSString *Title;
@property(nonatomic, copy)NSString *Destination;
@property(nonatomic, strong)NSNumber *MtPrice;
@property(nonatomic, copy)NSString *StartDate;
@property(nonatomic, copy)NSString *EndDate;
@property(nonatomic, copy)NSString *Remark;
@property(nonatomic, copy)NSString *Duration;
@property(nonatomic, copy)NSNumber *ActivityLikeCount;
@property(nonatomic, copy)NSNumber *ActivityJoinCount;
@property(nonatomic, copy)NSNumber *ActivityReplyCount;
@property(nonatomic, copy)NSNumber *ShareCount;
@property(nonatomic, copy)NSString *PicUrl;
@property(nonatomic, copy)NSString *Nickname;





@end
