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
        serialNumberVC.pageType=0;
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
    
    UIImage* selectedImage1 = [UIImage imageNamed:@"ic_tab_home"];
    UIImage* selectedImage2 = [UIImage imageNamed:@"ic_tab_setting"];
    
    if (IsiOS7Later) {
        selectedImage1 = [selectedImage1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        selectedImage2 = [selectedImage2 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    [firstVC.tabBarItem setFinishedSelectedImage:selectedImage1 withFinishedUnselectedImage:[UIImage imageNamed:@"ic_tab_home"]];
    [secondVC.tabBarItem setFinishedSelectedImage:selectedImage2 withFinishedUnselectedImage:[UIImage imageNamed:@"ic_tab_setting"]];
    
    
    _tabBarVC.tabBar.selectedImageTintColor = [ColorHelper colorWithHexString:@"#00b06a"];
    _tabBarVC.viewControllers = [NSArray arrayWithObjects:firstNav,secondNav,nil];
    
    _tabBarVC.tabBar.backgroundImage = [UIImage imageNamed:@"ic_main_tab_off"];
    
    UIImage* tabBarBackground = [UIImage imageNamed:@"ic_main_tab_off"];
    [[UITabBar appearance] setBackgroundImage:[tabBarBackground resizableImageWithCapInsets:UIEdgeInsetsZero]];
    [[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"ic_main_tab_on"]];
    
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       [ColorHelper colorWithHexString:@"#00b06a"], UITextAttributeTextColor,
                                                       nil,nil] forState:UIControlStateSelected];
    
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"AmericanTypewriter" size:11.0f],UITextAttributeFont,nil] forState:UIControlStateNormal];
    
    self.appDelegate.window.rootViewController=self.tabBarVC;
    
    self.tabBarVC.navigationController.navigationBarHidden = YES;
    
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    return YES;
}

#pragma mark - 页面地址跳转方法

/*!
 * 显示当前页面
 */
- (void)rootView:(UIViewController*)viewController {
    self.appDelegate.window.rootViewController = viewController;
}

/*!
 * PUSH到当前页面
 */
- (void)pushView:(UIViewController*)toViewController viewController:(UIViewController*)fromViewController {
    [[fromViewController navigationController] pushViewController:toViewController animated:YES];
}

/*!
 * PUSH到当前页面,控制底部导航栏显示
 */
- (void)pushView:(UIViewController*)toViewController viewController:(UIViewController*)fromViewController shouldHideTabbar:(BOOL)shouldHide
{
    toViewController.hidesBottomBarWhenPushed = shouldHide;
    [[fromViewController navigationController] pushViewController:toViewController animated:YES];
    
}

/*!
 * PUSH到当前页面(使用STORYBOARD)
 */
- (void)pushView:(NSString*)sdName ident:(NSString*)ident viewController:(UIViewController*)fromViewController {
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:sdName bundle:nil];
    UIViewController *toViewController = [storyboard instantiateViewControllerWithIdentifier:ident];
    [[fromViewController navigationController] pushViewController:toViewController animated:YES];
}

/*!
 * PUSH到当前页面(使用STORYBOARD),控制底部导航栏显示
 */
- (void)pushView:(NSString*)sdName ident:(NSString*)ident viewController:(UIViewController*)fromViewController shouldHideTabbar:(BOOL)shouldHide
{
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:sdName bundle:nil];
    UIViewController *toViewController = [storyboard instantiateViewControllerWithIdentifier:ident];
    toViewController.hidesBottomBarWhenPushed = shouldHide;
    [[fromViewController navigationController] pushViewController:toViewController animated:YES];
}

/*!
 * 弹出页面
 */
- (void)presentView:(UIViewController*)toViewController viewController:(UIViewController*)fromViewController {
    
    [fromViewController.view.window.rootViewController presentViewController:toViewController animated:YES completion:nil];
}



@end
