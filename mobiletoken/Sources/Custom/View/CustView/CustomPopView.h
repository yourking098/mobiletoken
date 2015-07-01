//
//  CustomPopView.h
//  淘小店
//
//  Created by u1city01 on 14-9-29.
//  Copyright (c) 2014年 u1city01. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CustomPopDelegate <NSObject>
@optional
- (void)didClickOnConfirmButton;
@end

@interface CustomPopView : UIView
- (id)initWithTitle:(NSString *)title delegate:(id<CustomPopDelegate>)delegate customView:(UIView *)customView;
- (void)showInView:(UIView *)view;
@end
