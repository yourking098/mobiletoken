//
//  AppMacro.h
//  mobiletoken
//
//  Created by u1city01 on 15/6/24.
//  Copyright (c) 2015年 mobiletoken. All rights reserved.
//  系统相关的宏定义

#ifndef TaoShop_AppMacro_h
#define TaoShop_AppMacro_h

#ifndef __QQAPI_ENABLE__
#define __QQAPI_ENABLE__ 1
#endif

/*!
 * SDK版本
 */
#define IOSVersion       [[[UIDevice currentDevice] systemVersion] floatValue]
#define IsiOS7Later      !(IOSVersion < 7.0)
#define IsiOS71Later     !(IOSVersion <= 7.0)
#define IsiOS8Later      !(IOSVersion < 8.0)

#endif