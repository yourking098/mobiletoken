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


/*!
 * 显示当前页面
 */
- (void)rootView:(UIViewController*)viewController;

@end
