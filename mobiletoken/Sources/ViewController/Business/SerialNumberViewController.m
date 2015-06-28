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
    NSString *strSerailNumber=[NSString stringWithFormat:@"%@",[self createAppSerialNums]];
    
    CGRect rectSerial=CGRectMake(0, 150, KSCREEN_WIDTH, 20);
    UIFont *sysFont = [UIFont systemFontOfSize:16];
    _lblSerialNum=[[BaseView alloc] buildLabel:rectSerial title:strSerailNumber color:@"#999999" font:sysFont align:NSTextAlignmentCenter];
    [self.view addSubview:_lblSerialNum];
    
    CGFloat btnW=150;
    CGFloat btnH=50;
    CGFloat btnX=(KSCREEN_WIDTH-btnW)/2.0;
    CGFloat btnY=_lblSerialNum.bottom+50;
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



/*!
 * @method 根据手机唯一码产生app序列号
 * @result 生成一个纯32位数字序列号
 */
-(NSString *) createAppSerialNums{
    NSString *strResult=@"";
    //根据手机唯一码产生app序列号
    NSString *uId = [[UIDevice currentDevice].identifierForVendor UUIDString];
    NSString *strNewNums=[uId stringByReplacingOccurrencesOfString:@"-" withString:@""];//32位
    strNewNums = [self stringToSingleNum:strNewNums];//转成纯数字
    strNewNums=[self shortString:strNewNums andLength:12];
    
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
                 [strDate substringWithRange:NSMakeRange(7, 1)]
                 ];
    }
    strResult=[NSString stringWithFormat:@"%@%@",strNewNums,strDate];
    if (strResult.length==16) {
        strResult=[NSString stringWithFormat:@"%@-%@-%@-%@",
                   [strResult substringWithRange:NSMakeRange(0, 4)],
                   [strResult substringWithRange:NSMakeRange(4, 4)],
                   [strResult substringWithRange:NSMakeRange(8, 4)],
                   [strResult substringWithRange:NSMakeRange(12, 4)]
                   ];
    }
    return strResult;
}

/*!
 * @method 字符串转成32位数字序列号。数字字母ASCII是两位，这边只取个位。
 * @param  singleUidCode 手机唯一码产生
 * @result 生成一个纯32位数字序列号
 */
-(NSString *) stringToSingleNum:(NSString *)singleUidCode{
    NSData *singleUidCodeData = [singleUidCode dataUsingEncoding:NSUTF8StringEncoding];
    Byte *singleUidCodeByte = (Byte *)singleUidCodeData.bytes;
    NSUInteger dataLen = singleUidCodeData.length;
    
    NSString *strResult=@"";
    for (int i=0; i<dataLen; i++) {
        int asciiCode = (int)(singleUidCodeByte[i]);
        NSString *strCode=[NSString stringWithFormat:@"%d",asciiCode];
        NSString *strLastCode=[strCode substringFromIndex:strCode.length-1];
        strResult =[strResult stringByAppendingFormat:@"%@",strLastCode];
    }
    return strResult;
}

/*!
 * @method 获取长字符串固定长度的短字符串。
 * @param  serialCode 一个纯32位数字序列号
 * @result 生成一个纯32位数字序列号
 */
-(NSString *) shortString:(NSString *)serialCode andLength:(NSUInteger)len{
    NSString *strResult=@"";
    NSUInteger length = serialCode.length;
    if (length <= len)
        return serialCode;
    
    NSUInteger pLen = length / len;//要把str分成6段(参数len=6)，pLen是每段的长度
    NSUInteger pIndex = length % len;//pIndex一定不会超过pLen
    if (pIndex == 0)
        pIndex = pLen;//如果刚好整除，则标识成最后一个位置
    for (int i = 0; i < len; i++) {
        NSRange range=NSMakeRange(i * pLen, pLen);
        NSString *pStr= [serialCode substringWithRange:range];////取出每一段字符串
        
        pStr=[pStr substringFromIndex:pStr.length-1];//每段里第pIndex将被使用
        strResult=[strResult stringByAppendingFormat:@"%@",pStr];
    }
    return strResult;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
