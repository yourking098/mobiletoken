//
//  GuideViewController.h
//  mobiletoken
//
//  Created by u1city01 on 15/6/24.
//  Copyright (c) 2015年 mobiletoken. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuideViewController : UIViewController<UIScrollViewDelegate>
{
    UIScrollView *_bgScrollView;
    UIPageControl *_pageContol;
    int _numOfImages;
    float _dragBeginOffeset;
}
@end
