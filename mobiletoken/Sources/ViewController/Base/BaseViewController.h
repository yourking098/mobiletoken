//
//  BaseViewController.h
//  TaoShop
//
//  Created by u1city01 on 14-7-29.
//  Copyright (c) 2014年 u1city01. All rights reserved.
//  页面基础类

#import <UIKit/UIKit.h>
#import "TAONavigationBar.h"
#import "UIEngine.h"
#import "ColorHelper.h"
#import "MBProgressHUD.h"
#import "TAOCopyLabel.h"
#import "UIView+QM_Category.h"
#import "CustomerModel.h"
#import "BaseView.h"

@interface BaseViewController : UIViewController<MBProgressHUDDelegate, UITextFieldDelegate, NavigationItemDelegate,UIAlertViewDelegate> {
    CustomerModel *_cust;
    MBProgressHUD *HUD;
    UIView *_loadingMaskView;
    CGFloat _textOfTopViewHeight;
    
    NSString *shareId;//分享id
    NSString *shareTitle;//分享标题
    NSString *shareSummary;//分享内容
    NSString *shareImage;//分享图标地址
    NSString *shareUrl;//分享URL地址
    NSString *shareFrom;//分享来自于 0-商品 1-资讯
    
    NSMutableArray *shareButtonTitleArray;
    NSMutableArray *shareButtonImageNameArray;
    
    UIView *baseAlertView;
}
@property(strong, nonatomic) TAONavigationBar *navbar;
@property(strong, nonatomic) UIControl *childView;
@property(strong,nonatomic) TAOCopyLabel *smslinkLabel;

#pragma mark - 自定义导航栏

/*!
 * 默认导航栏[标题＋返回按钮]
 */
- (void)initNavItem:(NSString*)title;

/*!
 * 默认导航栏[标题＋默认返回按钮＋自定义右边按钮(后缀为.png为图片，否则为文字)]
 */
- (void)initNavItem:(NSString*)title rightValue:(NSString*)rightValue;

/*!
 * 默认导航栏[标题＋自定义左边按钮＋自定义右边按钮(后缀为.png为图片，否则为文字)]
 */
- (void)initNavItem:(NSString*)title leftValue:(NSString*)leftValue rightValue:(NSString*)rightValue;

/*!
 * 默认导航栏[标题分段控件＋自定义右边按钮(后缀为.png为图片，否则为文字)]
 */
- (void)initNavItemSegment:(NSArray*)segmentedArray rightValue:(NSString*)rightValue;

/*!
 * 默认导航栏[标题分段控件＋自定义左边按钮、自定义右边按钮(后缀为.png为图片，否则为文字)]
 */
- (void)initNavItemSegment:(NSArray*)segmentedArray leftValue:(NSString *)leftValue rightValue:(NSString*)rightValue;

/*!
 * 默认导航栏[标题＋图文返回按钮＋自定义右边按钮(后缀为.png为图片，否则为文字)]
 */
- (void)initNavItemBackImage:(NSString*)title rightValue:(NSString*)rightValue;

/*!
 * 默认导航栏[标题＋返回按钮＋双自定义右边图片按钮]
 */
- (void)initNavItemBackImage:(NSString*)title imageArray:(NSArray*)imageArray;

/*!
 * 默认导航栏[标题＋返回按钮＋双自定义右边图片按钮]
 */
- (void)initNavItemArray:(NSString*)title imageArray:(NSArray*)imageArray;

/*!
 * 增加默认导航栏底部线条
 */
-(void)addNavbarSeparateLine;

/*!
 * 删除默认导航栏底部线条
 */
-(void)removeNavbarSeparateLine;

#pragma mark - 进度提示框

/*!
 * 加载等待提示框
 */
- (void)showloading:(NSString*)waitText rect:(CGRect)rect;

/*!
 * 加载等待提示框
 */
- (void)showloading:(NSString*)waitText;

/*!
 * 关闭等待提示框
 */
- (void)closeloading:(NSString*)closeText;

/*!
 * 立即关闭等待提示框
 */
- (void)closeloadingDirectory;

/*!
 * 加载提示框
 */
- (void)showWithCustomView:(NSString*)waitText;

/*!
 * 显示进度滚轮指示器
 */
-(void)showWaiting:(UIView *)parent;

/*!
 * 消除滚动轮指示器
 */
-(void)hideWaiting;


#pragma mark - 弹窗

/*!
 * 弹窗
 */
-(void)alert:(NSString *)message;

/**
 *  自定义弹窗
 *
 *  @param msg    显示提示信息
 *  @param submit 确认按钮
 *  @param cancel 取消按钮
 */
-(void)showAlert:(NSString*)msg submit:(NSString*)submit cancel:(NSString*)cancel;

/**
 *  弹出提示框按钮事件
 *
 *  @param tag <#tag description#>
 */
- (void)onClickShowAlertBtnMethod:(int)tag;

#pragma mark - 画线

/*!
 * 画线
 *param1:(UIImageView *) imgDraw 传入UIImageView对象
 *param2:andDashWidth 虚线宽度，
 *param3:andDashSperateWidth 两虚线分隔的宽度
 *如果是画实线param2与param3都传0
 */
-(void) drawLine:(UIImageView *) imgDraw andDashWidth:(int)dashWidth andDashSperateWidth:(int)sperateDashWidth andcolorWithHexString:(NSString *)colorWithHexString;

/*!
 * 计算字符串长度
 */
- (int)convertToInt:(NSString*)text;

/**
 判断字符串是否为空
 **/
-(BOOL) isEmpty:(NSString *) str;

/*截取图片的一部分,并返回截取过的图片*/
-(UIImage *) createWithImageInRect:(UIImage *)image;

/*压缩图片,并返回压缩后的图片*/
- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;

/*
 替换平台码
 */
- (NSString*)replacePlatformId:(NSString*)strUrl index:(NSInteger *)index;

@end

