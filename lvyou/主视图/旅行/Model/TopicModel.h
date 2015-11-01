//
//  TopicModel.h
//  lvyou
//
//  Created by imac on 15/9/29.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "BaseModel.h"

@interface TopicModel : BaseModel

@property(nonatomic, strong)NSNumber *Tid;
@property(nonatomic, copy)NSString *Title;
@property(nonatomic, copy)NSString *PicUrl;
@property(nonatomic, copy)NSString *ReasonUrl;
@property(nonatomic, copy)NSString *Reason;
@property(nonatomic, strong)NSNumber *Status;
@property(nonatomic, copy)NSString *Created;
@property(nonatomic, strong)NSNumber *ReplyCount;
@property(nonatomic, strong)NSString *List;


@end
