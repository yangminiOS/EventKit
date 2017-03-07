//
//  CalenderEvent.m
//  添加删除日历事件
//
//  Created by Detrum on 17/3/7.
//  Copyright © 2017年 Detrum-yangmin. All rights reserved.
//

//http://www.cnblogs.com/xiaobaichangan/p/5160025.html

#import "CalenderEvent.h"
#import "AppDelegate.h"
#import <EventKit/EventKit.h>
#import "NSDate+Category.h"

static NSString * const timeType = @"yyyy-MM-dd HH:mm";
@implementation CalenderEvent

#pragma   提供类方法接口

+ (void)initWithTitle:(NSString *)title identifider:(NSString *)identifider startTime:(NSString *)startTime endTime:(NSString *)endTime location:(NSString *)location noticeFireTime:(double)fireT noticeEndTime:(double)endT{
    
    [[self alloc] calenderTitle:title identifier:identifider startTime:startTime endTime:endTime location:location noticeFireTime:fireT noticeEndTime:endT];
}

#pragma   对象方法  内部使用


- (void)calenderTitle:(NSString *)title identifier:(NSString *)identifier startTime:(NSString *)startTime endTime:(NSString *)endTiem location:(NSString *)location noticeFireTime:(double)fireTime noticeEndTime:(double)endTime{
    
    AppDelegate *appDelelgata =(AppDelegate *) [UIApplication sharedApplication].delegate;
    EKEventStore *eventStore = appDelelgata.eventStore;
    
    //写入事件  6.0以上
    if([eventStore respondsToSelector:@selector(requestAccessToEntityType:completion:)]){
        
        [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError * _Nullable error) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (error) {
                    
                    //出错处理
                }else if (!granted){
                    //用户拒接访问
                }else{
                    //创建事件
                    EKEvent *event = [EKEvent eventWithEventStore:eventStore];
                    event.startDate = [self dateFromString:startTime withFormatter:timeType];
                    event.endDate = [self dateFromString:endTiem withFormatter:timeType];
                    //添加闹铃
                    [event addAlarm:[EKAlarm alarmWithAbsoluteDate:event.startDate]];
                    //添加标题
                     event.title = title;
                    //添加事件发生地址
                     event.location = location;
                    //添加唯一标识
                     event.notes = identifier;
                    //加入日历事件库  类似数据库
                    [event setCalendar:[eventStore defaultCalendarForNewEvents]];
                    
                    NSError *error;
                    [eventStore saveEvent:event span:EKSpanThisEvent error:&error];
                    if (error) {
                        
                        NSLog(@"写入事件库出错：%@",error);
                    }
                }
            });
            
        }];
    }else{//这里是4和5的匹配
        //代码和上面一样
        
    }
}

+ (void)deleteEvent:(NSString *)startTime endTime:(NSString *)endTime identifier:(NSString *)identifier{
    [[self alloc]deleteEvent:startTime endTime:endTime identifier:identifier];
}
#pragma   删除加入的日历事件
- (void)deleteEvent:(NSString *)startTime endTime:(NSString *)endTime identifier:(NSString *)identifier{
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    EKEventStore *eventStore = appDelegate.eventStore;
    
    NSString *tempS = [self getDateStringAfterDays:-1 fromDate:[self dateFromString:startTime withFormatter:timeType]];
    NSString *tempE = [self getDateStringAfterDays:1 fromDate:[self dateFromString:endTime withFormatter:timeType]];
    
    NSDateFormatter *form = [NSDateFormatter new];
    [form setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    form.dateFormat = timeType;
    NSPredicate *predicate = [eventStore predicateForEventsWithStartDate:[form dateFromString:tempS] endDate:[form dateFromString:tempE] calendars:nil];
    
    NSArray *events = [eventStore eventsMatchingPredicate:predicate];
    for (EKEvent *event in events) {
        
        if ([event.notes isEqualToString:identifier]) {
            
            if ([eventStore removeEvent:event span:EKSpanFutureEvents error:nil]) {
                
                
            }
        }
    }
    
}

#pragma   时间字符串转时间  格式可以自己设置
- (NSDate *)dateFromString:(NSString *)string withFormatter:(NSString *)dateFormatter{
    NSDateFormatter * formatter = [NSDateFormatter new];
    formatter.dateFormat = dateFormatter;
    return [formatter dateFromString:string];
    
}

#pragma   字符串转时间


#pragma   后去若干天后的日期


- (NSString *)getDateStringAfterDays:(NSInteger)afterDays fromDate:(NSDate *)fromeDate{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *com = [NSDateComponents new];
    com.day = afterDays;
    NSDate *date = [calendar dateByAddingComponents:com toDate:fromeDate options:0];
    NSDateFormatter *form = [NSDateFormatter new];
    form.dateFormat = timeType;
    return [form stringFromDate:date];
}
@end








































