//
//  UICustomLineLabel.h
//  MINI店
//
//  Created by u1city01 on 14-6-14.
//  Copyright (c) 2014年 yjp. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    
    LineTypeNone,//没有画线
    LineTypeUp ,// 上边画线
    LineTypeMiddle,//中间画线
    LineTypeDown,//下边画线
    
} LineType ;

@interface TAOCustomLineLabel : UILabel

@property (assign, nonatomic) LineType lineType;
@property (assign, nonatomic) UIColor * lineColor;


@end
