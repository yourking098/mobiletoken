//
//  CommonHelper.m
//  峰小店
//
//  Created by u1city01 on 15-3-19.
//  Copyright (c) 2015年 u1city01. All rights reserved.
//

#import "CommonHelper.h"

@implementation CommonHelper

#pragma mark - 数据格式化
+ (NSString*)stringDataFormatWithDict:(id)value {
    NSString *strValue=@"";
    if (value!=nil&&value!=[NSNull null]) {
        strValue=value;
    }
    return strValue;
}

+ (NSNumber*)numberDataFormatWithDict:(id)value {
    NSNumber *strValue=[NSNumber numberWithInt:0];
    if (value!=nil&&value!=[NSNull null]) {
        strValue=value;
    }
    return strValue;
}

+ (NSString*)floatDataFormatWithDict:(id)value {
    NSString *strValue=@"0.00";
    if (value!=nil&&value!=[NSNull null]) {
        strValue=[NSString stringWithFormat:@"%.2lf",[value floatValue]];
    }
    return strValue;
}

#pragma mark - 时间格式转换 显示 年.月.日
+ (NSString*)timeFormatConversionWithPoint:(NSString *)dateTime {
    NSString *tempStr = @"";
    if (dateTime!=nil&&(NSNull*)dateTime!=[NSNull null]&&![dateTime isEqualToString:@""]) {
        NSArray *dateArray=[dateTime componentsSeparatedByString:@"-"];
        for (NSString *str in dateArray) {
            if ([tempStr isEqualToString:@""]) {
                tempStr = str;
            }
            else{
                tempStr = [NSString stringWithFormat:@"%@.%@",tempStr,str];
            }
        }
    }
    return tempStr;
}

#pragma mark - 日期比较
+ (int)compareDate:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];
    NSLog(@"date1 : %@, date2 : %@", oneDay, anotherDay);
    if (result == NSOrderedDescending) {
        //oneDay日期大于anotherDay
        //
        return 1;
    }
    else if (result == NSOrderedAscending){
        //oneDay日期小于anotherDay
        return -1;
    }
    //日期相同
    return 0;
}

#pragma mark - 时间格式转换 显示 月-日 时-分
+ (NSString*)timeFormatConversionWithAllButYear:(NSString *)dateTime {
    //直接截取字符串。
    NSString *monthStr=@"";
    if (dateTime!=nil&&![dateTime isEqualToString:@""]) {
        monthStr=[NSString stringWithFormat:@"%@",dateTime];
        //先去除年份
        monthStr=[monthStr substringFromIndex:5];
        //再去除秒
        monthStr=[monthStr substringToIndex:11];
    }
    return monthStr;
}

#pragma mark - 时间格式转换  当天显示为时:分 超过当天的显示为 月-日
+ (NSString*)timeFormatConversion:(NSString*)dateTime {
    //创建日期格式化对象
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //创建了两个日期对象
    NSDate *lastDate=[dateFormatter dateFromString:dateTime];//上一个时间
    NSString *strLastDate = [dateFormatter stringFromDate:lastDate];
    NSString *strNowDate = [dateFormatter stringFromDate:[NSDate date]];
    
    NSArray *arrNow=[strNowDate componentsSeparatedByString:@" "];
    NSArray *arrLastDate=[strLastDate componentsSeparatedByString:@" "];
    if (arrNow.count==2&&arrLastDate.count==2) {
        NSString *strCompareLastDate=@"";
        NSString *strCompareNowDate=@"";
        
        strCompareLastDate=arrLastDate[0];
        strCompareNowDate=arrNow[0];
        if ([strCompareLastDate isEqualToString:strCompareNowDate]) {//如果两个日期相等，则返回发布的具体 时：分
            NSString *dateStr = arrLastDate[1];
            NSArray *dateHM=[dateStr componentsSeparatedByString:@":"];
            if (dateHM.count==3) {
                NSString *strDateHM=[NSString stringWithFormat:@"%@:%@",dateHM[0],dateHM[1]];
                return strDateHM;
            }else{
                return dateStr;
            }
        } else {
            NSString *strYearMonthDay=arrLastDate[0];
            NSArray *arrayMonthDay=[strYearMonthDay componentsSeparatedByString:@"-"];
            if (arrayMonthDay.count==3) {
                NSString *strMonthDay=[NSString stringWithFormat:@"%@-%@",arrayMonthDay[1],arrayMonthDay[2]];
                return strMonthDay;
            }else{
                return @"";
            }
        }
    }else{
        return @"";
    }
}

#pragma mark - 时间格式转换 当天显示为时:分 超过今天则显示 几天前，几个月前，几年前
+ (NSString*)timeFormatConversionBefore:(NSString*)dateTime{
    //创建日期格式化对象
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //创建了两个日期对象
    NSDate *lastDate=[dateFormatter dateFromString:dateTime];//上一个时间
    NSString *strLastDate = [dateFormatter stringFromDate:lastDate];
    NSString *strNowDate = [dateFormatter stringFromDate:[NSDate date]];
    NSDate *dateNow=[dateFormatter dateFromString:strNowDate];//现在的时间
    NSTimeInterval time=[dateNow timeIntervalSinceDate:lastDate];
    int days=((int)time)/(3600*24);//天
    int hours=((int)time)/3600;//小时
    int minu=((int)time)/60;//分钟
    
    NSString *strCompareLastDate=@"";
    NSString *strCompareNowDate=@"";
    
    NSArray *arrNow=[strNowDate componentsSeparatedByString:@" "];
    NSArray *arrLastDate=[strLastDate componentsSeparatedByString:@" "];
    if (arrNow.count==2&&arrLastDate.count==2) {
        strCompareLastDate=arrLastDate[0];
        strCompareNowDate=arrNow[0];
        if ([strCompareLastDate isEqualToString:strCompareNowDate]) {//如果两个日期相等，则返回发布的具体 时：分
            NSString *dateStr = arrLastDate[1];
            NSArray *dateHM=[dateStr componentsSeparatedByString:@":"];
            if (dateHM.count==3) {
                NSString *strDateHM=[NSString stringWithFormat:@"%@:%@",dateHM[0],dateHM[1]];
                return strDateHM;
            }else{
                return dateStr;
            }
        } else {
            if (days>0) {//跨天
                int month=days/30;//月
                int year=days/365;//年
                if(year>0){
                    return [NSString stringWithFormat:@"%d年前",year];
                }else{
                    if (month>0) {
                        return [NSString stringWithFormat:@"%d个月前",month];
                    }else{
                        return [NSString stringWithFormat:@"%d天前",days];
                    }
                }
            } else {//按具体时间计算
                //未跨天，小时计算
                if (hours>0) {
                    return [NSString stringWithFormat:@"%d小时前",hours];
                }else{
                    int iDisti=minu/5;
                    if (iDisti>0) {
                        return [NSString stringWithFormat:@"%d分钟前",iDisti*5];
                    }else{
                        return @"刚刚";
                    }
                }
            }
        }
    }else{
        return @"";
    }
}



#pragma mark - 获取当前App版本号
+(NSString *)getCurrentAppVersion{
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = [infoDic objectForKey:@"CFBundleVersion"];
    return currentVersion;
}


#pragma mark - 添加页面缓存
+(void) saveCacheByName:(NSString *)coachName andCacheData:(NSDictionary*) dictData{
    //转换为NSData
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:dictData forKey:coachName];
    [archiver finishEncoding];
    
    //本地保存NSData数据
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    [defaults setObject:data forKey:coachName];
    [defaults synchronize];
}

#pragma mark - 获取页面缓存数据
+(NSDictionary *) getCacheByName:(NSString *)coachName{
    //查询本地数据
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSMutableData *dicData = [defaults objectForKey:coachName];//根据键值取出数据
    
    //转换为NSDictionary
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:dicData];
    NSDictionary *dict = [unarchiver decodeObjectForKey:coachName];
    [unarchiver finishDecoding];
    return dict;
}


#pragma mark - 添加页面缓存 NSMutableArray
+(void) insertCacheDataByName:(NSString *)coachName andCacheData:(NSMutableArray*) arryData{
    //转换为NSData
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:arryData forKey:coachName];
    [archiver finishEncoding];
    
    //本地保存NSData数据
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    [defaults setObject:data forKey:coachName];
    [defaults synchronize];
}
#pragma mark - 获取页面缓存数据 NSMutableArray
+(NSMutableArray *) getArrayCacheDataByName:(NSString *)coachName{
    //查询本地数据
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSMutableData *dicData = [defaults objectForKey:coachName];//根据键值取出数据
    
    //转换为NSDictionary
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:dicData];
    NSMutableArray *dataArray = [unarchiver decodeObjectForKey:coachName];
    [unarchiver finishDecoding];
    return dataArray;
}


@end
