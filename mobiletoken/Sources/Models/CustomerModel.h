//
//  CustomerModel.h
//  TaoShop
//
//  Created by u1city01 on 14-7-30.
//  Copyright (c) 2014年 u1city01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface CustomerModel : NSObject

@property(strong,nonatomic)NSString *serialNumber;       //有"-"序列号，用来页面展示
@property(strong,nonatomic)NSString *realSerialNumber;   //无"-"序列号，用来生成验证码
@property(strong,nonatomic)NSString *second;  //手机令牌时间与北京时时区的误差

-(id)initWithDict:(NSDictionary *)dict;//构造方法

@end
