//
//  HZTimePickerView.m
//  areapicker
//
//  Created by Cloud Dai on 12-9-9.
//  Copyright (c) 2012年 clouddai.com. All rights reserved.
//

#import "HZTimePickerView.h"

@implementation HZTimePickerView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        
        //创建时间选择器
        _datePiker =[[UIDatePicker alloc] initWithFrame:CGRectMake(0,0, KSCREEN_WIDTH,frame.size.height)];
        _datePiker.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        _datePiker.datePickerMode = UIDatePickerModeTime;
        _datePiker.backgroundColor=[UIColor whiteColor];
//        NSString* timeStr = @"HH:mm:ss";
//        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//        [formatter setDateStyle:NSDateFormatterMediumStyle];//设置年月
//        //[formatter setTimeStyle:NSDateFormatterShortStyle];//设置时间 略
//        [formatter setDateFormat:@"HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
//        //设置时区
//        NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
//        [formatter setTimeZone:timeZone];
//        NSDate* dateLimit = [formatter dateFromString:timeStr]; //------------将字符串按formatter转成nsdate
//        NSDate *datenow = [NSDate date];
//        _datePiker.minimumDate = dateLimit;
//        _datePiker.maximumDate = datenow;
        [self addSubview:_datePiker];
    }
    return self;
}

@end
