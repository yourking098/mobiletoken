//
//  PlistHelper.m
//  TaoShop
//
//  Created by u1city01 on 14-7-30.
//  Copyright (c) 2014年 u1city01. All rights reserved.
//

#import "PlistHelper.h"
#import "AesHelper.h"

@implementation PlistHelper

/*!
 * 更新用户信息
 */
+ (BOOL)updateCust:(CustomerModel*)cust
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *plistPath = [path stringByAppendingPathComponent:@"cust.plist"];
    
    //根据路径获取cust.plist的全部内容
    NSMutableDictionary *info = [[[NSMutableDictionary alloc] initWithContentsOfFile:plistPath] mutableCopy];
    
    [info setValue:cust.serialNumber forKey:@"SerialNumber"];
    [info setValue:cust.realSerialNumber forKey:@"RealSerialNumber"];
    [info setValue:cust.second forKey:@"Second"];
    //更新
    [info writeToFile:plistPath atomically:YES];
    
    return YES;
}

/*!
 * 查询用户信息
 */
+ (CustomerModel*)selectCust
{
    CustomerModel *cust = nil;
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *plistPath = [path stringByAppendingPathComponent:@"cust.plist"];
    
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    if (![fileManager fileExistsAtPath:plistPath]) {
        if(![fileManager createFileAtPath:plistPath contents:nil attributes:nil]) {
            //NSLog(@"create file error");
        }
        else {
            //根据路径获取cust.plist的全部内容
            NSMutableDictionary *info = [[NSMutableDictionary alloc] init];
            [info writeToFile:plistPath atomically:YES];
            cust = [[CustomerModel alloc] init];
        }
    }
    else {
        //根据路径获取cust.plist的全部内容
        NSMutableDictionary *infolist = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
        
        cust = [[CustomerModel alloc] initWithDict:infolist];
    }
    return cust;
}

/*!
 * 删除用户信息
 */
+ (BOOL)deleteCust
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *plistPath = [path stringByAppendingPathComponent:@"cust.plist"];
    
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    if ([fileManager fileExistsAtPath:plistPath]) {
        [fileManager removeItemAtPath:plistPath error:nil];
    }
    
    return YES;
}

@end
