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
#import "CommonHelper.h"

@interface SerialNumberViewController ()

@end

@implementation SerialNumberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initNavItem:@"查看序列号"];
    
    _cust=[[UIEngine getinstance] getCustomerModel];
    //第一次安装启动APP生成序列号
    if (_cust.serialNumber==nil) {
        NSString *strSerailNumber=[NSString stringWithFormat:@"%@",[self createAppSerialNums]];
        _cust.serialNumber=strSerailNumber;
        [[UIEngine getinstance] setCustomerModel:_cust];
    }
    [self buildUI];
}

//创建页面视图
- (void)buildUI {
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, KSCREEN_WIDTH, KSCREEN_HEIGHT-64)];
    [self.view addSubview:baseView];
    
    //背景
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:baseView.bounds];
    bgImageView.image = [UIImage imageNamed:@"ic_main_bg"];
    [baseView addSubview:bgImageView];
    
    //提示文本
    UILabel *topLabelView=[[UILabel alloc] initWithFrame:CGRectMake(30*SCALAE, 80*SCALAE, baseView.frame.size.width-60*SCALAE, 30*SCALAE)];
    topLabelView.text=@"本软件的序列号为：";
    topLabelView.textColor=[ColorHelper colorWithHexString:@"#ffffff"];
    topLabelView.backgroundColor=[UIColor clearColor];
    topLabelView.textAlignment=NSTextAlignmentLeft;
    topLabelView.font=[UIFont systemFontOfSize:28*SCALAE];
    [baseView addSubview:topLabelView];
    
    //序列号
    UILabel *serialNumberLabelView=[[UILabel alloc] initWithFrame:CGRectMake(30*SCALAE, CGRectGetMaxY(topLabelView.frame)+20*SCALAE, baseView.frame.size.width-60*SCALAE, 120*SCALAE)];
    if (_cust.serialNumber!=nil) {
        serialNumberLabelView.text=_cust.serialNumber;
    }
    serialNumberLabelView.textColor=[ColorHelper colorWithHexString:@"#ffffff"];
    serialNumberLabelView.backgroundColor=[ColorHelper colorWithHexString:@"#1c6743"];
    serialNumberLabelView.textAlignment=NSTextAlignmentCenter;
    serialNumberLabelView.font=[UIFont systemFontOfSize:36*SCALAE];
    serialNumberLabelView.layer.masksToBounds=YES;
    serialNumberLabelView.layer.borderWidth=2;
    serialNumberLabelView.layer.borderColor=[UIColor blackColor].CGColor;
    serialNumberLabelView.layer.cornerRadius=15*SCALAE;
    [baseView addSubview:serialNumberLabelView];
    
    //提示文本
    UILabel *bottomLabelView=[[UILabel alloc] initWithFrame:CGRectMake(30*SCALAE, CGRectGetMaxY(serialNumberLabelView.frame)+20*SCALAE, baseView.frame.size.width-60*SCALAE, 80*SCALAE)];
    bottomLabelView.text=@"请登录凤凰娱乐进行手机安全中心的绑定及管理，绑定及管理时需要提供此序列号";
    bottomLabelView.textColor=[ColorHelper colorWithHexString:@"#ffffff"];
    bottomLabelView.backgroundColor=[UIColor clearColor];
    bottomLabelView.font=[UIFont systemFontOfSize:28*SCALAE];
    bottomLabelView.numberOfLines=0;
    [baseView addSubview:bottomLabelView];
}


-(void)backSelection{
    if (self.pageType==0) {
        //进入首页
        [[UIEngine getinstance] loginInMainView];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}


/*!
 * @method 根据手机唯一码产生app序列号
 * @result 生成一个纯32位数字序列号
 */
-(NSString *) createAppSerialNums{
    NSString *strResult=@"";
    //根据手机唯一码产生app序列号
    NSString *uId = [[UIDevice currentDevice].identifierForVendor UUIDString];
    NSString *strNewNums=[uId stringByReplacingOccurrencesOfString:@"-" withString:@""];//32位
    strNewNums = [CommonHelper stringToSingleNum:strNewNums];//转成纯数字
    strNewNums=[CommonHelper shortString:strNewNums andLength:12];
    
    NSString *strDate=@"";
    NSDate *date = [NSDate date];//当前日期
    NSDateFormatter *formatter= [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMddHHmm"];
    strDate=[formatter stringFromDate:date];
    if (strDate.length==8) {
        strDate=[NSString stringWithFormat:@"%@%@%@%@",
                 [strDate substringWithRange:NSMakeRange(1, 1)],
                 [strDate substringWithRange:NSMakeRange(3, 1)],
                 [strDate substringWithRange:NSMakeRange(5, 1)],
                 [strDate substringWithRange:NSMakeRange(7, 1)]];
    }
    strResult=[NSString stringWithFormat:@"%@%@",strNewNums,strDate];
    if (strResult.length==16) {
        strResult=[NSString stringWithFormat:@"%@-%@-%@-%@",
                   [strResult substringWithRange:NSMakeRange(0, 4)],
                   [strResult substringWithRange:NSMakeRange(4, 4)],
                   [strResult substringWithRange:NSMakeRange(8, 4)],
                   [strResult substringWithRange:NSMakeRange(12, 4)]];
    }
    return strResult;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
