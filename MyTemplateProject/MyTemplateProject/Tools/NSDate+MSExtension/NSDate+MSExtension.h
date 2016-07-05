//
//  NSDate+MSExtension.h
//  MyTemplateProject
//
//  Created by dengliwen on 16/7/5.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    MSDateMonday = 1, //周一
    MSDateTuesday,
    MSDateWednesday,
    MSDateThursday,
    MSDateFriday,
    MSDateSaturday,
    MSDateSunday
} MSDateWeekDay;

@interface MSDateItem : NSObject
@property (nonatomic, assign) NSInteger day;
@property (nonatomic, assign) NSInteger hour;
@property (nonatomic, assign) NSInteger minute;
@property (nonatomic, assign) NSInteger second;
@end

@interface NSDate (MSExtension)

- (BOOL)ms_isToday;
- (BOOL)ms_isYesterday;
- (BOOL)ms_isTomorrow;
- (BOOL)ms_isThisYear;

/**
 *  今天周几
 */
- (MSDateWeekDay)ms_getNowWeekday;

/**
 *  两个时间之间的间隔
 *
 */
- (MSDateItem *)ms_timeIntervalSinceDate:(NSDate *)anotherDate;

@end
