//
//  CalibrationTimeViewController.h
//  mobiletoken
//
//  Created by u1city01 on 15/6/27.
//  Copyright (c) 2015年 mobiletoken. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "HZDatePickerView.h"
#import "HZTimePickerView.h"
#import "CustomPopView.h"

@interface CalibrationTimeViewController : BaseViewController<CustomPopDelegate,NSURLConnectionDelegate>
@property (nonatomic, strong) CustomPopView *customView;
@property (nonatomic, strong) HZDatePickerView *datePicker;
@property (nonatomic, strong) HZTimePickerView *timePicker;

@end
