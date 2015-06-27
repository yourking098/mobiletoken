//
//  NSString+Base64.h
//  minishop
//
//  Created by u1city01 on 14-5-23.
//  Copyright (c) 2014年 yjp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Base64Additions)
+ (NSString *)base64StringFromData:(NSData *)data length:(int)length;
@end
