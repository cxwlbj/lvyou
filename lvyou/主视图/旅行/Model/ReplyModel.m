//
//  ReplyModel.m
//  lvyou
//
//  Created by imac on 15/9/30.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "ReplyModel.h"

@implementation ReplyModel

- (id)initContentWithDic:(NSDictionary *)jsonDic{
    
    self = [super initContentWithDic:jsonDic];
    if (self) {
        //
        
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        //2015-09-25 15:41:16
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        //        [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
        NSDate *date = [formatter dateFromString:self.Created];
        //        NSLog(@"%@", date);
        NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
        [formatter1 setDateFormat:@"MM-dd HH:mm"];
        
        self.Created = [formatter1 stringFromDate:date];
    }
    return self;
}

@end
