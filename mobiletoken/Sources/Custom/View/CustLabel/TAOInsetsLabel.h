//
//  UIInsetsLabel.h
//  淘小店
//
//  Created by u1city01 on 14-7-24.
//  Copyright (c) 2014年 yjp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TAOInsetsLabel : UILabel
@property(nonatomic) UIEdgeInsets insets;

- (id)initWithFrame:(CGRect)frame andInsets:(UIEdgeInsets) insets;
- (id)initWithInsets:(UIEdgeInsets) insets;

@end
