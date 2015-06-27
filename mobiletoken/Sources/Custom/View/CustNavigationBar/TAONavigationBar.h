//
//  TAONavigationBar.h
//  TaoShop
//
//  Created by u1city01 on 14-7-29.
//  Copyright (c) 2014年 u1city01. All rights reserved.
//

#import <UIKit/UIKit.h>

/*!
 * 导航事件代理
 */
@protocol NavigationItemDelegate <NSObject>
@required
- (void)backSelection;
- (void)leftSelection;
- (void)rightSelection;
- (void)rightSelection:(UIButton*)sender;
- (void)segmentAction:(UISegmentedControl *)Seg;
@end

@interface TAONavigationBar : UINavigationBar
{
    int titleflag;//标题类型 0-UILabel 1-UISegmentedControl
    int leftflag;//左边按钮类型 0-默认返回 1-图文返回 2-自定义图片按钮 3-自定义文字按钮 4-图文返回+文字按钮
    int rightflag;//右边按钮类型 0-自定义图片按钮 1-自定义文字按钮 2-双自定义图片按钮
}

@property(nonatomic,assign)BOOL isMainVC;
@property (nonatomic, readonly) UILabel *m_lblTitle;
@property (nonatomic, readonly) UIImageView *m_imgViewBg;
@property (nonatomic, readonly) UIButton *m_btnLeft;
@property (nonatomic, readonly) UIButton *m_btnLeft1;
@property (nonatomic, readonly) UIButton *m_btnRight;
@property (nonatomic, readonly) UIButton *m_btnRight1;
@property (nonatomic, readonly) UISegmentedControl *m_segControl;
@property (nonatomic,assign) id<NavigationItemDelegate> navDelegate;

/*!
 * 默认导航栏[标题＋返回按钮]
 */
- (void)initNavItem:(id<NavigationItemDelegate>)delegate title:(NSString*)title;

/*!
 * 默认导航栏[标题＋默认返回按钮＋自定义右边按钮(后缀为.png为图片，否则为文字)]
 */
- (void)initNavItem:(id<NavigationItemDelegate>)delegate title:(NSString*)title rightValue:(NSString*)rightValue;

/*!
 * 默认导航栏[标题＋自定义左边按钮＋自定义右边按钮(后缀为.png为图片，否则为文字)]
 */
- (void)initNavItem:(id<NavigationItemDelegate>)delegate title:(NSString*)title leftValue:(NSString*)leftValue rightValue:(NSString*)rightValue;


/*!
 * 默认导航栏[标题分段控件＋自定义右边按钮(后缀为.png为图片，否则为文字)]
 */
- (void)initNavItemSegment:(id<NavigationItemDelegate>)delegate title:(NSArray*)segmentedArray rightValue:(NSString*)rightValue;

/*!
 * 默认导航栏[标题分段控件＋自定义左边按钮、自定义右边按钮(后缀为.png为图片，否则为文字)]
 */
- (void)initNavItemSegment:(id<NavigationItemDelegate>)delegate title:(NSArray*)segmentedArray leftValue:(NSString *)leftValue rightValue:(NSString*)rightValue;


/*!
 * 默认导航栏[标题＋图文返回按钮＋自定义右边按钮(后缀为.png为图片，否则为文字)]
 */
- (void)initNavItemBackImage:(id<NavigationItemDelegate>)delegate title:(NSString*)title rightValue:(NSString*)rightValue;

/*!
 * 默认导航栏[标题＋返回按钮＋双自定义右边图片按钮]
 */
- (void)initNavItemBackImage:(id<NavigationItemDelegate>)delegate title:(NSString*)title imageArray:(NSArray*)imageArray;


/*!
 * 默认导航栏[标题＋返回按钮＋双自定义右边图片按钮]
 */
- (void)initNavItemArray:(id<NavigationItemDelegate>)delegate title:(NSString*)title imageArray:(NSArray*)imageArray;

@end
