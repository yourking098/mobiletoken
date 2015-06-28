//
//  UIEngine.m
//  mobiletoken
//
//  Created by u1city01 on 15/6/24.
//  Copyright (c) 2015年 mobiletoken. All rights reserved.
//

#import "UIEngine.h"
#import "AppDelegate.h"
#import "ColorHelper.h"
#import "PlistHelper.h"
#import "BaseNavigationController.h"
#import "GuideViewController.h"
#import "HomeViewController.h"
#import "SetupViewController.h"
#import "SerialNumberViewController.h"

static UIEngine *_instance=nil;

@implementation UIEngine

- (AppDelegate *)appDelegate
{
    //sdfsdf
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

+ (UIEngine*)getinstance
{
    @synchronized(self)
    {
        if (_instance == nil) {
            _instance = [[UIEngine alloc] init];
        }
    }
    return _instance;
}

- (id)init {
    if ([super init]) {
        [self getCustomerModel];
    }
    return self;
}

#pragma mark - 系统配置信息

/*!
 * @method 获取系统配置信息
 * @abstract
 * @discussion
 * @param   nil
 * @result  CustomerModel
 */
- (CustomerModel*)getCustomerModel {
    if (enCust == nil) {
        enCust = [PlistHelper selectCust];
    }
    return enCust;
}

/*!
 * @method 设置系统配置信息
 * @abstract
 * @discussion
 * @param   nil
 * @result  CustomerModel
 */
- (BOOL)setCustomerModel:(CustomerModel*)cust {
    if ([PlistHelper updateCust:cust]) {
        enCust = cust;
        return YES;
    }
    else {
        return NO;
    }
}

//判断当前是否显示需要显示引导页
- (BOOL)isShouldShowGuideViow {
    NSDictionary *plistDic = [[NSBundle mainBundle] infoDictionary];
    NSString *currntVersion = [plistDic objectForKey:@"CFBundleVersion"];
    NSArray *curVerArray = [currntVersion componentsSeparatedByString:@"."];
    NSString *localVersion = [[NSUserDefaults standardUserDefaults] objectForKey:@"version"];
    BOOL shouldShowGuide = NO;
    if (localVersion != nil) {
        NSArray *locVerArray = [localVersion componentsSeparatedByString:@"."];
        if (locVerArray.count == curVerArray.count) {
            for (int i = 0;i < locVerArray.count;i++) {
                NSString *locNumStr = [locVerArray objectAtIndex:i];
                NSString *curNumStr = [curVerArray objectAtIndex:i];
                if ([locNumStr intValue] != [curNumStr intValue]) {
                    shouldShowGuide = YES;
                    break;
                }
                
            }
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"错误" message:@"当前版本号不符合标准" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
            return YES;
        }
    } else {
        shouldShowGuide = YES;
    }
    return shouldShowGuide;
}

/*!
 * 进入系统业务判断
 */
- (void)loginBeeShop {
    //引导页
    if ([self isShouldShowGuideViow]) {
        NSString *darenvalue=@"0";
        [[NSUserDefaults standardUserDefaults] setObject:darenvalue forKey:@"darenvalue"];
        
        GuideViewController *guideVC = [[GuideViewController alloc] init];
        UINavigationController *guideNav = [[UINavigationController alloc] initWithRootViewController:guideVC];
        [self rootView:guideNav];
        
    } else if (enCust.serialNumber==nil) {
        //进入查看序列号页面
        SerialNumberViewController *serialNumberVC = [[SerialNumberViewController alloc] init];
        UINavigationController *serailNav = [[UINavigationController alloc] initWithRootViewController:serialNumberVC];
        [self rootView:serailNav];
    } else {
        //进入首页
        [self loginInMainView];
    }
}

/*!
 * 进入首页
 */
- (void)loginInMainView {
    //身份验证
    HomeViewController *mainVC = [[HomeViewController alloc] init];
    mainVC.title = @"身份验证";
    //设置
    SetupViewController *setupVC = [[SetupViewController alloc] init];
    setupVC.title = @"设置";
    [self initTabbarViewControllers:mainVC second:setupVC];
}

/*!
 * 创建底部导航
 */
-(void)initTabbarViewControllers:(UIViewController*)firstVC second:(UIViewController*)secondVC {
    BaseNavigationController *firstNav = [[BaseNavigationController alloc] initWithRootViewController:firstVC];
    BaseNavigationController *secondNav = [[BaseNavigationController alloc] initWithRootViewController:secondVC];
    
    _tabBarVC = [[UITabBarController alloc] init];
    _tabBarVC.delegate = self;
    
    firstVC.tabBarItem.title = firstVC.title;
    secondVC.tabBarItem.title = secondVC.title;
    
    UIImage* selectedImage1 = [UIImage imageNamed:@"tab_home_press"];
    UIImage* selectedImage2 = [UIImage imageNamed:@"tab_goods_press"];
    
    if (IsiOS7Later) {
        selectedImage1 = [selectedImage1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        selectedImage2 = [selectedImage2 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    [firstVC.tabBarItem setFinishedSelectedImage:selectedImage1 withFinishedUnselectedImage:[UIImage imageNamed:@"tab_home"]];
    [secondVC.tabBarItem setFinishedSelectedImage:selectedImage2 withFinishedUnselectedImage:[UIImage imageNamed:@"tab_goods"]];
    
    _tabBarVC.tabBar.selectedImageTintColor = [ColorHelper colorWithHexString:@"#ee5037"];
    _tabBarVC.viewControllers = [NSArray arrayWithObjects:firstNav,secondNav,nil];
    _tabBarVC.tabBar.tintColor = [ColorHelper colorWithHexString:@"ffffff"];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       [ColorHelper colorWithHexString:@"#ffa72d"], UITextAttributeTextColor,
                                                       nil,nil] forState:UIControlStateSelected];//151515
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       [ColorHelper colorWithHexString:@"969696"], UITextAttributeTextColor,
                                                       nil,nil] forState:UIControlStateNormal];//969696
    
    _tabBarVC.tabBar.backgroundColor = [ColorHelper colorWithHexString:@"f4f4f4"];
    
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"AmericanTypewriter" size:11.0f],UITextAttributeFont,nil] forState:UIControlStateNormal];
    
    self.appDelegate.window.rootViewController=self.tabBarVC;
    
    self.tabBarVC.navigationController.navigationBarHidden = YES;
    
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    return YES;
}


/*!
 * 显示当前页面
 */
- (void)rootView:(UIViewController*)viewController {
    self.appDelegate.window.rootViewController = viewController;
}


@end
