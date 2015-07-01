//
//  CustomPopView.m
//  淘小店
//
//  Created by u1city01 on 14-9-29.
//  Copyright (c) 2014年 u1city01. All rights reserved.
//

#import "CustomPopView.h"
#import <QuartzCore/CALayer.h>

#define CANCEL_BUTTON_COLOR                     [UIColor colorWithRed:196/255.00f green:196/255.00f blue:196/255.00f alpha:1]
#define DESTRUCTIVE_BUTTON_COLOR                [UIColor colorWithRed:185/255.00f green:45/255.00f blue:39/255.00f alpha:1]
#define OTHER_BUTTON_COLOR                      [UIColor whiteColor]
#define ACTIONSHEET_BACKGROUNDCOLOR             [UIColor colorWithRed:240/255.00f green:240/255.00f blue:240/255.00f alpha:1.0]
#define WINDOW_COLOR                            [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4]
#define CORNER_RADIUS                           5

#define BUTTON_INTERVAL_HEIGHT                  5
#define BUTTON_HEIGHT                           40
#define BUTTON_INTERVAL_WIDTH                   KSCREEN_WIDTH-70
#define BUTTON_WIDTH                            60
#define BUTTONTITLE_FONT                        [UIFont fontWithName:@"HelveticaNeue-Bold" size:18]
#define BUTTON_BORDER_WIDTH                     0.0f
#define BUTTON_BORDER_COLOR                     [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.8].CGColor
#define BUTTON_FONT_COLOR                       [UIColor colorWithRed:32/255.00f green:163/255.00f blue:255/255.00f alpha:1]

#define CUSTOMVIEW_INTERVAL_HEIGHT                  0
#define CUSTOMVIEW_HEIGHT                           200
#define CUSTOMVIEW_INTERVAL_WIDTH                   0

#define ANIMATE_DURATION                        0.25f

@interface CustomPopView ()

@property (nonatomic,strong) UIView *backGroundView;
@property (nonatomic,assign) CGFloat LXActionSheetHeight;
@property (nonatomic,assign) id<CustomPopDelegate>delegate;

@end

@implementation CustomPopView

#pragma mark - Public method

- (id)initWithTitle:(NSString *)title delegate:(id<CustomPopDelegate>)delegate customView:(UIView *)customView
{
    self = [super init];
    if (self) {
        
        //初始化背景视图，添加手势
        self.frame = CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT);
        self.backgroundColor = WINDOW_COLOR;
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedCancel)];
        [self addGestureRecognizer:tapGesture];
        
        if (delegate) {
            self.delegate = delegate;
        }
        
        [self creatButtonsWithTitle:title confirmButtonTitle:@"确定" customView:customView];
        
    }
    return self;
}

- (void)showInView:(UIView *)view
{
    [[UIApplication sharedApplication].delegate.window.rootViewController.view addSubview:self];
}

#pragma mark - CreatButtonAndTitle method

- (void)creatButtonsWithTitle:(NSString *)title confirmButtonTitle:(NSString *)confirmButtonTitle customView:(UIView *)customView
{
    //初始化LXACtionView的高度为0
    self.LXActionSheetHeight = 0;
    
    //生成LXActionSheetView
    self.backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, KSCREEN_HEIGHT, KSCREEN_WIDTH, 0)];
    self.backGroundView.backgroundColor = ACTIONSHEET_BACKGROUNDCOLOR;
    
    //给LXActionSheetView添加响应事件
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedBackGroundView)];
    [self.backGroundView addGestureRecognizer:tapGesture];
    
    [self addSubview:self.backGroundView];
    
    if (confirmButtonTitle) {
        UIButton *confirmButton = [self creatConfirmButtonWith:confirmButtonTitle];
        
        [confirmButton addTarget:self action:@selector(clickOnButtonWith:) forControlEvents:UIControlEventTouchUpInside];
        
        self.LXActionSheetHeight = self.LXActionSheetHeight + 2*BUTTON_INTERVAL_HEIGHT+BUTTON_HEIGHT;

        [self.backGroundView addSubview:confirmButton];
    }
    
    if (customView) {
        customView.frame = CGRectMake(CUSTOMVIEW_INTERVAL_WIDTH, self.LXActionSheetHeight+CUSTOMVIEW_INTERVAL_HEIGHT, KSCREEN_WIDTH, CUSTOMVIEW_HEIGHT);

        self.LXActionSheetHeight = self.LXActionSheetHeight + 2*CUSTOMVIEW_INTERVAL_HEIGHT+CUSTOMVIEW_HEIGHT;
        [self.backGroundView addSubview:customView];
    }
    
    [UIView animateWithDuration:ANIMATE_DURATION animations:^{
        [self.backGroundView setFrame:CGRectMake(0, KSCREEN_HEIGHT-self.LXActionSheetHeight, KSCREEN_WIDTH, self.LXActionSheetHeight)];
    } completion:^(BOOL finished) {
    }];
}

- (UIButton *)creatConfirmButtonWith:(NSString *)confirmButtonTitle
{
    UIButton *confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(BUTTON_INTERVAL_WIDTH, BUTTON_INTERVAL_HEIGHT, BUTTON_WIDTH, BUTTON_HEIGHT)];
    //confirmButton.layer.masksToBounds = YES;
    //confirmButton.layer.cornerRadius = CORNER_RADIUS;
    
    //confirmButton.layer.borderWidth = BUTTON_BORDER_WIDTH;
    //confirmButton.layer.borderColor = BUTTON_BORDER_COLOR;
    
    //confirmButton.backgroundColor = CANCEL_BUTTON_COLOR;
    confirmButton.backgroundColor = [UIColor clearColor];
    [confirmButton setTitle:confirmButtonTitle forState:UIControlStateNormal];
    confirmButton.titleLabel.font = BUTTONTITLE_FONT;
    [confirmButton setTitleColor:BUTTON_FONT_COLOR forState:UIControlStateNormal];
    [confirmButton setTitleColor:BUTTON_FONT_COLOR forState:UIControlStateHighlighted];
    return confirmButton;
}

- (void)clickOnButtonWith:(UIButton *)button
{
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(didClickOnConfirmButton)] == YES) {
            [self.delegate didClickOnConfirmButton];
        }
    }
    
    [self tappedCancel];
}

- (void)tappedCancel
{
    [UIView animateWithDuration:ANIMATE_DURATION animations:^{
        [self.backGroundView setFrame:CGRectMake(0, KSCREEN_HEIGHT, KSCREEN_WIDTH, 0)];
        self.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

- (void)tappedBackGroundView
{
    //
}

@end
