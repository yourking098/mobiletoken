//
//  BaseView.m
//  来店易
//
//  Created by u1city01 on 15/5/12.
//  Copyright (c) 2015年 u1city01. All rights reserved.
//

#import "BaseView.h"
#import "ColorHelper.h"


@implementation BaseView

#pragma mark  线条

/**
 *  创建线条
 *
 *  @param frame 坐标
 *  @param color 颜色
 *
 *  @return UIView
 */
- (UIView*)buildLineView:(CGRect)frame color:(NSString*)color {
    UIView *lineView=[[UIView alloc] initWithFrame:frame];
    lineView.backgroundColor=[ColorHelper colorWithHexString:color];
    return lineView;
}

#pragma mark  图像

/**
 *  创建本地图片视图
 *
 *  @param frame     视图坐标
 *  @param imageName 本地图片名称
 *
 *  @return UIImageView
 */
- (UIImageView*)buildImageView:(CGRect)frame imageName:(NSString*)imageName {
    UIImageView *imageView=[[UIImageView alloc] initWithFrame:frame];
    imageView.image = [UIImage imageNamed:imageName];
    return imageView;
}

/**
 *  创建本地图片视图
 *
 *  @param frame          视图坐标
 *  @param backgroupColor 背景颜色
 *
 *  @return UIImageView
 */
- (UIImageView*)buildImageView:(CGRect)frame backgroupColor:(NSString*)backgroupColor {
    UIImageView *imageView=[[UIImageView alloc] initWithFrame:frame];
    imageView.backgroundColor = [ColorHelper colorWithHexString:backgroupColor];
    return imageView;
}

/**
 *  创建网络图片视图
 *
 *  @param frame    视图坐标
 *  @param imageUrl 图片网络地址
 *  @param defaultName 默认显示图片
 *
 *  @return UIImageView
 */
- (UIImageView*)buildImageView:(CGRect)frame imageUrl:(NSString*)imageUrl defaultName:(NSString*)defaultName {
    UIImageView *imageView=[[UIImageView alloc] initWithFrame:frame];
    [imageView setImage:[UIImage imageNamed:defaultName]];
    return imageView;
}

#pragma mark  标签

/**
 *  创建文本显示视图
 *
 *  @param frame 坐标
 *  @param title 标题
 *  @param color 字体颜色
 *  @param font  字体样式
 *  @param align 格式
 *
 *  @return UILabel
 */
- (UILabel*)buildLabel:(CGRect)frame title:(NSString*)title color:(NSString*)color font:(UIFont*)font align:(NSTextAlignment)align {
    UILabel *labelView=[[UILabel alloc] initWithFrame:frame];
    if (title!=nil&&(NSNull*)title!=[NSNull null]) {
        labelView.text=title;
    }
    labelView.textColor=[ColorHelper colorWithHexString:color];
    labelView.backgroundColor=[UIColor clearColor];
    labelView.textAlignment=align;
    labelView.font=font;
    return labelView;
}

/**
 *  创建多行文本显示视图
 *
 *  @param frame 坐标
 *  @param title 标题
 *  @param color 字体颜色
 *  @param font  字体样式
 *  @param align 格式
 *  @param line  文本行数
 *
 *  @return UILabel
 */
- (UILabel*)buildLabel:(CGRect)frame title:(NSString*)title color:(NSString*)color font:(UIFont*)font align:(NSTextAlignment)align line:(int)line {
    UILabel *labelView=[[UILabel alloc] initWithFrame:frame];
    if (title!=nil&&(NSNull*)title!=[NSNull null]) {
        labelView.text=title;
    }
    labelView.textColor=[ColorHelper colorWithHexString:color];
    labelView.backgroundColor=[UIColor clearColor];
    labelView.textAlignment=align;
    labelView.numberOfLines=line;
    labelView.font=font;
    return labelView;
}

#pragma mark  按钮

/**
 *  创建按钮视图
 *
 *  @param frame     坐标
 *  @param imageName 图片
 *
 *  @return UIButton
 */
- (UIButton*)buildButton:(CGRect)frame imageName:(NSString*)imageName {
    return [self buildButton:frame imageName:imageName inset:UIEdgeInsetsMake(0, 0, 0, 0) action:nil];
}

/**
 *  创建按钮视图
 *
 *  @param frame     坐标
 *  @param imageName 图片
 *  @param action    事件
 *
 *  @return UIButton
 */
- (UIButton*)buildButton:(CGRect)frame imageName:(NSString*)imageName action:(SEL)action {
    return [self buildButton:frame imageName:imageName inset:UIEdgeInsetsMake(0, 0, 0, 0) action:action];
}

/**
 *  创建按钮视图
 *
 *  @param frame     坐标
 *  @param imageName 图片
 *  @param inset     内间距
 *  @param action    事件
 *
 *  @return UIButton
 */
- (UIButton*)buildButton:(CGRect)frame imageName:(NSString*)imageName inset:(UIEdgeInsets)inset action:(SEL)action {
    UIButton *button= [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=frame;
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setImageEdgeInsets:inset];
    if (action != nil) {
        [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    }
    return button;
}

/**
 *  创建按钮视图
 *
 *  @param frame          坐标
 *  @param title          标题
 *  @param backgroupColor 背景色
 *  @param color          字体颜色
 *  @param font           字体样式
 *  @param action         事件
 *
 *  @return UIButton
 */
- (UIButton*)buildButton:(CGRect)frame title:(NSString*)title backgroupColor:(NSString*)backgroupColor color:(NSString*)color font:(UIFont*)font action:(SEL)action {
    UIButton *button= [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=frame;
    button.backgroundColor = [ColorHelper colorWithHexString:backgroupColor];
    button.titleLabel.font = font;
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    button.layer.cornerRadius = 10*SCALAE;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[ColorHelper colorWithHexString:color] forState:UIControlStateNormal];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}


@end
