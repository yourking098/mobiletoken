//
//  SerialNumberViewController.h
//  mobiletoken
//
//  Created by u1city01 on 15/6/27.
//  Copyright (c) 2015年 mobiletoken. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface SerialNumberViewController : BaseViewController


@property(nonatomic,strong) UILabel *lblSerialNum;

@property(nonatomic,assign) int pageType;//0启动页进入   1-设置页面进入

@end
