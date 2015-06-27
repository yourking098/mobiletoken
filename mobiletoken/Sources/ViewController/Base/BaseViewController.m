//
//  BaseViewController.m
//  TaoShop
//
//  Created by u1city01 on 14-7-29.
//  Copyright (c) 2014年 u1city01. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController
@synthesize navbar=_navbar;
@synthesize childView=_childView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //状态栏字体颜色
    if (IsiOS7Later){
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    }
    _childView = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT)];
    self.view = _childView;
    self.view.backgroundColor=[ColorHelper colorWithHexString:@"#ffffff"];
    //隐藏自带导航栏
    self.navigationController.navigationBarHidden = YES;
    _navbar = [[TAONavigationBar alloc] init];
    if (IsiOS7Later) {
        _navbar.frame = CGRectMake(0, 0, KSCREEN_WIDTH, 64);
    }
    else {
        _navbar.frame = CGRectMake(0, 0, KSCREEN_WIDTH, 44);
    }
    [self.view addSubview:_navbar];
    
    //复制信息
    _smslinkLabel=[[TAOCopyLabel alloc] init];
    _smslinkLabel.hidden=YES;
    [self.view addSubview:_smslinkLabel];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
    _textOfTopViewHeight = 0;
}

-(void)dealloc
{
    if (_loadingMaskView) {
        [_loadingMaskView removeFromSuperview];
        _loadingMaskView = nil;
    }
}

#pragma mark - 自定义导航栏

/*!
 * 默认导航栏[标题＋返回按钮]
 */
- (void)initNavItem:(NSString*)title {
    [self.navbar initNavItem:self title:title];
    [self addNavbarSeparateLine];
}

/*!
 * 默认导航栏[标题＋默认返回按钮＋自定义右边按钮(后缀为.png为图片，否则为文字)]
 */
- (void)initNavItem:(NSString*)title rightValue:(NSString*)rightValue {
    [self.navbar initNavItem:self title:title rightValue:rightValue];
    [self addNavbarSeparateLine];
}

/*!
 * 默认导航栏[标题＋自定义左边按钮＋自定义右边按钮(后缀为.png为图片，否则为文字)]
 */
- (void)initNavItem:(NSString*)title leftValue:(NSString*)leftValue rightValue:(NSString*)rightValue {
    [self.navbar initNavItem:self title:title leftValue:leftValue rightValue:rightValue];
    [self addNavbarSeparateLine];
}


/*!
 * 默认导航栏[标题分段控件＋自定义右边按钮(后缀为.png为图片，否则为文字)]
 */
- (void)initNavItemSegment:(NSArray*)segmentedArray rightValue:(NSString*)rightValue {
    [self.navbar initNavItemSegment:self title:segmentedArray rightValue:rightValue];
    [self addNavbarSeparateLine];
}

/*!
 * 默认导航栏[标题分段控件＋自定义左边按钮、自定义右边按钮(后缀为.png为图片，否则为文字)]
 */
- (void)initNavItemSegment:(NSArray*)segmentedArray leftValue:(NSString *)leftValue rightValue:(NSString*)rightValue {
    [self.navbar initNavItemSegment:self title:segmentedArray leftValue:leftValue rightValue:rightValue];
    [self addNavbarSeparateLine];
}

/*!
 * 默认导航栏[标题＋图文返回按钮＋自定义右边按钮(后缀为.png为图片，否则为文字)]
 */
- (void)initNavItemBackImage:(NSString*)title rightValue:(NSString*)rightValue {
    [self.navbar initNavItemBackImage:self title:title rightValue:rightValue];
}

/*!
 * 默认导航栏[标题＋返回按钮＋双自定义右边图片按钮]
 */
- (void)initNavItemBackImage:(NSString*)title imageArray:(NSArray*)imageArray {
    [self.navbar initNavItemBackImage:self title:title imageArray:imageArray];
}

/*!
 * 默认导航栏[标题＋返回按钮＋双自定义右边图片按钮]
 */
- (void)initNavItemArray:(NSString*)title imageArray:(NSArray*)imageArray {
    [self.navbar initNavItemArray:self title:title imageArray:imageArray];
}

/*!
 * 增加默认导航栏底部线条
 */
-(void)addNavbarSeparateLine
{
    UIView *sepView = [[UIView alloc] initWithFrame:CGRectMake(0,self.navbar.bounds.size.height-0.5, self.navbar.bounds.size.width, 0.5)];
    sepView.tag = 123456;
    sepView.backgroundColor = [ColorHelper colorWithHexString:@"dbdbdb"];
    [self.navbar addSubview:sepView];
}

/*!
 * 删除默认导航栏底部线条
 */
-(void)removeNavbarSeparateLine
{
    UIView *sepView = (UIView *)[self.navbar viewWithTag:123456];
    if (sepView != nil ) {
        [sepView removeFromSuperview];
    }
}


#pragma mark - 导航代理实现方法

/*!
 * 导航返回按钮事件
 */
- (void)backSelection{
    [self.navigationController popViewControllerAnimated:YES];
}

/*!
 * 导航左边按钮事件
 */
- (void)leftSelection{
    
}

/*!
 * 导航右边按钮事件
 */
- (void)rightSelection{
    
}

/*!
 * 导航右边按钮事件
 */
- (void)rightSelection:(UIButton*)sender{
    
}

/*!
 * 导航分段控件事件
 */
- (void)segmentAction:(UISegmentedControl *)Seg{
    
}

#pragma mark - 进度提示框

/*!
 * 加载等待提示框
 */
- (void)showloading:(NSString*)waitText rect:(CGRect)rect {
    if (_loadingMaskView) {
        [_loadingMaskView removeFromSuperview];
        _loadingMaskView = nil;
    }
    if (HUD) {
        [HUD removeFromSuperview];
        HUD = nil;
    }
    _loadingMaskView = [[UIView alloc] initWithFrame:rect];
    [self.view addSubview:_loadingMaskView];
    //返回刷新页面
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [_loadingMaskView addSubview:HUD];
    
    HUD.dimBackground = YES;
    HUD.opacity=0.0;
    
    HUD.labelText = waitText;
    
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
    
    // Show the HUD while the provided method executes in a new thread
    [HUD show:YES];
}

/*!
 * 加载等待提示框
 */
- (void)showloading:(NSString*)waitText {
    if (_loadingMaskView) {
        [_loadingMaskView removeFromSuperview];
        _loadingMaskView = nil;
    }
    if (HUD) {
        [HUD removeFromSuperview];
        HUD = nil;
    }
    _loadingMaskView = [[UIView alloc] initWithFrame:CGRECT_NO_NAV(0, 44, KSCREEN_WIDTH, KSCREEN_HEIGHT-64)];
    [self.view addSubview:_loadingMaskView];
    //返回刷新页面
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [_loadingMaskView addSubview:HUD];
    
    HUD.dimBackground = YES;
    HUD.opacity=0.0;
    
    HUD.labelText = waitText;
    
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
    
    // Show the HUD while the provided method executes in a new thread
    [HUD show:YES];
}

/*!
 * 关闭等待提示框
 */
- (void)closeloading:(NSString*)closeText {
    if (closeText != nil) {
        HUD.mode = MBProgressHUDModeCustomView;
        HUD.labelText = closeText;
        sleep(5);
    }
    [HUD hide:YES];
    if (_loadingMaskView) {
        [_loadingMaskView removeFromSuperview];
        _loadingMaskView = nil;
    }
}

/*!
 * 立即关闭等待提示框
 */
- (void)closeloadingDirectory
{
    if (HUD) {
        [HUD hide:YES];
    }
    
    if (_loadingMaskView) {
        [_loadingMaskView removeFromSuperview];
        _loadingMaskView = nil;
    }
}

- (void)showWithCustomView:(NSString*)waitText {
	
	HUD = [[MBProgressHUD alloc] initWithView:self.view];
	[self.view addSubview:HUD];
	
	// Set custom view mode
	HUD.mode = MBProgressHUDModeCustomView;
	
	HUD.delegate = self;
	HUD.labelText = waitText;
    HUD.dimBackground =YES;//使背景成黑灰色，让MBProgressHUD成高亮显示
    HUD.opacity=1.0;
	
	[HUD show:YES];
	[HUD hide:YES afterDelay:1.0];
}

//显示进度滚轮指示器
-(void)showWaiting:(UIView *)parent
{
    HUD = [[MBProgressHUD alloc] initWithView:parent];
    [parent addSubview:HUD];
    HUD.labelText = @"加载中...";//显示提示
    HUD.dimBackground =YES;//使背景成黑灰色，让MBProgressHUD成高亮显示
    HUD.square = YES;//设置显示框的高度和宽度一样
    HUD.opacity=1.0;
    HUD.color = [UIColor clearColor];//这儿表示无背景
    [HUD show:YES];
    [HUD hide:YES afterDelay:3];
}

//消除滚动轮指示器
-(void)hideWaiting
{
    [HUD hide:YES];
    if (_loadingMaskView) {
        [_loadingMaskView removeFromSuperview];
        _loadingMaskView = nil;
    }

}

#pragma mark - 弹窗

/*!
 * 弹窗
 */
-(void)alert:(NSString *)message{
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alter show];
}

/**
 *  自定义弹窗
 *
 *  @param msg    显示提示信息
 *  @param submit 确认按钮
 *  @param cancel 取消按钮
 */
-(void)showAlert:(NSString*)msg submit:(NSString*)submit cancel:(NSString*)cancel {
    //蒙层
    baseAlertView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT)];
    UIView *maskView = [[UIView alloc] initWithFrame:baseAlertView.bounds];
    maskView.backgroundColor = [UIColor blackColor];
    maskView.alpha = 0.8;
    [baseAlertView addSubview:maskView];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(65*SCALAE, (KSCREEN_HEIGHT-300*SCALAE)/2, KSCREEN_WIDTH-130*SCALAE, 300*SCALAE)];
    backView.backgroundColor=[ColorHelper colorWithHexString:@"#ffffff"];
    backView.layer.cornerRadius=20*SCALAE;
    backView.layer.masksToBounds=YES;
    [baseAlertView addSubview:backView];
    
    //提示文本
    UILabel *msgLabel=[[UILabel alloc] initWithFrame:CGRectMake(60*SCALAE, 0, backView.frame.size.width-120*SCALAE, backView.frame.size.height-110*SCALAE)];
    msgLabel.text=msg;
    msgLabel.textColor=[ColorHelper colorWithHexString:@"#444444"];
    msgLabel.backgroundColor=[ColorHelper colorWithHexString:@"#ffffff"];
    //文字居中显示
    msgLabel.textAlignment = NSTextAlignmentCenter;
    //自动折行设置
    msgLabel.lineBreakMode = NSLineBreakByWordWrapping;
    msgLabel.numberOfLines = 0;
    msgLabel.font=[UIFont systemFontOfSize:15];
    [backView addSubview:msgLabel];
    
    //确认按钮
    UIButton *submitButton=[[UIButton alloc] initWithFrame:CGRectMake(0, backView.frame.size.height-110*SCALAE, backView.frame.size.width/2, 110*SCALAE)];
    submitButton.titleLabel.font = [UIFont systemFontOfSize:16];//字体大小
    submitButton.backgroundColor=[ColorHelper colorWithHexString:@"#ffffff"];
    [submitButton setTitle:submit forState:UIControlStateNormal];
    [submitButton setTitleColor:[ColorHelper colorWithHexString:@"#444444"]forState:UIControlStateNormal];
    submitButton.tag=0;
    [submitButton addTarget:self action:@selector(didClickShowAlertBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:submitButton];
    
    //取消按钮
    UIButton *cancelButton=[[UIButton alloc] initWithFrame:CGRectMake(backView.frame.size.width/2, backView.frame.size.height-110*SCALAE, backView.frame.size.width/2, 110*SCALAE)];
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:16];//字体大小
    cancelButton.backgroundColor=[ColorHelper colorWithHexString:@"#ffffff"];
    [cancelButton setTitle:cancel forState:UIControlStateNormal];
    [cancelButton setTitleColor:[ColorHelper colorWithHexString:@"#444444"]forState:UIControlStateNormal];
    cancelButton.tag=1;
    [cancelButton addTarget:self action:@selector(didClickShowAlertBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:cancelButton];
    
    UIImageView *lineView=[[UIImageView alloc] initWithFrame:CGRectMake(0, backView.frame.size.height-110*SCALAE, backView.frame.size.width, 0.5f)];
    lineView.backgroundColor=[ColorHelper colorWithHexString:@"#b6b6b6"];
    [backView addSubview:lineView];
    
    UIImageView *lineView1=[[UIImageView alloc] initWithFrame:CGRectMake(backView.frame.size.width/2-0.25f, backView.frame.size.height-110*SCALAE, 0.5f, 110*SCALAE)];
    lineView1.backgroundColor=[ColorHelper colorWithHexString:@"#b6b6b6"];
    [backView addSubview:lineView1];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:baseAlertView];
}

/**
 *  弹出提示框按钮事件
 *
 *  @param sender <#sender description#>
 */
- (void)didClickShowAlertBtnMethod:(UIButton*)sender {
    [baseAlertView removeFromSuperview];
    [self onClickShowAlertBtnMethod:(int)sender.tag];
}

/**
 *  弹出提示框按钮事件
 *
 *  @param tag <#tag description#>
 */
- (void)onClickShowAlertBtnMethod:(int)tag {

}

#pragma mark - 画线

/*!
 * 画线
 *param1:(UIImageView *) imgDraw 传入UIImageView对象
 *param2:andDashWidth 虚线宽度，
 *param3:andDashSperateWidth 两虚线分隔的宽度
 *如果是画实线param2与param3都传0
 */
-(void) drawLine:(UIImageView *) imgDraw andDashWidth:(int)dashWidth andDashSperateWidth:(int)sperateDashWidth andcolorWithHexString:(NSString *)colorWithHexString{
    [self.view addSubview:imgDraw];
    UIGraphicsBeginImageContext(imgDraw.frame.size);   //开始画线
    [imgDraw.image drawInRect:CGRectMake(0, 0, imgDraw.frame.size.width, imgDraw.frame.size.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);  //设置线条终点形状
    
    // float lengths[] = {dashWidth,sperateDashWidth};//实线{0,0}，  虚线{5,2}
    CGContextRef line = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(line, [ColorHelper colorWithHexString:colorWithHexString].CGColor);//颜色
    
    //CGContextSetLineDash(line, 0, lengths, 2);  //画虚线
    CGContextMoveToPoint(line, 10.0, 20.0);    //从左边间隔10px开始画线
    CGContextAddLineToPoint(line, 310.0, 20.0);//长度为310px
    CGContextStrokePath(line);
    
    imgDraw.image = UIGraphicsGetImageFromCurrentImageContext();
}

#pragma mark - 防止用户输入时键盘遮住文本框

////开始编辑输入框的时候，软键盘出现，执行此事件
//-(void)textFieldDidBeginEditing:(UITextField *)textField
//{
//    //屏幕高度
//    CGSize screenSize = [UIScreen mainScreen].bounds.size;
//    
//    CGRect frame = textField.frame;
//    int offset = _textOfTopViewHeight + frame.origin.y + 32 - (screenSize.height - 64.0 - 266.0);//键盘高度216+50
//    
//    NSTimeInterval animationDuration = 0.30f;
//    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
//    [UIView setAnimationDuration:animationDuration];
//    
//    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
//    if(offset > 0)
//        self.childView.frame = CGRectMake(0.0f, -offset+64, self.childView.frame.size.width, self.childView.frame.size.height);
//    
//    [UIView commitAnimations];
//}

//当用户按下return键或者按回车键，keyboard消失
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

//输入框编辑完成以后，将视图恢复到原始状态
//-(void)textFieldDidEndEditing:(UITextField *)textField
//{
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:0.30];
//    if (IsiOS7Later){
//        self.childView.frame =CGRectMake(0, 30 + 64, self.childView.frame.size.width, self.childView.frame.size.height);
//    }
//    else {
//        self.childView.frame =CGRectMake(0, _textOfTopViewHeight + 44, self.childView.frame.size.width, self.childView.frame.size.height);
//    }
//     [UIView commitAnimations];
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*!
 * 计算字符串长度
 */
- (int)convertToInt:(NSString*)text {
    int strlength = 0;
    char* p = (char*)[text cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[text lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return (strlength+1)/2;
}

/**
 判断字符串是否为空
 **/
-(BOOL) isEmpty:(NSString *) str {
    if (!str) {
        return true;
    } else {
        //A character set containing only the whitespace characters space (U+0020) and tab (U+0009) and the newline and nextline characters (U+000A–U+000D, U+0085).
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        //Returns a new string made by removing from both ends of the receiver characters contained in a given character set.
        NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
        if ([trimedString length] == 0) {
            return true;
        } else {
            return false;
        }
    }
}

/*
 截取图片的一部分,并返回截取过的图片
 */
-(UIImage *) createWithImageInRect:(UIImage *)image{
    CGRect rect;
    if (image.size.width>image.size.height) {
        rect = CGRectMake((image.size.width-image.size.height)/2, 0, image.size.height, image.size.height);
    } else if (image.size.width<image.size.height) {
        rect = CGRectMake(0, (image.size.height-image.size.width)/2, image.size.width, image.size.width);
    } else {
        rect = CGRectMake(0, 0, image.size.width, image.size.height);
    }
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], rect); //获得剪切区域B
    UIImage *subIma = [UIImage imageWithCGImage:imageRef]; // 把B转化成一张图片
    return subIma;
}

/*压缩图片,并返回压缩后的图片*/
- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize {
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    // End the context
    UIGraphicsEndImageContext();
    // Return the new image.
    return newImage;
}

@end
