//
//  ColorHelper.h
//  TaoShop
//
//  Created by u1city01 on 14-7-30.
//  Copyright (c) 2014年 u1city01. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface ColorHelper : NSObject

#pragma mark - 颜色转换 IOS中十六进制的颜色转换为UIColor
+ (UIColor*)colorWithHexString:(NSString*)color;

@end
