//
//  UIView+QM_Category.h
//  JinHuaIPAD
//
//  Created by strongsoft on 14-7-3.
//  Copyright (c) 2014年 QiMeng_LYS. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN const CGFloat kFontOffset;

@interface UIView (QM_Category)

- (void)setX:(float)x;
- (void)setY:(float)y;
//- (void)setWidth:(float)width;
//- (void)setHeight:(float)height;
- (void)qm_setHeight:(float)height;
- (void)qm_setWidth:(float)width;

- (CGFloat)top;
- (CGFloat)bottom;
- (CGFloat)left;
- (CGFloat)right;
- (CGFloat)width;
- (CGFloat)height;

- (CGFloat)x;
- (CGFloat)y;

@end
