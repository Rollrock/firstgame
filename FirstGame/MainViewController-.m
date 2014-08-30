//
//  MainViewController.m
//  GameDemo
//
//  Created by zhuang chaoxiao on 14-7-7.
//  Copyright (c) 2014年 zhuang chaoxiao. All rights reserved.
//

#import "MainViewController.h"
#import "CAMyLayer.h"


#define degreesToRadians(x) (M_PI*(x)/180.0)
#define  UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue &0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.height)

#define ROUND_WIDTH  100
#define ROUND_HEIGHT 100
#define ROUND_POS_X  ((SCREEN_WIDTH - ROUND_WIDTH)/2)
#define ROUND_POS_Y  ((SCREEN_HEIGHT - ROUND_HEIGHT)/2)


@interface MainViewController ()
{
    NSTimeInterval firstTime;
    NSTimeInterval secondTime;
    
}
@end

@implementation MainViewController

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
    imgView.image = [UIImage imageNamed:@"GameBg2"];
    imgView.userInteractionEnabled = YES;
    [self.view addSubview:imgView];
    
    
    
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(ROUND_POS_X, ROUND_POS_Y, ROUND_WIDTH, ROUND_HEIGHT)];
    btn.backgroundColor = [UIColor grayColor];
    [imgView addSubview:btn];
    btn.layer.cornerRadius = ROUND_WIDTH/2;
    [btn addTarget:self action:@selector(clicked) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIBezierPath * path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(0, 0) radius:ROUND_WIDTH/2 startAngle:0 endAngle:2*M_PI clockwise:YES];
    
    CAShapeLayer * layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    layer.fillColor = [[UIColor clearColor]CGColor];
    layer.strokeColor = [[UIColor orangeColor] CGColor];
    layer.lineCap = kCALineCapRound;
    layer.position = CGPointMake(ROUND_POS_X+ROUND_WIDTH/2, ROUND_POS_Y+ROUND_HEIGHT/2);
    layer.lineWidth = 2.0f;
   
    [imgView.layer addSublayer:layer];
    
    ///////
    UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    
    
    
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
        NSLog(@"time Interval:%f",secondTime - firstTime );
        
        secondTime = 0;
        firstTime = 0;
    }
    
    UIBezierPath * path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(0, 0) radius:ROUND_WIDTH/2 startAngle:0 endAngle:2*M_PI clockwise:YES];
    
    CAShapeLayer * layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    layer.fillColor = [[UIColor clearColor]CGColor];
    layer.strokeColor = [[UIColor orangeColor] CGColor];
    layer.lineCap = kCALineCapRound;
    layer.position = CGPointMake(ROUND_POS_X+ROUND_WIDTH/2, ROUND_POS_Y+ROUND_HEIGHT/2);
    layer.lineWidth = 1.5f;
    
    [self.view.layer addSublayer:layer];
    
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(4, 4, 1)];
    
    CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alphaAnimation.fromValue = @1;
    alphaAnimation.toValue = @0;
   
    CAAnimationGroup * group = [CAAnimationGroup animation];
    group.animations = @[scaleAnimation, alphaAnimation];
    group.duration = 1.5;
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
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
