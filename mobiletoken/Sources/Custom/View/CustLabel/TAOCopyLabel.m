//
//  UICopyLabel.m
//  淘小店
//
//  Created by u1city01 on 14-7-18.
//  Copyright (c) 2014年 yjp. All rights reserved.
//

#import "TAOCopyLabel.h"

@implementation TAOCopyLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(BOOL)canBecomeFirstResponder{
    return YES;
}

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    return (action == @selector(copy));
}

-(void)textCopy{
    UIPasteboard *pastboard = [UIPasteboard generalPasteboard];
    pastboard.string = self.text;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
