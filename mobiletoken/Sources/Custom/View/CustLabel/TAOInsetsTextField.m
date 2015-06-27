//
//  TAOInsetsTextField.m
//  来店易
//
//  Created by u1city03 on 15-5-17.
//  Copyright (c) 2015年 u1city01. All rights reserved.
//

#import "TAOInsetsTextField.h"

@implementation TAOInsetsTextField


//控制 placeHolder 的位置，左右缩 20
- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset( bounds , 30*SCALAE , 0 );
}

// 控制文本的位置，左右缩 20
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset( bounds , 30*SCALAE , 0 );
}

@end
