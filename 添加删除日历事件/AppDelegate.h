//
//  AppDelegate.h
//  添加删除日历事件
//
//  Created by Detrum on 17/3/7.
//  Copyright © 2017年 Detrum-yangmin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EventKit/EventKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

//***日历事件****
@property (nonatomic, strong)  EKEventStore*eventStore;

@end

