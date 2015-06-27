//
//  TAONavigationBar.m
//  TaoShop
//
//  Created by u1city01 on 14-7-29.
//  Copyright (c) 2014年 u1city01. All rights reserved.
//

#import "TAONavigationBar.h"
#import "ColorHelper.h"

@implementation TAONavigationBar
@synthesize m_lblTitle = _lblTitle;
@synthesize m_imgViewBg = _imgViewBg;
@synthesize m_btnLeft = _btnLeft;
@synthesize m_btnLeft1 = _btnLeft1;
@synthesize m_btnRight = _btnRight;
@synthesize m_btnRight1 = _btnRight1;
@synthesize m_segControl = _segControl;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    if (!_isMainVC) {
        UIImage *image = [UIImage imageNamed:@"topbg"];//导航的背景图片
        [image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    }
}

/*!
 * 创建导航栏
 */
- (void)buildUI:(id<NavigationItemDelegate>)delegate title:(NSString*)title segmentedArray:(NSArray*)segmentedArray left:(NSString*)left right:(NSArray*)right {
    self.navDelegate = delegate;
    UINavigationItem *navitem = [[UINavigationItem alloc] initWithTitle:nil];
    
    //导航栏标题
    switch (titleflag) {
        case 0:
        {
            CGSize titleSize=[title sizeWithFont:[UIFont fontWithName:@"Helvetica-Bold" size:18] constrainedToSize:CGSizeMake(MAXFLOAT, 20)];
            
            _lblTitle = [[UILabel alloc] initWithFrame:CGRectMake((KSCREEN_WIDTH-titleSize.width-10)/2, 0, titleSize.width+10, 44)];
            _lblTitle.backgroundColor = [UIColor clearColor];
            _lblTitle.textColor=[ColorHelper colorWithHexString:@"#444444"];
            _lblTitle.textAlignment = NSTextAlignmentCenter;
            [_lblTitle setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
            [_lblTitle setText:title];
            //标题
            navitem.titleView = _lblTitle;
        }
            break;
        case 1:
        {
            _segControl = [[UISegmentedControl alloc] initWithItems:segmentedArray];
            _segControl.frame = CGRectMake(60.0, 7.5, 200.0, 29.0);
            _segControl.selectedSegmentIndex = 0;//设置默认选择项索引
            _segControl.tintColor = [ColorHelper colorWithHexString:@"#ee5037"];
            _segControl.segmentedControlStyle = UISegmentedControlStylePlain;//设置样式
            [_segControl addTarget:self action:@selector(segmentAction:)forControlEvents:UIControlEventValueChanged];  //添加委托方法
            //标题
            navitem.titleView = _segControl;
        }
            break;
            
        default:
            break;
    }
    
    //导航栏左边按钮
    switch (leftflag) {
        case 0:
        {
            //默认返回按钮
            _btnLeft = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
            [_btnLeft setImage:[UIImage imageNamed:left] forState:UIControlStateNormal];
            [_btnLeft setImageEdgeInsets:UIEdgeInsetsMake(11, 11, 11, 11)];
            [_btnLeft addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        }
            break;
        case 1:
        {
            //图文返回按钮
            _btnLeft = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 55, 44)];
            _btnLeft.titleLabel.font = [UIFont systemFontOfSize:16];
            [_btnLeft setImageEdgeInsets:UIEdgeInsetsMake(11, 5, 11, 32)];
            [_btnLeft setTitleEdgeInsets:UIEdgeInsetsMake(0, -55, 0, 4)];
            [_btnLeft setTitle:@"返回" forState:UIControlStateNormal];
            [_btnLeft setTitleColor:[ColorHelper colorWithHexString:@"#333333"] forState:UIControlStateNormal];
            [_btnLeft setImage:[UIImage imageNamed:@"ic_arrow_left"] forState:UIControlStateNormal];
            [_btnLeft addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        }
            break;
        case 2:
        {
            //自定义图片按钮
            _btnLeft = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
            [_btnLeft setImage:[UIImage imageNamed:left] forState:UIControlStateNormal];
            [_btnLeft setImageEdgeInsets:UIEdgeInsetsMake(11, 11, 11, 11)];
            [_btnLeft addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
        }
            break;
        case 3:
        {
            //自定义文字按钮
            if ([left length] == 3) {
                _btnLeft = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 55, 44)];
            }
            else if ([left length] == 4) {
                _btnLeft = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 44)];
            }
            else {
                _btnLeft = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
            }
            _btnLeft.titleLabel.font = [UIFont systemFontOfSize:16];
            [_btnLeft setTitle:left forState:UIControlStateNormal];
            [_btnLeft setTitleColor:[ColorHelper colorWithHexString:@"#333333"] forState:UIControlStateNormal];
            [_btnLeft addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
        }
            break;
        case 4:
        {
            //图文返回+文字按钮
            _btnLeft = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 55, 44)];
            _btnLeft.titleLabel.font = [UIFont systemFontOfSize:16];
            [_btnLeft setImageEdgeInsets:UIEdgeInsetsMake(11, 5, 11, 32)];
            [_btnLeft setTitleEdgeInsets:UIEdgeInsetsMake(0, -55, 0, 4)];
            [_btnLeft setTitle:@"返回" forState:UIControlStateNormal];
            [_btnLeft setTitleColor:[ColorHelper colorWithHexString:@"#333333"] forState:UIControlStateNormal];
            [_btnLeft setImage:[UIImage imageNamed:@"ic_arrow_left"] forState:UIControlStateNormal];
            [_btnLeft addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
            
            _btnLeft1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 43)];
            _btnLeft1.titleLabel.font = [UIFont systemFontOfSize:15];
            _btnLeft1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            [_btnLeft1 setTitle:left forState:UIControlStateNormal];
            [_btnLeft1 setTitleColor:[ColorHelper colorWithHexString:@"#333333"] forState:UIControlStateNormal];
            [_btnLeft1 addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
        }
            break;
            
        default:
            break;
    }
    
    //导航栏右边按钮
    switch (rightflag) {
        case 0:
        {
            //自定义图片按钮
            _btnRight = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
            [_btnRight setImage:[UIImage imageNamed:right[0]] forState:UIControlStateNormal];
            [_btnRight setImageEdgeInsets:UIEdgeInsetsMake(11, 11, 11, 11)];
            [_btnRight addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
        }
            break;
        case 1:
        {
            //自定义文字按钮
            if ([right[0] length] == 3) {
                _btnRight = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 55, 44)];
            }
            else if ([right[0] length] == 4) {
                _btnRight = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 44)];
            }
            else if ([right[0] length] >= 5) {
                CGSize size = [right[0] sizeWithFont:[UIFont systemFontOfSize:16]];
                _btnRight = [[UIButton alloc] initWithFrame:CGRectMake(0, 0,size.width, 44)];
            }
            else {
                _btnRight = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
            }
            _btnRight.titleLabel.font = [UIFont systemFontOfSize:16];
            [_btnRight setTitle:right[0] forState:UIControlStateNormal];
            [_btnRight setTitleColor:[ColorHelper colorWithHexString:@"#333333"] forState:UIControlStateNormal];
            [_btnRight addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
        }
            break;
        case 2:
        {
            //双自定义图片按钮
            _btnRight = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
            [_btnRight setImage:[UIImage imageNamed:right[0]] forState:UIControlStateNormal];
            [_btnRight setImageEdgeInsets:UIEdgeInsetsMake(11, 11, 11, 11)];
            [_btnRight addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
            _btnRight.tag = 0;
            
            if ([right count]>1) {
                _btnRight1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
                [_btnRight1 setImage:[UIImage imageNamed:right[1]] forState:UIControlStateNormal];
                [_btnRight1 setImageEdgeInsets:UIEdgeInsetsMake(11, 11, 11, 11)];
                [_btnRight1 addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
                _btnRight1.tag = 1;
            }
        }
            break;

        default:
            break;
    }
    
    //返回按钮
    navitem.hidesBackButton = YES;

    //左边按钮
    if (left != nil && leftflag >= 0) {
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
        

        /**
         *  width为负数时，相当于btn向右移动width数值个像素，由于按钮本身和边界间距为5pix，所以width设为-5时，间距正好调整
         *  为0；width为正数时，正好相反，相当于往左移动width数值个像素
         */
        negativeSpacer.width = -16;
        
        UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_btnLeft];
        
        if (leftflag == 4) {
            UIBarButtonItem *leftBarButtonItem1 = [[UIBarButtonItem alloc]initWithCustomView:_btnLeft1];
            
            navitem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer,leftBarButtonItem,leftBarButtonItem1,nil];
        }
        else {
            navitem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer,leftBarButtonItem,nil];
        }
    }
    
    //右边按钮
    if (right != nil && rightflag >= 0) {
        
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
        /**
         *  width为负数时，相当于btn向右移动width数值个像素，由于按钮本身和边界间距为5pix，所以width设为-5时，间距正好调整
         *  为0；width为正数时，正好相反，相当于往左移动width数值个像素
         */
        negativeSpacer.width = -12;
        
        UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_btnRight];
        
        if ([right count]>1) {
            
            UIBarButtonItem *rightBarButtonItem1 = [[UIBarButtonItem alloc]initWithCustomView:_btnRight1];

            navitem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer,rightBarButtonItem,rightBarButtonItem1,nil];
        }
        else {
            navitem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer,rightBarButtonItem,nil];
        }
        
    }
    [self pushNavigationItem:navitem animated:NO];
    
}

/*!
 * 默认导航栏[标题＋默认返回按钮]
 */
- (void)initNavItem:(id<NavigationItemDelegate>)delegate title:(NSString*)title {
    titleflag = 0;
    leftflag = 0;
    rightflag = -1;
    [self buildUI:delegate title:title segmentedArray:nil left:@"ic_arrow_left" right:nil];
}

/*!
 * 默认导航栏[标题＋默认返回按钮＋自定义右边按钮(后缀为.png为图片，否则为文字)]
 */
- (void)initNavItem:(id<NavigationItemDelegate>)delegate title:(NSString*)title rightValue:(NSString*)rightValue {
    titleflag = 0;
    leftflag = 0;
    
    if (rightValue == nil) {
        rightflag = -1;
    }
    else {
        //判断是否图片还是文字
        NSRange rangeValue = [rightValue rangeOfString:@".png"];
        if (rangeValue.length > 0) {
            rightflag = 0;
        }
        else {
            rightflag = 1;
        }
    }

    NSArray *right = [[NSArray alloc] initWithObjects:rightValue,nil];
    [self buildUI:delegate title:title segmentedArray:nil left:@"ic_arrow_left" right:right];
}

/*!
 * 默认导航栏[标题＋自定义左边按钮＋自定义右边按钮(后缀为.png为图片，否则为文字)]
 */
- (void)initNavItem:(id<NavigationItemDelegate>)delegate title:(NSString*)title leftValue:(NSString*)leftValue rightValue:(NSString*)rightValue {
    titleflag = 0;
    
    if (leftValue == nil) {
        leftflag = -1;
    }
    else {
        //判断是否图片还是文字
        NSRange rangeValue = [leftValue rangeOfString:@".png"];
        if (rangeValue.length > 0) {
            leftflag = 2;
        }
        else {
            leftflag = 3;
        }
    }
    if (rightValue == nil) {
        rightflag = -1;
    }
    else {
        //判断是否图片还是文字
        NSRange rangeValue = [rightValue rangeOfString:@".png"];
        if (rangeValue.length > 0) {
            rightflag = 0;
        }
        else {
            rightflag = 1;
        }
    }
    NSArray *right = [[NSArray alloc] initWithObjects:rightValue,nil];
    [self buildUI:delegate title:title segmentedArray:nil left:leftValue right:right];
}


/*!
 * 默认导航栏[标题分段控件＋自定义右边按钮(后缀为.png为图片，否则为文字)]
 */
- (void)initNavItemSegment:(id<NavigationItemDelegate>)delegate title:(NSArray*)segmentedArray rightValue:(NSString*)rightValue {
    titleflag = 1;
    leftflag = 0;
    
    if (rightValue == nil) {
        rightflag = -1;
    }
    else {
        //判断是否图片还是文字
        NSRange rangeValue = [rightValue rangeOfString:@".png"];
        if (rangeValue.length > 0) {
            rightflag = 0;
        }
        else {
            rightflag = 1;
        }
    }
    
    NSArray *right = [[NSArray alloc] initWithObjects:rightValue,nil];
    [self buildUI:delegate title:nil segmentedArray:segmentedArray left:@"ic_arrow_left" right:right];
}

/*!
 * 默认导航栏[标题分段控件＋自定义左边按钮、自定义右边按钮(后缀为.png为图片，否则为文字)]
 */
- (void)initNavItemSegment:(id<NavigationItemDelegate>)delegate title:(NSArray*)segmentedArray leftValue:(NSString *)leftValue rightValue:(NSString*)rightValue {
    titleflag = 1;
    
    if (leftValue == nil) {
        leftflag = -1;
    }
    else {
        //判断是否图片还是文字
        NSRange rangeValue = [leftValue rangeOfString:@".png"];
        if (rangeValue.length > 0) {
            leftflag = 2;
        }
        else {
            leftflag = 3;
        }
    }
    if (rightValue == nil) {
        rightflag = -1;
    }
    else {
        //判断是否图片还是文字
        NSRange rangeValue = [rightValue rangeOfString:@".png"];
        if (rangeValue.length > 0) {
            rightflag = 0;
        }
        else {
            rightflag = 1;
        }
    }
    
    NSArray *right = [[NSArray alloc] initWithObjects:rightValue,nil];
    [self buildUI:delegate title:nil segmentedArray:segmentedArray left:leftValue right:right];
}

/*!
 * 默认导航栏[标题＋图文返回按钮＋自定义右边按钮(后缀为.png为图片，否则为文字)]
 */
- (void)initNavItemBackImage:(id<NavigationItemDelegate>)delegate title:(NSString*)title rightValue:(NSString*)rightValue {
    titleflag = 0;
    leftflag = 1;
    NSArray *right;
    if (rightValue == nil) {
        rightflag = -1;
        right = [[NSArray alloc] initWithObjects:@"",nil];
    }
    else {
        //判断是否图片还是文字
        NSRange rangeValue = [rightValue rangeOfString:@".png"];
        if (rangeValue.length > 0) {
            rightflag = 0;
        }
        else {
            rightflag = 1;
        }
        right = [[NSArray alloc] initWithObjects:rightValue,nil];
    }
    [self buildUI:delegate title:title segmentedArray:nil left:@"ic_arrow_left" right:right];
}

/*!
 * 默认导航栏[标题＋返回按钮＋双自定义右边图片按钮]
 */
- (void)initNavItemBackImage:(id<NavigationItemDelegate>)delegate title:(NSString*)title imageArray:(NSArray*)imageArray {
    titleflag = 0;
    leftflag = 4;
    if (imageArray == nil) {
        rightflag = -1;
    }
    else {
        rightflag = 2;
    }
    [self buildUI:delegate title:title segmentedArray:nil left:@"关闭" right:imageArray];
    
}

/*!
 * 默认导航栏[标题＋返回按钮＋双自定义右边图片按钮]
 */
- (void)initNavItemArray:(id<NavigationItemDelegate>)delegate title:(NSString*)title imageArray:(NSArray*)imageArray {
    titleflag = 0;
    leftflag = 0;
    if (imageArray == nil) {
        rightflag = -1;
    }
    else {
        rightflag = 2;
    }
    [self buildUI:delegate title:title segmentedArray:nil left:@"ic_arrow_left" right:imageArray];
}

- (IBAction)backAction
{
    [self.navDelegate backSelection];
}

- (IBAction)leftAction
{
    [self.navDelegate leftSelection];
}

- (IBAction)rightAction
{
    [self.navDelegate rightSelection];
}

- (void)rightAction:(UIButton*)sender
{
    [self.navDelegate rightSelection:sender];
}

- (void)segmentAction:(UISegmentedControl *)Seg
{
    [self.navDelegate segmentAction:Seg];
}

@end
