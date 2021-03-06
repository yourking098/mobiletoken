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
    [self initNavItem:@"每30秒更新一次" leftValue:nil rightValue:nil];
    _cust=[[UIEngine getinstance] getCustomerModel];
    _mcodeForios =@"Y*8#!H19*(0)";//混淆干扰码
    _strCheckCode=@"";
    
    [self buildUI];
    
    _currentPercent=0;//当前定时器走了百分比
    _timeInterval=0.01;//定时器每隔0.01秒触发一次事件
    
    CGFloat totalSecond=30.00;//转一圈定时花30秒
    _eachIntervalPercent=(100.00/totalSecond)*_timeInterval;//每秒走百分之3.33333，每0.01秒走 百分比
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:_timeInterval target:self selector:@selector(animation1:) userInfo:nil repeats:YES];//定时器
}

-(void) buildUI{
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, KSCREEN_WIDTH, KSCREEN_HEIGHT-64-49)];
    [self.view addSubview:baseView];
    
    //背景
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:baseView.bounds];
    bgImageView.image = [UIImage imageNamed:@"ic_main_bg"];
    [baseView addSubview:bgImageView];
    
    CGFloat bonudsH=baseView.bounds.size.height;
    //圆环
    CGFloat goalBarX=0;
    CGFloat goalBarW=KSCREEN_WIDTH;
    CGFloat goalBarH=goalBarW;
    CGFloat goalBarY=(bonudsH-goalBarH)/2.0;
    _myGoalBar=[[KDGoalBar alloc] initWithFrame:CGRectMake(goalBarX, goalBarY, goalBarW, goalBarH)];
    _myGoalBar.backgroundColor=[UIColor clearColor];
    [_myGoalBar setAllowDragging:NO];
    [_myGoalBar setAllowSwitching:NO];
    [_myGoalBar setPercent:_currentPercent animated:NO];
    [baseView addSubview:_myGoalBar];
    
    //验证码
    _strCheckCode = [self createAuthCodeForIos:_cust.realSerialNumber];
    CGFloat checkCodeH=40;
    CGFloat checkCodeW=KSCREEN_WIDTH;
    CGFloat checkCodeY=(bonudsH-checkCodeH)/2.0;
    UIFont *sysFont = [UIFont boldSystemFontOfSize:checkCodeH];
    _lblCheckCode=[[BaseView alloc] buildLabel:CGRectMake(0, checkCodeY, checkCodeW, checkCodeH) title:_strCheckCode color:@"#FFFFFF" font:sysFont align:NSTextAlignmentCenter];
    [baseView addSubview:_lblCheckCode];
    
    //当前验证码为
    UILabel *lblCurrentCheckCodeWord=[[BaseView alloc] buildLabel:CGRectMake(0, _lblCheckCode.top-14-30*SCALAE, KSCREEN_WIDTH, 14) title:@"当前验证码为" color:@"00B473" font:[UIFont boldSystemFontOfSize:14] align:NSTextAlignmentCenter];
    [baseView addSubview:lblCurrentCheckCodeWord];
    
    //语音播报
    UIImage *imgSoundNormal=[UIImage imageNamed:@"sound"];
    UIImage *imgSoundHover=[UIImage imageNamed:@"sound-hover"];
    CGFloat btnW=imgSoundNormal.size.width;
    CGFloat btnH=imgSoundNormal.size.height;
    CGFloat btnX=(KSCREEN_WIDTH-btnW)/2.0;
    CGFloat btnY=_lblCheckCode.bottom+30*SCALAE;
    CGRect btnRect=CGRectMake(btnX, btnY, btnW, btnH);
    UIButton *button= [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=btnRect;
    button.layer.cornerRadius = 10*SCALAE;
    button.layer.masksToBounds=YES;
    [button setBackgroundImage:imgSoundNormal forState:UIControlStateNormal];
    [button setBackgroundImage:imgSoundHover forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(brocastCheckCode) forControlEvents:UIControlEventTouchUpInside];
    [baseView addSubview:button];
}

-(void)animation1:(NSTimer *)timer {
    if (_currentPercent >= 100.00) {//30转转一圈后重新调取
        _currentPercent = 0;
        _strCheckCode = [self createAuthCodeForIos:_cust.realSerialNumber];
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
        AVSpeechSynthesisVoice *voice;//获取当前系统语音
        for(int i=0;i<_strCheckCode.length;i++){
            NSRange range1=[_strCheckCode rangeOfComposedCharacterSequenceAtIndex:i];//获取字符串当前位置的字符所在区间
            strCodeSigleNum=[_strCheckCode substringWithRange:range1];//获取当前字符
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
    NSDate *nowDate =[CommonHelper timeWithinEraFromDate:[NSDate date]];//当前北京时间
    NSTimeInterval interval = 0;//系统当前时间与北京时间差
    if(_cust.second!=nil){
        interval = [_cust.second intValue];
    }
    NSDateFormatter *formatter= [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyMMddHHmm-ss"];
    nowDate =[nowDate initWithTimeIntervalSinceNow:+interval];//本地时间加上与服务器标准时间差
    strDate=[formatter stringFromDate:nowDate];
    
    NSArray *dArr=[strDate componentsSeparatedByString:@"-"];
    NSString *dateNums = dArr[0];
    NSString *strSecond= dArr[1];
    if ([strSecond intValue]>=30) {//秒是固定的两个数值
        dateNums=[dateNums stringByAppendingString:@"48"];
    }else{
        dateNums=[dateNums stringByAppendingString:@"16"];
    }
    NSString *str1=[dateNums substringWithRange:NSMakeRange(3, 9)];
    NSString *str2=[dateNums substringWithRange:NSMakeRange(0, 3)];
    NSString *strNewNums=[NSString stringWithFormat:@"%@%@%@",
                          str1,
                          strCode,
                          str2
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
