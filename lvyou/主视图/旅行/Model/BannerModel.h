//
//  BannerModel.h
//  lvyou
//
//  Created by imac on 15/9/29.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "BaseModel.h"

@interface BannerModel : BaseModel

@property(nonatomic, strong)NSNumber *Bid;
@property(nonatomic, copy)NSString *Title;
@property(nonatomic, copy)NSString *PicUrl;
@property(nonatomic, copy)NSString *Created;
@property(nonatomic, copy)NSString *StartTime;
@property(nonatomic, copy)NSString *EndTime;
@property(nonatomic, strong)NSNumber *Status;
@property(nonatomic, copy)NSString *Mark;
@property(nonatomic, copy)NSString *Extend;
@property(nonatomic, strong)NSNumber *Sort;
@property(nonatomic, strong)NSNumber *Type;
@property(nonatomic, strong)NSNumber *Area;


@end
