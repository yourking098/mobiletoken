//
//  UIView+QM_Category.m
//  JinHuaIPAD
//
//  Created by strongsoft on 14-7-3.
//  Copyright (c) 2014年 QiMeng_LYS. All rights reserved.
//

#import "UIView+QM_Category.h"
const CGFloat kFontOffset = 3.0;

@implementation UIView (QM_Category)

- (void)setX:(float)x
{
    self.frame = CGRectMake(x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}
- (void)setY:(float)y
{
    self.frame = CGRectMake(self.frame.origin.x, y, self.frame.size.width, self.frame.size.height);
}

- (void)qm_setWidth:(float)width
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, self.frame.size.height);
}
- (void)qm_setHeight:(float)height
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height);
}

- (CGFloat)y{
    return self.frame.origin.y;
}

- (CGFloat)top
{
    return self.frame.origin.y;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)left
{
    return self.frame.origin.x;
}

- (CGFloat)bottom
{
    return self.top + self.height;
}

- (CGFloat)right
{
    return self.left + self.width;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (CGFloat)height
{
    return self.frame.size.height;
}



@end
