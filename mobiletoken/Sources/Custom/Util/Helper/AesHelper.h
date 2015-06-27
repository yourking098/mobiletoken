//
//  AesHelper.h
//  TaoShop
//
//  Created by u1city01 on 14-7-30.
//  Copyright (c) 2014年 u1city01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface AesHelper : NSObject

/*!
 * AES加密，返回base64编码
 */
+ (NSString *)encrypt:(NSString *)plaintext;

/*!
 * DES加密
 */
+ (NSString *)encryptWithText:(NSString *)plaintext;

/*!
 * DES解密
 */
+ (NSString *)decryptWithText:(NSString *)plaintext;

/*!
 * md5加密
 */
+ (NSString *)md5:(NSString *)str;

+ (NSString *)newMD5:(NSString *)str;

/*!
 * 将URL编码
 */
+ (NSString *)encodeToPercentEscapeString:(NSString *)input;

/*!
 * 将URL解码
 */
+ (NSString *)decodeFromPercentEscapeString:(NSString *)input;

@end
