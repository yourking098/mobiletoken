//
//  HomeViewController.h
//  mobiletoken
//
//  Created by u1city01 on 15/6/24.
//  Copyright (c) 2015年 mobiletoken. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "EFCircularSlider.h"

@interface HomeViewController : BaseViewController{
    NSTimer *_timer;
}

@property(nonatomic,strong) UILabel *lblCheckCode;
@property(nonatomic,strong) EFCircularSlider *circularSlider;

@end
