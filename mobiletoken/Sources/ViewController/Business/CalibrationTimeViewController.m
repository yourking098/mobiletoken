//
//  CalibrationTimeViewController.m
//  mobiletoken
//
//  Created by u1city01 on 15/6/27.
//  Copyright (c) 2015年 mobiletoken. All rights reserved.
//

#import "CalibrationTimeViewController.h"

@interface CalibrationTimeViewController ()
{
    UILabel *dateLabel;
    UILabel *timeLabel;
    NSTimer *_timer;
}
@end

@implementation CalibrationTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initNavItem:@"校准时间"];
    [self buildUI];
    _cust = [[UIEngine getinstance]getCustomerModel];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerFunc) userInfo:nil repeats:YES];
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
    UILabel *topLabelView=[[UILabel alloc] initWithFrame:CGRectMake(30*SCALAE, 80*SCALAE, baseView.frame.size.width-60*SCALAE, 80*SCALAE)];
    topLabelView.text=@"手机令牌时间与北京时时区的误差超过一分钟时无法使用";
    topLabelView.textColor=[ColorHelper colorWithHexString:@"#ffffff"];
    topLabelView.backgroundColor=[UIColor clearColor];
    topLabelView.textAlignment=NSTextAlignmentLeft;
    topLabelView.font=[UIFont systemFontOfSize:28*SCALAE];
    topLabelView.numberOfLines=0;
    [baseView addSubview:topLabelView];
    
    //按钮区域
    UIView *topButtonView = [[UIView alloc] initWithFrame:CGRectMake(30*SCALAE, CGRectGetMaxY(topLabelView.frame)+20*SCALAE, baseView.frame.size.width-60*SCALAE, 240*SCALAE)];
    topButtonView.layer.masksToBounds=YES;
    topButtonView.layer.borderWidth=2;
    topButtonView.layer.borderColor=[UIColor blackColor].CGColor;
    topButtonView.layer.cornerRadius=15*SCALAE;
    [baseView addSubview:topButtonView];
    
    //创建日期格式化对象
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日 HH:mm:ss"];
    
    NSString *strNowDate = [dateFormatter stringFromDate:[NSDate date]];
    
    NSArray *datelist=[strNowDate componentsSeparatedByString:@" "];
    
    //按钮
    for (int i=0;i<2;i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, i*120*SCALAE, topButtonView.frame.size.width, 120*SCALAE);
        button.backgroundColor=[ColorHelper colorWithHexString:@"#1c6743"];
        [button addTarget:self action:@selector(onClickbutton:) forControlEvents:UIControlEventTouchUpInside];
        button.tag=i;
        [topButtonView addSubview:button];
        
        UILabel *labelView=[[UILabel alloc] initWithFrame:CGRectMake(30*SCALAE, i*120*SCALAE+20*SCALAE, topButtonView.frame.size.width-60*SCALAE, 80*SCALAE)];
        labelView.text=datelist[i];
        labelView.textColor=[ColorHelper colorWithHexString:@"#ffffff"];
        labelView.backgroundColor=[UIColor clearColor];
        labelView.textAlignment=NSTextAlignmentLeft;
        labelView.font=[UIFont systemFontOfSize:32*SCALAE];
        [topButtonView addSubview:labelView];
        if (i==0) {
            dateLabel = labelView;
        }
        else {
            timeLabel = labelView;
        }
        
        UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(topButtonView.frame.size.width-60*SCALAE, i*120*SCALAE+((120*SCALAE-30*SCALAE*28/19)/2), 30*SCALAE, 30*SCALAE*28/19)];
        arrowImageView.image = [UIImage imageNamed:@"ic_arrow_off"];
        [topButtonView addSubview:arrowImageView];
        
        if (i==0) {
            UIView *lineTopView = [[UIView alloc] initWithFrame:CGRectMake(0, (i+1)*120*SCALAE-0.5, topButtonView.frame.size.width, 0.5f)];
            lineTopView.backgroundColor=[ColorHelper colorWithHexString:@"#0f5d31"];
            [topButtonView addSubview:lineTopView];
            UIView *lineBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, (i+1)*120*SCALAE, topButtonView.frame.size.width, 0.5f)];
            lineBottomView.backgroundColor=[ColorHelper colorWithHexString:@"#349c6c"];
            [topButtonView addSubview:lineBottomView];

        }
    }
    
    //按钮区域
    UIView *bottomButtonView = [[UIView alloc] initWithFrame:CGRectMake(30*SCALAE, CGRectGetMaxY(topButtonView.frame)+30*SCALAE, baseView.frame.size.width-60*SCALAE, 240*SCALAE)];
    bottomButtonView.layer.masksToBounds=YES;
    bottomButtonView.layer.borderWidth=2;
    bottomButtonView.layer.borderColor=[UIColor blackColor].CGColor;
    bottomButtonView.layer.cornerRadius=15*SCALAE;
    [baseView addSubview:bottomButtonView];
    
    NSArray *typelist = [NSArray arrayWithObjects:@"自动校准时间",@"手动校准时间", nil];
    
    //按钮
    for (int i=0;i<2;i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, i*120*SCALAE, topButtonView.frame.size.width, 120*SCALAE);
        button.backgroundColor=[ColorHelper colorWithHexString:@"#1c6743"];
        [button addTarget:self action:@selector(onClickbutton:) forControlEvents:UIControlEventTouchUpInside];
        button.tag=i+2;
        [bottomButtonView addSubview:button];
        
        UILabel *labelView=[[UILabel alloc] initWithFrame:CGRectMake(30*SCALAE, i*120*SCALAE+20*SCALAE, topButtonView.frame.size.width-60*SCALAE, 80*SCALAE)];
        labelView.text=typelist[i];
        labelView.textColor=[ColorHelper colorWithHexString:@"#ffffff"];
        labelView.backgroundColor=[UIColor clearColor];
        labelView.textAlignment=NSTextAlignmentLeft;
        labelView.font=[UIFont systemFontOfSize:32*SCALAE];
        [bottomButtonView addSubview:labelView];
        
        UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(bottomButtonView.frame.size.width-60*SCALAE, i*120*SCALAE+((120*SCALAE-30*SCALAE*28/19)/2), 30*SCALAE, 30*SCALAE*28/19)];
        arrowImageView.image = [UIImage imageNamed:@"ic_arrow_off"];
        [bottomButtonView addSubview:arrowImageView];
        
        if (i==0) {
            UIView *lineTopView = [[UIView alloc] initWithFrame:CGRectMake(0, (i+1)*120*SCALAE-0.5, bottomButtonView.frame.size.width, 0.5f)];
            lineTopView.backgroundColor=[ColorHelper colorWithHexString:@"#0f5d31"];
            [bottomButtonView addSubview:lineTopView];
            UIView *lineBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, (i+1)*120*SCALAE, bottomButtonView.frame.size.width, 0.5f)];
            lineBottomView.backgroundColor=[ColorHelper colorWithHexString:@"#349c6c"];
            [bottomButtonView addSubview:lineBottomView];
            
        }
    }
}

//每一秒都被调用一次
- (void)timerFunc {
    NSTimeInterval interval = 0;
    if (_cust.second != nil) {
        interval = [_cust.second intValue];
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss"];
    NSDate *now = [NSDate date];
    NSDate *dateNow =[now initWithTimeIntervalSinceNow:+interval];
    NSString *timestamp = [formatter stringFromDate:dateNow];
    [timeLabel setText:timestamp];//时间在变化的语句
}

//按钮点击事件
- (void)onClickbutton:(UIButton*)sender {
    switch ((int)sender.tag) {
        case 0:
        {
            //设置日期
            _datePicker = [[HZDatePickerView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH,200)];
            _customView = [[CustomPopView alloc]initWithTitle:@"" delegate:self customView:_datePicker];
            [_customView showInView:self.view];
        }
            break;
        case 1:
        {
            //设置时间
            _timePicker = [[HZTimePickerView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH,200)];
            _customView = [[CustomPopView alloc]initWithTitle:@"" delegate:self customView:_timePicker];
            [_customView showInView:self.view];
        }
            break;
        case 2:
        {
            //自动校准时间
            [self showloading:@"校准进行中..."];
            NSURL *url=[NSURL URLWithString:@"http://www.baidu.com"];
            NSURLRequest *request=[NSURLRequest requestWithURL:url];
            NSURLConnection *connection=[[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:YES];
            [connection start];
        }
            break;
        case 3:
        {
            //手动校准时间
            _timePicker = [[HZTimePickerView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH,200)];
            _customView = [[CustomPopView alloc]initWithTitle:@"" delegate:self customView:_timePicker];
            [_customView showInView:self.view];
            
        }
            break;
    }
}

#pragma mark - NSURLConnectionDelegate

//自动校准时间
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSHTTPURLResponse *httpResponse=(NSHTTPURLResponse *)response;
    if ([response respondsToSelector:@selector(allHeaderFields)]) {
        NSDictionary *dict=[httpResponse allHeaderFields];
        NSString *time=[dict objectForKey:@"Date"];
        NSString *time1=[time substringFromIndex:16];
        NSString *time2=[time1 substringToIndex:9];
        NSArray*array=[time2 componentsSeparatedByString:@":"];
        int hour=[[array objectAtIndex:0] intValue];
        int minute=[[array objectAtIndex:1] intValue];
        int second=[[array objectAtIndex:2] intValue];
        //远程时间
        NSString *remoteDateString=[NSString stringWithFormat:@"%0.2d:%0.2d:%0.2d",hour+8,minute,second];
        //NSLog(@"date:%@",remoteDateString);
        timeLabel.text=remoteDateString;
        
        //获取GMT时间
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
        dateFormatter.dateFormat  = @"EEE, dd MM yyyy HH:mm:ss Z";
        NSDate *remoteDate = [self timeWithinEraFromDate:[dateFormatter dateFromString:time]];
        
        //本地时间
        NSDate *localDate = [self timeWithinEraFromDate:[NSDate date]];
        
        //时间校准
        [self setTimeCalibration:localDate toDate:remoteDate];
    }
    [self hideWaiting];
}

/**
 *  时间校准
 *
 *  @param fromDate 前一个时间
 *  @param toDate   后一个时间
 *
 *  @return 是否成功
 */
- (BOOL)setTimeCalibration:(NSDate*)fromDate toDate:(NSDate*)toDate {
    if (_cust != nil) {
        NSCalendar *gregorian=[NSCalendar currentCalendar];
        NSDateComponents *comps=[gregorian components:NSCalendarUnitSecond fromDate:fromDate toDate:toDate options:0];
        _cust.second = [NSString stringWithFormat:@"%d",(int)[comps second]];
        return [[UIEngine getinstance] setCustomerModel:_cust];
    }
    else {
        return NO;
    }
}

/**
 *  时间转换
 *
 *  @param inputDate 输入时间
 *
 *  @return 返回时间
 */
- (NSDate*)timeWithinEraFromDate:(NSDate*)inputDate {
    
    //设置源日期时区
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];//或GMT
    //设置转换后的目标日期时区
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:inputDate];
    //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:inputDate];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    //转为现在时间
    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:inputDate];
    
    return destinationDateNow;
}


#pragma mark - CustomPopDelegate

- (void)didClickOnConfirmButton {
    //设置日期
    if (_datePicker != nil) {
        if ([_datePicker.datePiker date]!=nil) {
            NSDate *selected = [_datePicker.datePiker date];
            // 创建一个日期格式器
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            // 为日期格式器设置格式字符串
            [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
            NSString *destDateString = [dateFormatter stringFromDate:selected];//装换成字符串
            //传递参数到textfiled
            dateLabel.text=destDateString;
        }
    }
    //设置时间
    if (_timePicker != nil) {
        if ([_timePicker.datePiker date]!=nil) {
            NSDate *selected = [_timePicker.datePiker date];
            
            // 创建一个日期格式器
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            // 为日期格式器设置格式字符串
            [dateFormatter setDateFormat:@"HH:mm:ss"];
            NSString *destDateString = [dateFormatter stringFromDate:selected];//装换成字符串
            //传递参数到textfiled
            timeLabel.text=destDateString;
        }
    }
    
    NSString *strDate = [NSString stringWithFormat:@"%@ %@",dateLabel.text,timeLabel.text];
    // 创建一个日期格式器
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // 为日期格式器设置格式字符串
    [dateFormatter setDateFormat:@"yyyy年MM月dd日 HH:mm:ss"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [dateFormatter setTimeZone:timeZone];
    //选择时间
    NSDate *selectedDate = [self timeWithinEraFromDate:[dateFormatter dateFromString:strDate]];
    
    //本地时间
    NSDate *localDate = [self timeWithinEraFromDate:[NSDate date]];
    
    //时间校准
    [self setTimeCalibration:localDate toDate:selectedDate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
