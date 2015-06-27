//
//  AesHelper.m
//  TaoShop
//
//  Created by u1city01 on 14-7-30.
//  Copyright (c) 2014年 u1city01. All rights reserved.
//

#import "AesHelper.h"
#import <CommonCrypto/CommonCryptor.h>
#import "NSString+Base64.h"

/*!
 * 商城客户编码加密密钥
 */
#define gkey @"u1city.net201404"

/*!
 * DES加密密钥
 */
#define ikey @"!@#ASD12"

@implementation AesHelper

/*!
 * AES加密，返回base64编码
 */
+ (NSString *)encrypt:(NSString *)plaintext {
    char keyPtr[kCCKeySizeAES128+1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [gkey getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    char ivPtr[kCCBlockSizeAES128+1];
    memset(ivPtr, 0, sizeof(ivPtr));
    ivPtr[0] = 0x19;
    ivPtr[1] = 0x34;
    ivPtr[2] = 0x56;
    ivPtr[3] = 0x78;
    ivPtr[4] = (Byte)0x90;
    ivPtr[5] = (Byte)0xAB;
    ivPtr[6] = (Byte)0xCD;
    ivPtr[7] = (Byte)0xEF;
    ivPtr[8] = 0x12;
    ivPtr[9] = 0x34;
    ivPtr[10] = 0x56;
    ivPtr[11] = 0x78;
    ivPtr[12] = (Byte)0x90;
    ivPtr[13] = (Byte)0xAB;
    ivPtr[14] = (Byte)0xCD;
    ivPtr[15] = (Byte)0xEF;
    
    NSData* data = [plaintext dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [data length];
    char dataPtr[dataLength];
    memcpy(dataPtr, [data bytes], [data length]);
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    memset(buffer, 0, bufferSize);
    
    size_t numBytesCrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding,               //No padding
                                          keyPtr,
                                          kCCKeySizeAES128,
                                          ivPtr,
                                          dataPtr,
                                          sizeof(dataPtr),
                                          buffer,
                                          bufferSize,
                                          &numBytesCrypted);
    
    if (cryptStatus == kCCSuccess) {
        NSData *resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
        NSString *base64EncodedString = [NSString base64StringFromData:resultData length:(int)[resultData length]];
        return base64EncodedString;
    }
    free(buffer);
    return nil;
}

/*!
 * DES加密
 */
+ (NSString *)encryptWithText:(NSString *)plaintext
{
    //kCCEncrypt 加密
    return [self encrypt:plaintext encryptOrDecrypt:kCCEncrypt key:ikey];
}

/*!
 * DES解密
 */
+ (NSString *)decryptWithText:(NSString *)plaintext
{
    //kCCDecrypt 解密
    return [self encrypt:plaintext encryptOrDecrypt:kCCDecrypt key:ikey];
}

/*!
 * DES加密解密方法
 */
+ (NSString *)encrypt:(NSString *)plaintext encryptOrDecrypt:(CCOperation)encryptOperation key:(NSString *)key
{
    const void *dataIn;
    size_t dataInLength;
    
    if (encryptOperation == kCCDecrypt)//传递过来的是decrypt解码
    {
        NSData *decryptData = [plaintext dataUsingEncoding:NSUTF8StringEncoding];
        dataInLength = [decryptData length];
        dataIn = [decryptData bytes];
    }
    else  //encrypt
    {
        NSData* encryptData = [plaintext dataUsingEncoding:NSUTF8StringEncoding];
        dataInLength = [encryptData length];
        dataIn = (const void *)[encryptData bytes];
    }
    
    /*
     DES加密 ：用CCCrypt函数加密一下
     DES解密 ：用CCCrypt函数解密，得到原本的数据
     */
    CCCryptorStatus ccStatus;
    uint8_t *dataOut = NULL; //可以理解位type/typedef 的缩写（有效的维护了代码，比如：一个人用int，一个人用long。最好用typedef来定义）
    size_t dataOutAvailable = 0; //size_t  是操作符sizeof返回的结果类型
    size_t dataOutMoved = 0;
    
    dataOutAvailable = (dataInLength + kCCBlockSizeDES) & ~(kCCBlockSizeDES - 1);
    dataOut = malloc( dataOutAvailable * sizeof(uint8_t));
    memset((void *)dataOut, 0x0, dataOutAvailable);//将已开辟内存空间buffer的首 1 个字节的值设为值 0
    
    NSString *initIv = ikey;
    const void *vkey = (const void *) [key UTF8String];
    const void *iv = (const void *) [initIv UTF8String];
    
    //CCCrypt函数 加密/解密
    ccStatus = CCCrypt(encryptOperation,//  加密/解密
                       kCCAlgorithmDES,//  加密根据哪个标准（des，3des，aes。。。。）
                       kCCOptionPKCS7Padding,//  选项分组密码算法(des:对每块分组加一次密  3DES：对每块分组加三个不同的密)
                       vkey,  //密钥    加密和解密的密钥必须一致
                       kCCKeySizeDES,//   DES 密钥的大小（kCCKeySizeDES=8）
                       iv, //  可选的初始矢量
                       dataIn, // 数据的存储单元
                       dataInLength,// 数据的大小
                       (void *)dataOut,// 用于返回数据
                       dataOutAvailable,
                       &dataOutMoved);
    
    NSString *result = nil;
    
    if (encryptOperation == kCCDecrypt)//encryptOperation==1  解码
    {
        //得到解密出来的data数据，改变为utf-8的字符串
        result = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)dataOut length:(NSUInteger)dataOutMoved] encoding:NSUTF8StringEncoding];
    }
    else //encryptOperation==0  （加密）
    {
        NSData *data = [NSData dataWithBytes:(const void *)dataOut length:(NSUInteger)dataOutMoved];
        NSMutableString *eStr = [[NSMutableString alloc] initWithCapacity:1];
        const unsigned char *p = [data bytes];
        int len = (int)[data length];
        for (int i=0;i<len;i++)
        {
            [eStr appendFormat:@"%02X", *p++];
        }
        result = [NSString stringWithString:eStr];
    }
    return result;
}

/*!
 * md5加密
 */
+ (NSString *)md5:(NSString *)str
{
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    const char *cStr = [str cStringUsingEncoding:enc];
    CC_MD5(cStr, strlen(cStr), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i=0; i< 16; i++)
    {
        [hash appendFormat:@"%02X", result[i]];
    }
    return [hash lowercaseString];
}

+ (NSString *)newMD5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}

/*!
 * 将URL编码
 */
+ (NSString *)encodeToPercentEscapeString:(NSString *)input
{
    return CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)input, NULL, (CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8));
}

/*!
 * 将URL解码
 */
+ (NSString *)decodeFromPercentEscapeString:(NSString *)input
{
    NSMutableString *outputStr = [NSMutableString stringWithString:input];
    [outputStr replaceOccurrencesOfString:@"+" withString:@" " options:NSLiteralSearch range:NSMakeRange(0, [outputStr length])];
    return [outputStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

@end
