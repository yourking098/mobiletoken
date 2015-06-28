//
//  SerialNumberViewController.m
//  mobiletoken
//
//  Created by u1city01 on 15/6/27.
//  Copyright (c) 2015年 mobiletoken. All rights reserved.
//

#import "SerialNumberViewController.h"
#import "UIView+QM_Category.h"
#import "UIEngine.h"

@interface SerialNumberViewController ()

@end

@implementation SerialNumberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initNavItem:@"查看序列号"];
    [self buildUI];
}


-(void) buildUI{
    CGRect rectSerial=CGRectMake(0, 150, KSCREEN_WIDTH, 20);
    UIFont *sysFont = [UIFont systemFontOfSize:16];
    UILabel *lblSerialNum=[[BaseView alloc] buildLabel:rectSerial title:@"当前序列号：123456" color:@"#999999" font:sysFont align:NSTextAlignmentCenter];
    [self.view addSubview:lblSerialNum];
    
    CGFloat btnW=150;
    CGFloat btnH=50;
    CGFloat btnX=(KSCREEN_WIDTH-btnW)/2.0;
    CGFloat btnY=lblSerialNum.bottom+50;
    CGRect btnRect=CGRectMake(btnX, btnY, btnW, btnH);
    UIFont *btnFont=[UIFont systemFontOfSize:16];
    
    UIButton *button= [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=btnRect;
    button.backgroundColor = [ColorHelper colorWithHexString:@"#FF6347"];
    button.titleLabel.font = btnFont;
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    button.layer.cornerRadius = 10*SCALAE;
    [button setTitle:@"进入首页" forState:UIControlStateNormal];
    [button setTitleColor:[ColorHelper colorWithHexString:@"#FFFFFF"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(loginMainView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

}

-(void) loginMainView{
    //进入首页
    [[UIEngine getinstance] loginInMainView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
