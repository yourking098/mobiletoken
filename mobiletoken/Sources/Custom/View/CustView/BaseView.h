//
//  BaseView.h
//  来店易
//
//  Created by u1city01 on 15/5/12.
//  Copyright (c) 2015年 u1city01. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseView : UIView

#pragma mark  线条

/**
 *  创建线条
 *
 *  @param frame 坐标
 *  @param color 颜色
 *
 *  @return UIView
 */
- (UIView*)buildLineView:(CGRect)frame color:(NSString*)color;

#pragma mark  图像

/**
 *  创建本地图片视图
 *
 *  @param frame     视图坐标
 *  @param imageName 本地图片名称
 *
 *  @return UIImageView
 */
- (UIImageView*)buildImageView:(CGRect)frame imageName:(NSString*)imageName;

/**
 *  创建本地图片视图
 *
 *  @param frame          视图坐标
 *  @param backgroupColor 背景颜色
 *
 *  @return UIImageView
 */
- (UIImageView*)buildImageView:(CGRect)frame backgroupColor:(NSString*)backgroupColor;

/**
 *  创建网络图片视图
 *
 *  @param frame    视图坐标
 *  @param imageUrl 图片网络地址
 *  @param defaultName 默认显示图片
 *
 *  @return UIImageView
 */
- (UIImageView*)buildImageView:(CGRect)frame imageUrl:(NSString*)imageUrl defaultName:(NSString*)defaultName;

#pragma mark  标签

/**
 *  创建文本显示视图
 *
 *  @param frame 坐标
 *  @param title 标题
 *  @param color 颜色
 *  @param font  自体
 *  @param align 格式
 *
 *  @return UILabel
 */
- (UILabel*)buildLabel:(CGRect)frame title:(NSString*)title color:(NSString*)color font:(UIFont*)font align:(NSTextAlignment)align;

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
- (UILabel*)buildLabel:(CGRect)frame title:(NSString*)title color:(NSString*)color font:(UIFont*)font align:(NSTextAlignment)align line:(int)line;

#pragma mark  按钮

/**
 *  创建按钮视图
 *
 *  @param frame     坐标
 *  @param imageName 图片
 *
 *  @return UIButton
 */
- (UIButton*)buildButton:(CGRect)frame imageName:(NSString*)imageName;

/**
 *  创建按钮视图
 *
 *  @param frame     坐标
 *  @param imageName 图片
 *  @param action    事件
 *
 *  @return UIButton
 */
- (UIButton*)buildButton:(CGRect)frame imageName:(NSString*)imageName action:(SEL)action;

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
- (UIButton*)buildButton:(CGRect)frame imageName:(NSString*)imageName inset:(UIEdgeInsets)inset action:(SEL)action;

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
- (UIButton*)buildButton:(CGRect)frame title:(NSString*)title backgroupColor:(NSString*)backgroupColor color:(NSString*)color font:(UIFont*)font action:(SEL)action;

@end
