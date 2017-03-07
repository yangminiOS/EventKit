//
//  CalenderEvent.h
//  添加删除日历事件
//
//  Created by Detrum on 17/3/7.
//  Copyright © 2017年 Detrum-yangmin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalenderEvent : NSObject


/*
 *title            添加日历事件的标题
 *identififer      日历事件的唯一标识  方便查找或者删除
 *startTime        开始时间
 *endTime          结束时间
 *location         事件地址
 *fireTime         闹铃开始时间
 *endTime          闹铃结束时间
 */

+ (void)initWithTitle:(NSString *) title identifider:(NSString *)identifider startTime:(NSString *)startTime endTime:(NSString *)endTime location:(NSString *)location noticeFireTime:(double)fireT noticeEndTime:(double)endT;

/*
 *删除日历事件
 *startTime   日历事件开始时间
 *endTime     日历事件结束时间
 *idetifier   日历事件唯一标识
 */

+ (void)deleteEvent:(NSString *)startTime endTime:(NSString *)endTime identifier:(NSString *)identifier;
@end
