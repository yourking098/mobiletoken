//
//  SetupViewController.m
//  mobiletoken
//
//  Created by u1city01 on 15/6/24.
//  Copyright (c) 2015年 mobiletoken. All rights reserved.
//

#import "SetupViewController.h"
#import "CalibrationTimeViewController.h"
#import "SerialNumberViewController.h"
#import "HelperViewController.h"

@interface SetupViewController ()

@end

@implementation SetupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initNavItem:@"设置" leftValue:@"" rightValue:@""];
    [self buildUI];
}

//创建页面视图
- (void)buildUI {
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, KSCREEN_WIDTH, KSCREEN_HEIGHT-64-49)];
    [self.view addSubview:baseView];
    
    //背景
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:baseView.bounds];
    bgImageView.image = [UIImage imageNamed:@"ic_main_bg"];
    [baseView addSubview:bgImageView];
    
    //按钮区域
    UIView *buttonView = [[UIView alloc] initWithFrame:CGRectMake(30*SCALAE, 40*SCALAE, baseView.frame.size.width-60*SCALAE, 360*SCALAE)];
    buttonView.layer.masksToBounds=YES;
    buttonView.layer.borderWidth=2;
    buttonView.layer.borderColor=[UIColor blackColor].CGColor;
    buttonView.layer.cornerRadius=15*SCALAE;
    [baseView addSubview:buttonView];
    
    NSArray *buttonlist = [NSArray arrayWithObjects:@"校准时间",@"查看序列号",@"帮助", nil];
    
    //按钮
    for (int i=0;i<3;i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, i*120*SCALAE, buttonView.frame.size.width, 120*SCALAE);
        button.backgroundColor=[ColorHelper colorWithHexString:@"#1c6743"];
        [button addTarget:self action:@selector(onClickbutton:) forControlEvents:UIControlEventTouchUpInside];
        button.tag=i;
        [buttonView addSubview:button];
        
        UILabel *labelView=[[UILabel alloc] initWithFrame:CGRectMake(30*SCALAE, i*120*SCALAE+20*SCALAE, buttonView.frame.size.width-60*SCALAE, 80*SCALAE)];
        labelView.text=buttonlist[i];
        labelView.textColor=[ColorHelper colorWithHexString:@"#ffffff"];
        labelView.backgroundColor=[UIColor clearColor];
        labelView.textAlignment=NSTextAlignmentLeft;
        labelView.font=[UIFont systemFontOfSize:32*SCALAE];
        [buttonView addSubview:labelView];
        
        UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(buttonView.frame.size.width-60*SCALAE, i*120*SCALAE+((120*SCALAE-30*SCALAE*28/19)/2), 30*SCALAE, 30*SCALAE*28/19)];
        arrowImageView.image = [UIImage imageNamed:@"ic_arrow_off"];
        [buttonView addSubview:arrowImageView];
        
        if (i<2) {
            UIView *lineTopView = [[UIView alloc] initWithFrame:CGRectMake(0, (i+1)*120*SCALAE-0.5, buttonView.frame.size.width, 0.5f)];
            lineTopView.backgroundColor=[ColorHelper colorWithHexString:@"#0f5d31"];
            [buttonView addSubview:lineTopView];
            UIView *lineBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, (i+1)*120*SCALAE, buttonView.frame.size.width, 0.5f)];
            lineBottomView.backgroundColor=[ColorHelper colorWithHexString:@"#349c6c"];
            [buttonView addSubview:lineBottomView];
        }
    }
}

//按钮点击事件
- (void)onClickbutton:(UIButton*)sender {
    switch ((int)sender.tag) {
        case 0:
        {
            //校准时间
            CalibrationTimeViewController *calibrationTimeVC = [[CalibrationTimeViewController alloc] init];
            [[UIEngine getinstance] pushView:calibrationTimeVC viewController:self shouldHideTabbar:YES];
        }
            break;
        case 1:
        {
            //查看序列号
            SerialNumberViewController *serialNumberVC = [[SerialNumberViewController alloc] init];
            serialNumberVC.pageType=1;
            [[UIEngine getinstance] pushView:serialNumberVC viewController:self shouldHideTabbar:YES];
        }
            break;
        case 2:
        {
            //帮助
            HelperViewController *helperVC = [[HelperViewController alloc] init];
            [[UIEngine getinstance] pushView:helperVC viewController:self shouldHideTabbar:YES];
        }
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
