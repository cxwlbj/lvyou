//
//  DateModel.h
//  lvyou
//
//  Created by imac on 15/10/9.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateModel : NSObject


@property (nonatomic,strong) NSDate *calendarDate;

// Gregorian calendar
@property (nonatomic, strong) NSCalendar *gregorian;

// Selected day
@property (nonatomic, strong) NSDate * selectedDate;

// Width in point of a day button
@property (nonatomic, assign) NSInteger dayWidth;


// NSCalendarUnit for day, month, year and era.
@property (nonatomic, assign) NSCalendarUnit dayInfoUnits;

// Array of label of weekdays
@property (nonatomic, strong) NSArray * weekDayNames;


@end
