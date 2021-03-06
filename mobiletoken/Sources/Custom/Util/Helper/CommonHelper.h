//
//  CommonHelper.h
//  峰小店
//
//  Created by u1city01 on 15-3-19.
//  Copyright (c) 2015年 u1city01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonHelper : NSObject

#pragma mark - 数据格式化
+ (NSString*)stringDataFormatWithDict:(id)value;

+ (NSNumber*)numberDataFormatWithDict:(id)value;

+ (NSString*)floatDataFormatWithDict:(id)value;

#pragma mark - 日期比较
+ (int)compareDate:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay;

#pragma mark - 时间格式转换 显示 年.月.日
+ (NSString*)timeFormatConversionWithPoint:(NSString *)dateTime;

#pragma mark - 时间格式转换  当天显示为时:分 超过当天的显示为 月-日
+ (NSString*)timeFormatConversion:(NSString*)dateTime;


#pragma mark - 时间格式转换 当天显示为时:分 超过今天则显示 几天前，几个月前，几年前
+ (NSString*)timeFormatConversionBefore:(NSString*)dateTime;

#pragma mark - 时间格式转换 统一显示为 月-日 时-分
+ (NSString*)timeFormatConversionWithAllButYear:(NSString *)dateTime;


#pragma mark - 获取当前App版本号
+(NSString *)getCurrentAppVersion;


#pragma mark - 添加字典页面缓存  NSDictionary
+(void) saveCacheByName:(NSString *)coachName andCacheData:(NSDictionary*) dictCacheData;
#pragma mark - 获取字典页面缓存数据 NSDictionary
+(NSDictionary *) getCacheByName:(NSString *)coachName;


#pragma mark - 添加数组页面缓存 NSMutableArray
+(void) insertCacheDataByName:(NSString *)coachName andCacheData:(NSMutableArray*) arryData;
#pragma mark - 获取数组页面缓存数据 NSMutableArray
+(NSMutableArray *) getArrayCacheDataByName:(NSString *)coachName;


/*!
 * @method 字符串转成32位数字序列号。数字字母ASCII是两位，这边只取个位。
 * @param  singleUidCode 手机唯一码产生
 * @result 生成一个纯32位数字序列号
 */
+(NSString *) stringToSingleNum:(NSString *)singleUidCode;

/*!
 * @method 获取长字符串固定长度的短字符串。
 * @param  serialCode 一个纯32位数字序列号
 * @result 生成一个纯32位数字序列号
 */
+(NSString *) shortString:(NSString *)serialCode andLength:(NSUInteger)len;

/*!
 * @method 交叉合并两个字符串
 *
 * @result 生成一个纯32位数字序列号
 */
+(NSString *) avgMergeStr:(NSString *)str1 andStr2:(NSString *)str2;

/**
 *  时间转换
 *  @param inputDate 输入时间
 *  @return 返回时间
 */
+ (NSDate*)timeWithinEraFromDate:(NSDate*)inputDate;

@end
