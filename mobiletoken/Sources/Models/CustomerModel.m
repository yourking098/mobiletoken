//
//  CustomerModel.m
//  TaoShop
//
//  Created by u1city01 on 14-7-30.
//  Copyright (c) 2014年 u1city01. All rights reserved.
//

#import "CustomerModel.h"
#import "AesHelper.h"

@implementation CustomerModel

//构造方法
-(id) initWithDict:(NSDictionary *)dict{
    if (self=[super init]) {
        self.serialNumber = dict[@"SerialNumber"];
        self.realSerialNumber = dict[@"RealSerialNumber"];
        self.second = dict[@"Second"];
    }
    return self;
}

@end
