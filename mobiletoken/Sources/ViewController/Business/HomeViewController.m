//
//  HomeViewController.m
//  mobiletoken
//
//  Created by u1city01 on 15/6/24.
//  Copyright (c) 2015年 mobiletoken. All rights reserved.
//

#import "HomeViewController.h"
#import "AesHelper.h"
#import "CommonHelper.h"

@import AVFoundation;

@interface HomeViewController (){
    NSString *_mcodeForios;
    NSString *_strCheckCode;
}

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initNavItem:@"首页"];
    _cust=[[UIEngine getinstance] getCustomerModel];
    _mcodeForios =@"Y*8#!H19*(0)";//干扰码
    _strCheckCode=@"";
    [self buildUI];
    
}

-(void) buildUI{
    if (_cust.serialNumber!=nil) {
        _strCheckCode = [self createAuthCodeForIos:_cust.serialNumber];
    }
    
    CGRect rectSerial=CGRectMake(0, 150, KSCREEN_WIDTH, 20);
    UIFont *sysFont = [UIFont systemFontOfSize:16];
    _lblCheckCode=[[BaseView alloc] buildLabel:rectSerial title:_strCheckCode color:@"#999999" font:sysFont align:NSTextAlignmentCenter];
    [self.view addSubview:_lblCheckCode];
    
    CGFloat btnW=150;
    CGFloat btnH=50;
    CGFloat btnX=(KSCREEN_WIDTH-btnW)/2.0;
    CGFloat btnY=_lblCheckCode.bottom+50;
    CGRect btnRect=CGRectMake(btnX, btnY, btnW, btnH);
    UIFont *btnFont=[UIFont systemFontOfSize:16];
    
    UIButton *button= [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=btnRect;
    button.backgroundColor = [ColorHelper colorWithHexString:@"#FF6347"];
    button.titleLabel.font = btnFont;
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    button.layer.cornerRadius = 10*SCALAE;
    [button setTitle:@"语音播报" forState:UIControlStateNormal];
    [button setTitleColor:[ColorHelper colorWithHexString:@"#FFFFFF"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(voice) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
}

-(void) voice{
    if(IsiOS7Later){
        NSString *strCodeSigleNum=@"";
        AVSpeechUtterance *utterance;
        AVSpeechSynthesizer *synth = [[AVSpeechSynthesizer alloc] init];
        //获取当前系统语音
        AVSpeechSynthesisVoice *voice;
        for(int i=0;i<_strCheckCode.length;i++){
            NSRange range1=[_strCheckCode rangeOfComposedCharacterSequenceAtIndex:i];
            strCodeSigleNum=[_strCheckCode substringWithRange:range1];
            utterance = [AVSpeechUtterance speechUtteranceWithString:strCodeSigleNum];
            voice= [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-tw"];//台湾  zh-cn
            utterance.voice = voice;
            utterance.rate *= 0.166;
            utterance.pitchMultiplier = 1.0;
            [synth speakUtterance:utterance];
        }
    }
}

/*!
 * @method 每30秒生成一个验证码
 * @param 序列号
 * @result 返回6位验证码
 */
- (NSString *) createAuthCodeForIos:(NSString *)strCode{
    NSString *strDate=@"";
    NSDate *date = [NSDate date];//当前日期
    NSDateFormatter *formatter= [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyMMddHHmm-ss"];
    strDate=[formatter stringFromDate:date];
    
    NSArray *dArr=[strDate componentsSeparatedByString:@"-"];
    NSString *dateNums = dArr[0];
    NSString *strSecond= dArr[1];
    if ([strSecond intValue]>=30) {//秒是固定的两个数值
        dateNums=[dateNums stringByAppendingString:@"48"];
    }else{
        dateNums=[dateNums stringByAppendingString:@"16"];
    }
    NSString *strNewNums=[NSString stringWithFormat:@"%@%@%@",
                          [dateNums substringWithRange:NSMakeRange(3, 9)],
                          strCode,
                          [dateNums substringWithRange:NSMakeRange(0, 3)]
                          ];
    strNewNums=[self avgMergeStr:strNewNums andStr2:_mcodeForios];//合并常量
    strNewNums = [AesHelper md5:strNewNums];//MD5加密   32位
    strNewNums = [CommonHelper stringToSingleNum:strNewNums];//转成纯数字
    strNewNums = [CommonHelper shortString:strNewNums andLength:6];//缩短成6个数字
    
    return strNewNums;
    
}


-(NSString *) avgMergeStr:(NSString *)str1 andStr2:(NSString *)str2{
    NSUInteger len1 = str1.length;
    NSUInteger len2 = str2.length;
    NSString *result = @"";
    if (len1>=len2) {//str1比较长
        for (int i = 0; i < len2; i++) {
            NSRange range1=[str1 rangeOfComposedCharacterSequenceAtIndex:i];
            NSRange range2=[str2 rangeOfComposedCharacterSequenceAtIndex:i];
            NSString *strRange1=[str1 substringWithRange:range1];
            NSString *strRange2=[str2 substringWithRange:range2];
            result=[result stringByAppendingFormat:@"%@",strRange1];
            result=[result stringByAppendingFormat:@"%@",strRange2];
        }
        if (len1 > len2)
            result =[result stringByAppendingFormat:@"%@",[str1 substringFromIndex:len2]];//把str1剩余部分加回来
    } else {//str2比较长
        for (int i = 0; i < len1; i++) {
            NSRange range1=[str1 rangeOfComposedCharacterSequenceAtIndex:i];
            NSRange range2=[str2 rangeOfComposedCharacterSequenceAtIndex:i];
            NSString *strRange1=[str1 substringWithRange:range1];
            NSString *strRange2=[str2 substringWithRange:range2];
            result=[result stringByAppendingFormat:@"%@",strRange1];
            result=[result stringByAppendingFormat:@"%@",strRange2];
        }
        result =[result stringByAppendingFormat:@"%@",[str2 substringFromIndex:len1]];//把str2剩余部分加回来
    }
    return result;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
