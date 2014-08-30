//
//  FirstViewController.m
//  FirstGame
//
//  Created by zhuang chaoxiao on 14-7-15.
//  Copyright (c) 2014年 zhuang chaoxiao. All rights reserved.
//

#import "FirstViewController.h"
#import "Header.h"
#import "MyAdmobView.h"
#import "YouMiConfig.h"
#import "YouMiWall.h"
#import "AppDelegate.h"

#define ROUND_WIDTH  100
#define ROUND_HEIGHT 100
#define ROUND_POS_X  ((SCREEN_WIDTH - ROUND_WIDTH)/2)
#define ROUND_POS_Y  ((SCREEN_HEIGHT - ROUND_HEIGHT)/2)

#define MAX_TIME_DIS  111.0


@interface FirstViewController ()
{
    NSTimeInterval firstTime;
    NSTimeInterval secondTime;
    
    CAShapeLayer * _cirleLayer;
    UIImageView * _bgImgView;
    UIButton * _btn;
    UILabel * _scoreLab;
    
    BOOL _advShowFlag;
}
@end

@implementation FirstViewController

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
    // Do any additional setup after loading the view.
    
    UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    imgView.image = [UIImage imageNamed:@"OtherGameBG"];
    imgView.userInteractionEnabled = YES;
    [self.view addSubview:imgView];
    
    _bgImgView = imgView;
    
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(ROUND_POS_X, ROUND_POS_Y, ROUND_WIDTH, ROUND_HEIGHT)];
    [btn setBackgroundImage:[UIImage imageNamed:@"first_btn_normal"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"first_btn_click"] forState:UIControlStateHighlighted];
    
    [imgView addSubview:btn];
    btn.layer.cornerRadius = ROUND_WIDTH/2;
    [btn addTarget:self action:@selector(clicked) forControlEvents:UIControlEventTouchUpInside];
    
    _btn = btn;
    
    
    ///////
    _scoreLab = [[UILabel alloc]initWithFrame:CGRectMake(200, 50, 80, 30)];
    _scoreLab.text = @"0";
    _scoreLab.textColor = [UIColor orangeColor];
    _scoreLab.font = [UIFont systemFontOfSize:20];
    _scoreLab.textAlignment = NSTextAlignmentCenter;
    
    [imgView addSubview:_scoreLab];

    
    {
        CGRect rect = CGRectMake(100, 250, 280, 25);
        
        UILabel * tipLab = [[UILabel alloc]initWithFrame:rect];
        tipLab.numberOfLines = 0;
        tipLab.textColor = [UIColor blackColor];
        tipLab.font = [UIFont systemFontOfSize:15];
        tipLab.textAlignment = NSTextAlignmentCenter;
        //tipLab.text = @"连续快速点击两次时间小于100通关";
        tipLab.text = @"two tips less than 100 secs is success";
        //[imgView addSubview:tipLab];
    }
    
    //
    {
        UIButton * btnBack = [[UIButton alloc]initWithFrame:CGRectMake(BACK_POS_X, BACK_POS_Y, BACK_WIDTH, BACK_HEIGHT)];
        [btnBack setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [btnBack addTarget:self action:@selector(btnBack) forControlEvents:UIControlEventTouchUpInside];
        [imgView addSubview:btnBack];
    }
}


-(void)showYouMiAdv
{
    [YouMiWall showOffers:YES didShowBlock:^{
        NSLog(@"有米积分墙已显示");
    } didDismissBlock:^{
        NSLog(@"有米积分墙已退出");
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }];

}


-(void)btnBack
{
    //广告显示

    AppDelegate *appDel = [[UIApplication sharedApplication] delegate];
    if( ![appDel canShowAdv] )
    {
        [self dismissViewControllerAnimated:YES completion:nil];
        
        return;
    }
    

    srand(time(0));
    
    if( rand() % 2 == 0 )
    {
        if( !_advShowFlag )
        {
            [[MyAdmobView alloc]initWithViewController:self];
        }
        else
        {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        
        _advShowFlag = YES;
    }
    else
    {
        if( !_advShowFlag )
        {
            //显示有米广告
           
            [self showYouMiAdv];
            
        }
        else
        {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        
        _advShowFlag = YES;
    }

}



-(NSTimeInterval)getCurrentTime
{
    NSDate *date=[NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval time=[date timeIntervalSince1970]*1000;
    
    //NSString *strTime=[NSString stringWithFormat:@"%.0f",time];
    //NSLog(@"%@",strTime);
    
    return time;
}


-(void)clicked
{
    NSLog(@"clicked");
    
    if( firstTime == 0 )
    {
        firstTime = [self getCurrentTime];
    }
    else if( secondTime == 0 )
    {
        secondTime = [self getCurrentTime];
    }
    
    if( firstTime != 0 && secondTime != 0 )
    {
        NSLog(@"time Interval:%f",secondTime - firstTime - MAX_TIME_DIS);
        
        _scoreLab.text = [NSString stringWithFormat:@"%d",(NSInteger)(secondTime - firstTime)];
        
        if( secondTime - firstTime - MAX_TIME_DIS < 0.0)
        {
            NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
            [userDefault setBool:YES forKey:PASS_2_ID];

            [self dismissViewControllerAnimated:YES completion:nil];
        }
        
        secondTime = 0;
        firstTime = 0;

    }
    
    
    UIBezierPath * path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(0, 0) radius:ROUND_WIDTH/2 -3 startAngle:0 endAngle:2*M_PI clockwise:YES];
    
    CAShapeLayer * layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    layer.fillColor = [[UIColor clearColor]CGColor];
    layer.strokeColor = [[UIColor orangeColor] CGColor];
    layer.lineCap = kCALineCapRound;
    layer.position = CGPointMake(ROUND_POS_X+ROUND_WIDTH/2, ROUND_POS_Y+ROUND_HEIGHT/2);
    layer.lineWidth = 1.5f;
    
    [_bgImgView.layer insertSublayer:layer below:_btn.layer];
    
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(5, 5, 1)];
    
    CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alphaAnimation.fromValue = @1;
    alphaAnimation.toValue = @0;
    
    CAAnimationGroup * group = [CAAnimationGroup animation];
    group.animations = @[scaleAnimation, alphaAnimation];
    group.duration = 1.5;
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    group.delegate = self;
    
    [layer addAnimation:group forKey:@""];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

