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

@import AVFoundation;//语音播报

@interface HomeViewController (){
    NSString *_mcodeForios;
    NSString *_strCheckCode;
    
    CGFloat _currentPercent;//当前走了多少
    CGFloat _timeInterval;//定时器每隔几秒触发一次事件
    CGFloat _eachIntervalPercent;//每隔_timeInterval走百分几
    
    BOOL _isRead;
}

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initNavItem:@"每30秒更新一次"];
    _cust=[[UIEngine getinstance] getCustomerModel];
    _mcodeForios =@"Y*8#!H19*(0)";//混淆干扰码
    _strCheckCode=@"";
    self.view.backgroundColor=[ColorHelper colorWithHexString:@"#003E25"];
    
    [self buildUI];
    
    _currentPercent=0;//当前定时器走了百分比
    _timeInterval=0.01;//定时器每隔0.01秒触发一次事件
    
    CGFloat totalSecond=30.00;//转一圈定时花30秒
    _eachIntervalPercent=(100.00/totalSecond)*_timeInterval;//每秒走百分之3.33333，每0.01秒走 百分比
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:_timeInterval target:self selector:@selector(animation1:) userInfo:nil repeats:YES];//定时器
}

-(void) buildUI{
    //圆环
    CGFloat goalBarX=0;
    CGFloat goalBarW=KSCREEN_WIDTH;
    CGFloat goalBarH=goalBarW;
    CGFloat goalBarY=(KSCREEN_HEIGHT-goalBarH)/2.0;
    _myGoalBar=[[KDGoalBar alloc] initWithFrame:CGRectMake(goalBarX, goalBarY, goalBarW, goalBarH)];
    _myGoalBar.backgroundColor=[UIColor clearColor];
    [_myGoalBar setAllowDragging:NO];
    [_myGoalBar setAllowSwitching:NO];
    [_myGoalBar setPercent:_currentPercent animated:NO];
    [self.view addSubview:_myGoalBar];
    
    //验证码
    _strCheckCode = [self createAuthCodeForIos:_cust.serialNumber];
    CGFloat checkCodeH=40;
    CGFloat checkCodeW=KSCREEN_WIDTH;
    CGFloat checkCodeY=(KSCREEN_HEIGHT-checkCodeH)/2.0;
    UIFont *sysFont = [UIFont systemFontOfSize:checkCodeH];
    _lblCheckCode=[[BaseView alloc] buildLabel:CGRectMake(0, checkCodeY, checkCodeW, checkCodeH) title:_strCheckCode color:@"#FFFFFF" font:sysFont align:NSTextAlignmentCenter];
    [self.view addSubview:_lblCheckCode];
    
    //当前验证码为
    UILabel *lblCurrentCheckCodeWord=[[BaseView alloc] buildLabel:CGRectMake(0, _lblCheckCode.top-14-30*SCALAE, KSCREEN_WIDTH, 14) title:@"当前验证码为" color:@"4BB789" font:[UIFont systemFontOfSize:14] align:NSTextAlignmentCenter];
    [self.view addSubview:lblCurrentCheckCodeWord];
    
    //语音播报
    CGFloat btnW=60;
    CGFloat btnH=25;
    CGFloat btnX=(KSCREEN_WIDTH-btnW)/2.0;
    CGFloat btnY=_lblCheckCode.bottom+30*SCALAE;
    CGRect btnRect=CGRectMake(btnX, btnY, btnW, btnH);
    UIFont *btnFont=[UIFont systemFontOfSize:12];
    UIButton *button= [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=btnRect;
    button.backgroundColor = [ColorHelper colorWithHexString:@"#FF6347"];
    button.titleLabel.font = btnFont;
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    button.layer.cornerRadius = 10*SCALAE;
    [button setTitle:@"语音播报" forState:UIControlStateNormal];
    [button setTitleColor:[ColorHelper colorWithHexString:@"#FFFFFF"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(brocastCheckCode) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

-(void)animation1:(NSTimer *)timer {
    if (_currentPercent >= 100.00) {
        _currentPercent = 0;
        _strCheckCode = [self createAuthCodeForIos:_cust.serialNumber];
        _lblCheckCode.text=_strCheckCode;
    } else {
        _currentPercent=_currentPercent+_eachIntervalPercent;
    }
    [_myGoalBar setPercent:_currentPercent animated:NO];
}

-(void) brocastCheckCode{
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
