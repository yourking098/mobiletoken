//
//  UIEngine.h
//  mobiletoken
//
//  Created by u1city01 on 15/6/24.
//  Copyright (c) 2015年 mobiletoken. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomerModel.h"


@interface UIEngine : NSObject<UITabBarControllerDelegate>
{
    CustomerModel *enCust;
}
@property(nonatomic,strong) UITabBarController *tabBarVC;

+ (UIEngine*)getinstance;

#pragma mark - 系统配置信息

/*!
 * @method 获取系统配置信息
 * @abstract
 * @discussion
 * @param   nil
 * @result  CustomerModel
 */
- (CustomerModel*)getCustomerModel;

/*!
 * @method 设置系统配置信息
 * @abstract
 * @discussion
 * @param   nil
 * @result  CustomerModel
 */
- (BOOL)setCustomerModel:(CustomerModel*)sCust;

/*!
 * 进入系统业务判断
 */
- (void)loginBeeShop;

/*!
 * 进入首页
 */
- (void)loginInMainView;


#pragma mark - 页面地址跳转方法

/*!
 * 显示当前页面
 */
- (void)rootView:(UIViewController*)viewController;

/*!
 * PUSH到当前页面
 */
- (void)pushView:(UIViewController*)toViewController viewController:(UIViewController*)fromViewController;

/*!
 * PUSH到当前页面,控制底部导航栏显示
 */
- (void)pushView:(UIViewController*)toViewController viewController:(UIViewController*)fromViewController shouldHideTabbar:(BOOL)shouldHide;

/*!
 * PUSH到当前页面(使用STORYBOARD)
 */
- (void)pushView:(NSString*)sdName ident:(NSString*)ident viewController:(UIViewController*)fromViewController;

/*!
 * PUSH到当前页面(使用STORYBOARD),控制底部导航栏显示
 */
- (void)pushView:(NSString*)sdName ident:(NSString*)ident viewController:(UIViewController*)fromViewController shouldHideTabbar:(BOOL)shouldHide;

/*!
 * 弹出页面
 */
- (void)presentView:(UIViewController*)toViewController viewController:(UIViewController*)fromViewController;

@end
