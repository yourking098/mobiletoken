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
    [self initNavItem:@"每30秒更新一次"];
    _cust=[[UIEngine getinstance] getCustomerModel];
    _mcodeForios =@"Y*8#!H19*(0)";//干扰码
    _strCheckCode=@"";
    [self buildUI];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(animation1:) userInfo:nil repeats:YES];
    
}

-(void) buildUI{
    _strCheckCode = [self createAuthCodeForIos:_cust.serialNumber];
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
    
    CGRect sliderFrame = CGRectMake(60, button.bottom+50, 200, 200);
    _circularSlider = [[EFCircularSlider alloc] initWithFrame:sliderFrame];
    [_circularSlider addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    
    _circularSlider.minimumValue=0;
    _circularSlider.maximumValue=30;
    _circularSlider.currentValue=0;
    [self.view addSubview:_circularSlider];
}

-(void)animation1:(NSTimer *)timer {
    if (_circularSlider.currentValue >= 30) {
        _circularSlider.currentValue = 0.00;
        _strCheckCode = [self createAuthCodeForIos:_cust.serialNumber];
        _lblCheckCode.text=_strCheckCode;
    } else {
        _circularSlider.currentValue=_circularSlider.currentValue+0.01;
    }
    NSLog(@"%.2lf",_circularSlider.currentValue);
}


-(void)valueChanged:(EFCircularSlider*)slider {
    NSLog(@"%.02f",slider.currentValue);
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
    } else {
        [self showPromptMessage:@"对不起，您的设备不支持语音播报！" andImageNameType:PromptOK];
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
    strNewNums = [CommonHelper avgMergeStr:strNewNums andStr2:_mcodeForios];//合并常量
    strNewNums = [AesHelper md5:strNewNums];//MD5加密   32位
    strNewNums = [CommonHelper stringToSingleNum:strNewNums];//转成纯数字
    strNewNums = [CommonHelper shortString:strNewNums andLength:6];//缩短成6个数字
    return strNewNums;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
