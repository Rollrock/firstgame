//
//  MyAdmobView.m
//  FirstGame
//
//  Created by zhuang chaoxiao on 14-8-5.
//  Copyright (c) 2014年 zhuang chaoxiao. All rights reserved.
//

#import "MyAdmobView.h"
#import "Header.h"

@implementation MyAdmobView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


-(id)initWithViewController:(UIViewController*)vc
{
    CGRect rect;
    rect = CGRectMake(0-SCREEN_WIDTH, 0-SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    self = [super initWithFrame:rect];
    
    if( self )
    {
        self.backgroundColor = [UIColor whiteColor];
        self.alpha = 0.9;
        
        [vc.view addSubview:self];
        
        [self laytouADVView:vc];
    }
    
    return  self;
}


-(void)laytouADVView:(UIViewController*)vc
{
    GADBannerView *_bannerView;
    
    CGPoint pt = CGPointMake(100,30);
    
    _bannerView = [[GADBannerView alloc]initWithAdSize:kGADAdSizeMediumRectangle origin:pt];
    
    _bannerView.adUnitID = ADMOB_ADV_ID;//调用你的id
    
    _bannerView.rootViewController = vc;
    _bannerView.delegate = self;
    
    [self addSubview:_bannerView];//添加bannerview到你的试图
    
    [_bannerView loadRequest:[GADRequest request]];
    
    {
        //UIButton * btnBack = [[UIButton alloc]initWithFrame:CGRectMake(BACK_POS_X, BACK_POS_Y, BACK_WIDTH, BACK_HEIGHT)];
        UIButton * btnBack = [[UIButton alloc]initWithFrame:CGRectMake(90, 20, BACK_WIDTH, BACK_HEIGHT)];
        [btnBack setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [btnBack addTarget:self action:@selector(btnBack) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnBack];
    }
    
}


-(void)btnBack
{
    NSLog(@"btnBack");
    
    [self removeFromSuperview];
}


/////////////////////////////////////////////////////////////////////////////////////////////

- (void)adViewDidReceiveAd:(GADBannerView *)view
{
    NSLog(@"adViewDidReceiveAd");
    
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
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
