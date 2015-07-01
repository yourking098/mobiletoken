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
        [self addSubview:_datePiker];
    }
    return self;
}

@end
