//
//  PlistHelper.h
//  TaoShop
//
//  Created by u1city01 on 14-7-30.
//  Copyright (c) 2014年 u1city01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomerModel.h"

@interface PlistHelper : NSObject

/*!
 * 更新用户信息
 */
+ (BOOL)updateCust:(CustomerModel*)cust;

/*!
 * 查询用户信息
 */
+ (CustomerModel*)selectCust;

/*!
 * 删除用户信息
 */
+ (BOOL)deleteCust;

@end
