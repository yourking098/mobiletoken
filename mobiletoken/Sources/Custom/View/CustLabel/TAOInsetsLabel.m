//
//  UIInsetsLabel.m
//  淘小店
//
//  Created by u1city01 on 14-7-24.
//  Copyright (c) 2014年 yjp. All rights reserved.
//

#import "TAOInsetsLabel.h"

@implementation TAOInsetsLabel

@synthesize insets = _insets;

- (id)initWithFrame:(CGRect)frame andInsets:(UIEdgeInsets)insets {
    self = [super initWithFrame:frame];
    if(self) {
        self.insets = insets;
    }
    return self;
}

- (id)initWithInsets:(UIEdgeInsets)insets {
    self = [super init];
    if(self) {
        self.insets = insets;
    }
    return self;
}

- (void)drawTextInRect:(CGRect)rect {
    return [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.insets)];
}

@end
