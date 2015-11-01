//
//  YQQModel.m
//  lvyou
//
//  Created by imac on 15/9/28.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "YQQModel.h"

@implementation YQQModel

- (id)initContentWithDic:(NSDictionary *)jsonDic{
    
    self = [super initContentWithDic:jsonDic];
    if (self) {
        id joinLists = [jsonDic objectForKey:@"JoinList"];
        
        if ([joinLists isKindOfClass:[NSArray class]]) {
            NSMutableArray *mArr = [NSMutableArray array];
            for (NSDictionary *dic in joinLists) {
                JoinListModel *join = [[JoinListModel alloc] initContentWithDic:dic];
                [mArr addObject:join];
            }
            self.joinModel = mArr;
            mArr = nil;
        }
        
        id picLists = [jsonDic objectForKey:@"PicList"];
        if ([picLists isKindOfClass:[NSArray class]]) {
            NSMutableArray *mArr1 = [NSMutableArray array];
            for (NSDictionary *dic in picLists) {
                PicListModel *pic = [[PicListModel alloc] initContentWithDic:dic];
                [mArr1 addObject:pic];
            }
            self.picList = mArr1;
            mArr1 = nil;
        }
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        //2015-09-25 15:41:16
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        //        [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
        NSDate *date = [formatter dateFromString:self.Created];
        //        NSLog(@"%@", date);
        NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
        [formatter1 setDateFormat:@"MM-dd HH:mm"];
        
        self.Created = [formatter1 stringFromDate:date];
        
        id replyLists = [jsonDic objectForKey:@"ReplyList"];
        if ([replyLists isKindOfClass:[NSArray class]]) {
            NSMutableArray *mArr2 = [NSMutableArray array];
            if (replyLists) {
                for (NSDictionary *dic in replyLists) {
                    ReplyModel *reply = [[ReplyModel alloc] initContentWithDic:dic];
                    [mArr2 addObject:reply];
                }
                self.replyList = mArr2;
                mArr2 = nil;
            }
        }
        
        id likeLists = [jsonDic objectForKey:@"LikeList"];
        if ([likeLists isKindOfClass:[NSArray class]]) {
            NSMutableArray *mArr2 = [NSMutableArray array];
                for (NSDictionary *dic in likeLists) {
                    LikeModel *like = [[LikeModel alloc] initContentWithDic:dic];
                    [mArr2 addObject:like];
                }
                self.likeList = mArr2;
                mArr2 = nil;
        }
        
        NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:current_location];
//        构建location
        CLLocation *_location = [[CLLocation alloc] initWithLatitude:[self.Latitude floatValue] longitude:[self.Longitude floatValue]];
        CLLocation *location = [[CLLocation alloc] initWithLatitude:[[dic objectForKey:@"lat"] floatValue] longitude:[[dic objectForKey:@"lon"] floatValue]];
//        计算距离
        CLLocationDistance distance = [_location distanceFromLocation:location];
        self.Distance = [NSNumber numberWithDouble:distance / 1000.0];
    }
    
    return self;
}


@end
