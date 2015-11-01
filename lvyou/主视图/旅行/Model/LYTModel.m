//
//  LYTModel.m
//  lvyou
//
//  Created by imac on 15/9/30.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "LYTModel.h"

@implementation LYTModel
//"StartDate": "2015-10-02 00:00:00"

- (id)initContentWithDic:(NSDictionary *)jsonDic{
    self = [super initContentWithDic:jsonDic];
    if (self) {
        //
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        //2015-09-25 15:41:16
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        //        [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
        NSDate *date1 = [formatter dateFromString:self.StartDate];
        //        NSLog(@"%@", date);
        NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
        [formatter1 setDateFormat:@"yyyy.MM.dd"];
        
        self.StartDate = [formatter1 stringFromDate:date1];
        
        NSDate *date2 = [formatter dateFromString:self.EndDate];
        [formatter1 setDateFormat:@"yyyy.MM.dd"];
        
        self.EndDate = [formatter1 stringFromDate:date2];
        
    }
    
    return self;
}


@end
