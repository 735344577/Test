//
//  KLCalculateMonthOfDays.m
//  CloudMoneyNew
//
//  Created by nice on 2017/5/11.
//  Copyright © 2017年 dfyg. All rights reserved.
//

#import "KLCalculateMonthOfDays.h"

@interface KLCalculateMonthOfDays ()
/**日历*/
@property (nonatomic, strong) NSCalendar *calendar;
/**NSDateFormatter*/
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
/**计息日期*/
@property (nonatomic, strong) NSDate *nextDate;
/** 开始年*/
@property (nonatomic, assign) NSUInteger currentYear;
/** 开始月*/
@property (nonatomic, assign) NSUInteger currentMonth;
/** 开始天*/
@property (nonatomic, assign) NSUInteger currentDay;
/**定义队列*/
@property (nonatomic, strong) dispatch_queue_t queue;

/**最终各年月计息天数*/
@property (nonatomic, strong) NSMutableDictionary *yearMonthDic;
/**最终各年月计息天数*/
@property (nonatomic, strong) NSMutableDictionary *yearDic;
@end

@implementation KLCalculateMonthOfDays


- (instancetype)init {
    self = [super init];
    if (self) {
        _calendar = [NSCalendar currentCalendar];
        _dateFormatter = [[NSDateFormatter alloc] init];
        _dateFormatter.dateFormat=@"yyyy-MM-dd HH:mm:ss";
        NSDate *currentDate = [NSDate date];
        _nextDate = [NSDate dateWithTimeInterval:24*60*60 sinceDate:currentDate];
        unsigned int unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
        NSDateComponents *d = [_calendar components:unitFlags fromDate:_nextDate];
        _currentYear = [d year];
        _currentMonth = [d month];
        _currentDay = [d day];
        _queue = dispatch_queue_create("com.yunqiandai", DISPATCH_QUEUE_CONCURRENT);
//        _yearMonthDic = @{}.mutableCopy;
//        [_yearMonthDic setObject:@(_currentDay) forKey:@"currentDay"];
//        _yearDic = @{}.mutableCopy;
//        [_yearDic setObject:@(_currentDay) forKey:@"currentDay"];
    }
    return self;
}
// 计算的结果是 (年化start * 天数start + ... +年化end * 天数end) / 365 / 100
//注 result(结果）* 本金 就是最终受益
- (NSNumber *)calculateDaysWithYearRate:(NSArray *)rates {
    NSMutableArray *interests = @[].mutableCopy;
    __block NSNumber *resut;
    dispatch_sync(_queue, ^{
        NSArray *days = [self calculateDaysWithCount:rates.count];
        for (NSInteger i = 0; i < rates.count; i++) {
            NSNumber *interest = [self calculateResultWithRate:rates[i] day:days[i]];
            [interests addObject:interest];
        }
        resut = [interests valueForKeyPath:@"@sum.doubleValue"];
    });
    return resut;
}

- (NSArray *)calculateDaysWithCount:(NSInteger)count {
    NSMutableArray *mArr = @[].mutableCopy;
    for (NSInteger i = 0; i < count; i++) {
        NSUInteger days = [self getDaysWithIndex:i];
        [mArr addObject:@(days)];
    }
    
    return mArr;
}

- (NSNumber *)calculateResultWithRate:(NSNumber *)rate day:(NSNumber *)days {
    //每个月的年化 * 天数 / 365 / 100
    double result = [rate doubleValue] * [days doubleValue] / 365 / 100;
    return @(result);
}


- (NSUInteger)getDaysWithIndex:(NSUInteger)index {
    NSUInteger month = [self getMonthWithCurrentMonth:_currentMonth index:index];
    NSUInteger year = [self getYearWithYear:_currentYear currentMonth:_currentMonth index:index];
    NSUInteger result = 0;
    //当前月天数
    NSUInteger monthDay = [self getDaysWithYear:year month:month];
    //下一个月
    NSUInteger nextMonth = [self getMonthWithCurrentMonth:month index:1];
    //下一个月的年份
    NSUInteger nextMonthYear = [self getYearWithYear:_currentYear currentMonth:_currentMonth index:index + 1];
    //下一个月天数
    NSUInteger nextMonthDays = [self getDaysWithYear:nextMonthYear month:nextMonth];
    //计息日大于等于下个月天数
    if (_currentDay >= nextMonthDays) {
        //特别注意_currentDay 为29/30/31时  2月可能没有29号 一定没有30/31号 本月剩余天数最少为1, 不会出现负数情况
        NSInteger currentMonthSurplusDays = monthDay - _currentDay + 1;
        if (currentMonthSurplusDays < 1) {
            currentMonthSurplusDays = 1;
        }
        NSUInteger nextMonthUseDays = nextMonthDays - 1;
        result = currentMonthSurplusDays + nextMonthUseDays;
    } else {
        //计息日小于下个月天数
        if (_currentDay <= monthDay) {
            result = [self getDaysWithYear:year month:month];
        } else {
            result = _currentDay;
        }
    }
//    NSDictionary *monthDic = @{@"month": @(month), @"result": @(result)};
//    NSMutableArray *monthArr = [_yearMonthDic objectForKey:[@(year) stringValue]];
//    NSMutableArray *monArr = [_yearDic objectForKey:[@(year) stringValue]];
//    if (!monthArr) {
//        monthArr = @[].mutableCopy;
//    }
//    if (!monArr) {
//        monArr = @[].mutableCopy;
//    }
//    [monthArr addObject:monthDic];
//    [monArr addObject:@(result)];
//    [_yearMonthDic setObject:monthArr forKey:[@(year) stringValue]];
//    [_yearDic setObject:monArr forKey:[@(year) stringValue]];
    return result;
}

- (NSUInteger)getDaysWithYear:(NSUInteger)year month:(NSUInteger)month {
    
    if((month == 1) || (month == 3) || (month == 5) || (month == 7) || (month == 8) || (month == 10) || (month == 12))
        return 31;
    
    if((month == 4) || (month == 6) || (month == 9) || (month == 11))
        return 30;
    
    if((year % 4 == 1) || (year % 4 == 2) || (year % 4 == 3)) {
        return 28;
    }
    
    if(year % 400 == 0)
        return 29;
    
    if(year % 100 == 0)
        return 28;
    
    return 29;
}

- (NSUInteger)getFebruaryDaysWithYear:(NSUInteger)year {
    return [self getDaysWithYear:year month:2];
}

//计算当前月后几个月是几月
- (NSUInteger)getMonthWithCurrentMonth:(NSUInteger)currentMonth index:(NSUInteger)index {
    NSUInteger result = currentMonth + index;
    NSUInteger month = result % 12;
    return (month == 0) ? 12 : month;
}

- (NSUInteger)getYearWithYear:(NSUInteger)year currentMonth:(NSUInteger)currentMonth index:(NSUInteger)index {
    NSUInteger result = currentMonth + index;
    NSInteger addYear = result / 12;
    NSUInteger month = result % 12;
    if (month == 0) {
        addYear = addYear - 1;
    }
    return (year + addYear);
}

- (NSCalendar *)calendar {
    if (!_calendar) {
        _calendar = [NSCalendar currentCalendar];
    }
    return _calendar;
}

- (NSDateFormatter *)dateFormatter {
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        _dateFormatter.dateFormat=@"yyyy-MM-dd HH:mm:ss";
    }
    return _dateFormatter;
}

@end
