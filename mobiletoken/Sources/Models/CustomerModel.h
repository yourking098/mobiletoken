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
@property(strong,nonatomic)NSString *serialNumber;   //序列号

-(id)initWithDict:(NSDictionary *)dict;//构造方法

@end
