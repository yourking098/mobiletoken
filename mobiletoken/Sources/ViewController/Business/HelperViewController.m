//
//  HelperViewController.m
//  mobiletoken
//
//  Created by u1city01 on 15/6/27.
//  Copyright (c) 2015年 mobiletoken. All rights reserved.
//

#import "HelperViewController.h"

@interface HelperViewController ()

@end

@implementation HelperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initNavItem:@"帮助"];
    
    
    [self buildUI];
}

-(void) buildUI{
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, KSCREEN_WIDTH, KSCREEN_HEIGHT-64)];
    [self.view addSubview:baseView];
    
    //背景
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:baseView.bounds];
    bgImageView.image = [UIImage imageNamed:@"ic_main_bg"];
    [baseView addSubview:bgImageView];

    
    NSArray *titleArray=@[@"如何绑定手机安全中心？",@"如何使用手机安全中心？",@"为什么验证码总是提示错误？",@"我可以修改或解除手机安全中心的绑定吗？",@"我的手机丢失了，或者手机安全中心被卸载了，怎么办？"];
    NSArray *contentArray=@[@"答：在手机安全中心-设置-查看序列号中得到您的序列号，登陆游戏平台-我的账户-用户安全中，将手机安全中心序列号与您的账号进行绑定。",@"答：在游戏平台中需要填入手机安全中心验证码的地方，填入手机安全中心的动态验证码，以进行下一步操作，如转账、提现、修改密码等。",@"答：请校准您的手机安全中心的时间(北京时间为准)。您可以在设置-校准时间中进行联网自动校准时间，也可以手动校准时间。",@"答：可以。当您更换手机或者其他情况需要修改、解除手机安全中心的绑定时，您可以在我的账户-用户安全中进行操作。如果仍不能解决，请联系在线客服协助解决。",@"答：您可以在游戏平台进行修改或解除绑定。如果仍不能解决，请联系在线客服协助处理。"];
    CGFloat currentTitleY=25*SCALAE;
    for (int i=0; i<titleArray.count; i++) {
        NSString *strTitle=titleArray[i];
        NSString *strContent=contentArray[i];
        CGSize sizeTitle=[strTitle sizeWithFont:[UIFont systemFontOfSize:32*SCALAE]constrainedToSize:CGSizeMake(KSCREEN_WIDTH-20*SCALAE*2, MAXFLOAT)];
        UILabel *lblTitle=[[BaseView alloc] buildLabel:CGRectMake(20*SCALAE, currentTitleY, sizeTitle.width, sizeTitle.height) title:titleArray[i] color:@"BFC95C" font:[UIFont systemFontOfSize:32*SCALAE] align:NSTextAlignmentLeft line:0];
        lblTitle.tag=i;
        [baseView addSubview:lblTitle];
        
        
        CGSize sizeContent=[strContent sizeWithFont:[UIFont systemFontOfSize:28*SCALAE] constrainedToSize:CGSizeMake(KSCREEN_WIDTH-20*SCALAE*2, MAXFLOAT)];
        UILabel *lblContent=[[BaseView alloc] buildLabel:CGRectMake(20*SCALAE, lblTitle.bottom+20*SCALAE, sizeContent.width, sizeContent.height) title:contentArray[i] color:@"FFFFFF" font:[UIFont systemFontOfSize:28*SCALAE] align:NSTextAlignmentLeft line:0];
        lblContent.tag=i*10;
        [baseView addSubview:lblContent];
        
        currentTitleY=lblContent.bottom+25*SCALAE;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
