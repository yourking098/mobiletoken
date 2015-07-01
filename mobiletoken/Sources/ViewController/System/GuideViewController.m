//
//  GuideViewController.m
//  mobiletoken
//
//  Created by u1city01 on 15/6/24.
//  Copyright (c) 2015年 mobiletoken. All rights reserved.
//

#import "GuideViewController.h"
#import "ColorHelper.h"
#import "UIEngine.h"
#import "HomeViewController.h"
#import "SerialNumberViewController.h"

@interface GuideViewController ()

@end

@implementation GuideViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    if (IsiOS7Later) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    _bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT)];
    _bgScrollView.delegate = self;
    _bgScrollView.pagingEnabled = YES;
    _bgScrollView.showsHorizontalScrollIndicator = NO;
    _bgScrollView.bounces = NO;
    [self.view addSubview:_bgScrollView];
    
    _numOfImages = 1;
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    
    _bgScrollView.contentSize = CGSizeMake(_bgScrollView.bounds.size.width*_numOfImages, _bgScrollView.bounds.size.height);
    
    for (int i =0; i < _numOfImages; i++) {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(_bgScrollView.bounds.size.width*i, 0, _bgScrollView.bounds.size.width, _bgScrollView.bounds.size.height)];
        [_bgScrollView addSubview:imgView];
        
        switch (i) {
            case 0: {
                //3.5寸屏幕调整
                if (screenSize.height == 480) {
                    imgView.image = [UIImage imageNamed:@"guide480_01"];
                } else {
                    imgView.image = [UIImage imageNamed:@"guide568_01"];
                }
                UIImage *imgStartBtn=[UIImage imageNamed:@"start-btn"];
                UIImage *imgStartHoverBtn=[UIImage imageNamed:@"start-btn-hover"];
                
                CGFloat btnW=160;
                CGFloat btnH=35;
                
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.frame = CGRectMake((KSCREEN_WIDTH-btnW)/2.0, KSCREEN_HEIGHT-90*SCALAE-btnH, btnW, btnH);
                
                [button setBackgroundImage:imgStartBtn forState:UIControlStateNormal];
                [button setBackgroundImage:imgStartHoverBtn forState:UIControlStateHighlighted];
                
                button.titleLabel.font=[UIFont systemFontOfSize:16];
                [button setTitle:@"开始使用" forState:UIControlStateNormal];
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                button.backgroundColor=[UIColor redColor];
                button.layer.cornerRadius=5;
                [button addTarget:self action:@selector(gotoLoginViewController) forControlEvents:UIControlEventTouchUpInside];
                [_bgScrollView addSubview:button];
            }
                break;
            default:
                break;
        }
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //int page = scrollView.contentOffset.x/scrollView.bounds.size.width;
    //_pageContol.currentPage = page;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    CGFloat scrollX = scrollView.contentOffset.x;
    if (_dragBeginOffeset<=scrollX&&_dragBeginOffeset>=KSCREEN_WIDTH*3) {
        //进入登录页面
        [self gotoLoginViewController];
    }
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _dragBeginOffeset = scrollView.contentOffset.x;
}

-(void)gotoLoginViewController {
    NSDictionary *plistDic = [[NSBundle mainBundle] infoDictionary];
    NSString *currntVersion = [plistDic objectForKey:@"CFBundleVersion"];
    [[NSUserDefaults standardUserDefaults] setObject:currntVersion forKey:@"version"];
    CustomerModel *cust = [[UIEngine getinstance] getCustomerModel];
    //进入查看序列号页面
    if (cust.serialNumber==nil) {
        //进入查看序列号页面
        SerialNumberViewController *serialNumberVC = [[SerialNumberViewController alloc] init];
        serialNumberVC.pageType=0;
        [[UIEngine getinstance] pushView:serialNumberVC viewController:self shouldHideTabbar:YES];
    } else {
        //进入首页
        [[UIEngine getinstance] loginInMainView];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
