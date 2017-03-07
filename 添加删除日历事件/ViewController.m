//
//  ViewController.m
//  添加删除日历事件
//
//  Created by Detrum on 17/3/7.
//  Copyright © 2017年 Detrum-yangmin. All rights reserved.
//

#import "ViewController.h"

#import "CalenderEvent.h"
#import "NSDate+Category.h"
@interface ViewController ()

//****button****
@property (nonatomic, weak) UIButton *addButton;
@end

@implementation ViewController

//ios 10 之后在plist  添加  Privacy - Calendars Usage Description
- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setupUI];
}

- (void)setupUI{
    
    UIButton *button = [[UIButton alloc] init];
    
    [button setTitle:@"点击加入事件" forState:UIControlStateNormal];
    
    CGRect frame = CGRectMake(30, 100, self.view.frame.size.width - 60, 40);
    button.frame = frame;
    
    [button setBackgroundColor: [UIColor greenColor]];
    
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    
    [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    
    self.addButton = button;
}


- (void)clickButton:(UIButton *)button{
    
    NSDate *nowDate = [NSDate new];
    
    NSString *affterDate = [nowDate zj_getDateAfterMins:1 dateFormat:@"yyyy-MM-dd HH:mm"];
    NSLog(@"%@",affterDate);
    [CalenderEvent initWithTitle:@"日历测试" identifider:@"test" startTime:affterDate endTime:affterDate location:nil noticeFireTime:0 noticeEndTime:0];
}
@end

























