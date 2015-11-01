//
//  LikeModel.h
//  lvyou
//
//  Created by imac on 15/9/30.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "BaseModel.h"

@interface LikeModel : BaseModel

/*
 "Uid":"78ee2bab-5b7a-8530-3ffb-4345c4ef7d17",
 "Gender":"男",
 "Nickname":"行者",
 "HeadUrl":"http://img2.miaotu.com/data//images/avatar/2015-04-01/551c0c709c7a6.jpg"
 */

@property(nonatomic, copy)NSString *Uid;
@property(nonatomic, copy)NSString *Gender;
@property(nonatomic, copy)NSString *Nickname;
@property(nonatomic, copy)NSString *HeadUrl;

@end
