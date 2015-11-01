//
//  DateModel.m
//  lvyou
//
//  Created by imac on 15/10/9.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "DateModel.h"

@implementation DateModel


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self _getCalendar];
    }
    return self;
}


#pragma mark  日历的处理
- (void)_getCalendar{
    
    //创建一个日历
    //取得当前用户的逻辑日历
    _gregorian = [NSCalendar currentCalendar];
    
    //设置时区
    _gregorian.timeZone = [NSTimeZone systemTimeZone];
    
    //设置每周的第一天从星期几开始
    _gregorian.firstWeekday = 1;  //周日--1  周一--2
    //设置第一周必须包含的最少天数
    _gregorian.minimumDaysInFirstWeek = 1;
    
    _dayInfoUnits = NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    
//    _calendarDate = [NSDate date];
    
     NSDateComponents *components = [_gregorian components:_dayInfoUnits fromDate:[NSDate date]];
    
    _selectedDate = [_gregorian dateFromComponents:components];
    
}


//设置日历上显示的数据
- (void)showDate{
    
    //星期
    _weekDayNames = @[@"日", @"一", @"二", @"三", @"四", @"五", @"六"];
    
    
}

- (NSArray *)getDaysFromMonth:(NSUInteger)month{
    
    //判断一个月有几天
    
    
    
    
    return nil;
}

@end
