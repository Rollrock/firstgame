//
//  RGBViewController.m
//  FirstGame
//
//  Created by zhuang chaoxiao on 14-7-29.
//  Copyright (c) 2014年 zhuang chaoxiao. All rights reserved.
//

#import "RGBViewController.h"
#import "Header.h"
#import <AVFoundation/AVFoundation.h>
#import "GADBannerView.h"
#import "GADAdSize.h"
#import "MyAdmobView.h"
#import "AppDelegate.h"
#import "YouMiConfig.h"
#import "YouMiWall.h"



#define ROUND_WIDTH   60

#define CENTER_ROUND_CENTER_X  240
#define CENTER_ROUND_CENTER_Y  160

#define CIRCLE_RADIUS   110


#define ROUND_COUNT  6

#define RAND_INTERVAL  1.5



@interface RGBViewController ()
{
    UIButton * _left_up_btn;
    UIButton * _left_down_btn;
    UIButton * _right_up_btn;
    UIButton * _right_down_btn;
    UIButton * _up_btn;
    UIButton * _down_btn;
    
    UIButton * _center_view;
    
    UILabel * _textLabel;
    UILabel * _scoreLabel;
    
    UIImageView * _bgImgView;
    
    NSArray * _colorArray;
    NSMutableArray * _roundArray;
    
    
    NSInteger _randArray[ROUND_COUNT];
    
    NSInteger _targetIndex;
    
    NSInteger _totalSuccess;
    
    UIView * _restView;
    
    
    AVAudioPlayer * _clickPlayer;
    AVAudioPlayer * _successPlayer;
    
    BOOL _soundPlay;
    
    
    BOOL _viewDisp;
    
    
    BOOL _advShowFlag;
    
    
}
@end

@implementation RGBViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        _colorArray = [[NSArray alloc]initWithObjects:[UIColor redColor],[UIColor orangeColor],[UIColor purpleColor],[UIColor brownColor],[UIColor blueColor],[UIColor blackColor], nil];
        
    }
    return self;
}


-(void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _bgImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _bgImgView.image = [UIImage imageNamed:@"OtherGameBG"];
    _bgImgView.userInteractionEnabled = YES;
    [self.view addSubview:_bgImgView];
    
    [self initView];
    
    [self startGame];
    
    UITapGestureRecognizer * g = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewClicked:)];
    [_bgImgView addGestureRecognizer:g];
    
    //
    
    [self initSound];
    
}



-(void)initSound
{
    
    AppDelegate *appDel = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    if([appDel readSoundSetting])
    {
        _soundPlay = NO;
        return;
    }
    else
    {
        _soundPlay = YES;
    }
    
    {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"click" ofType:@"wav"];
        NSURL *url = [NSURL fileURLWithPath:path];//本地路径应该这样写
        
        _clickPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        [_clickPlayer prepareToPlay];
    }
    
    {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"success2" ofType:@"wav"];
        NSURL *url = [NSURL fileURLWithPath:path];//本地路径应该这样写
        
        _successPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        [_successPlayer prepareToPlay];
    }
}


-(void)viewClicked:(UITapGestureRecognizer*)gesture
{
    CGPoint touchPoint = [gesture locationInView:_bgImgView];
    
    NSLog(@"pt:%f %f",touchPoint.x,touchPoint.y);
    
    for( int index = 0; index < [_roundArray count]; ++ index )
    {
        if ([ ((UIButton*)[_roundArray objectAtIndex:index]).layer.presentationLayer hitTest:touchPoint])
        {
            //NSLog(@"viewClicked:%d",index);
            
            if( index == _targetIndex )
            {
                NSLog(@"successed");
                
                [self increaseSuccess];
                
                [self layoutSuccessView];
                
                [self clickSuccessSpEff:0 withPoint:touchPoint];
                
                [self palySoundSuccess:YES];
            }
            else
            {
                NSLog(@"gameOver");
                
                [self resetSuccess];
                
                [self layoutSuccessView];
                
                [self palySoundSuccess:NO];
            }
            
        }
    }

}

- (void)palySoundSuccess:(BOOL)success
{
    if( !_soundPlay )
    {
        return;
    }
    
    if( success )
    {
        [_successPlayer play];
    }
    else
    {
       [_clickPlayer play];
    }
}


-(void)clickSuccessSpEff:(int)index withPoint:(CGPoint)pt
{
    UIBezierPath * path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(0, 0) radius:ROUND_WIDTH/2 startAngle:0 endAngle:2*M_PI clockwise:YES];
    
    CAShapeLayer * layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    layer.fillColor = [[UIColor clearColor]CGColor];
    layer.strokeColor = [[UIColor orangeColor] CGColor];
    layer.lineCap = kCALineCapRound;
    layer.position = pt;
    layer.lineWidth = 1.5f;
    
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(5, 5, 1)];
    scaleAnimation.removedOnCompletion = NO;
    scaleAnimation.fillMode = kCAFillModeForwards;
    
    CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alphaAnimation.fromValue = @1;
    alphaAnimation.toValue = @0;
    alphaAnimation.removedOnCompletion = NO;
    alphaAnimation.fillMode = kCAFillModeForwards;
    
    CAAnimationGroup * group = [CAAnimationGroup animation];
    group.animations = @[scaleAnimation, alphaAnimation];
    group.duration = 1.5;
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    group.delegate = self;
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    
    [_bgImgView.layer addSublayer:layer];
    
    [layer addAnimation:group forKey:@""];
    layer = nil;

}


-(void)viewDidAppear:(BOOL)animated
{
    [self startAnim];
}

-(void)resetRandArray
{
    for(int a = 0; a < ROUND_COUNT; ++ a )
    {
        _randArray[a] = 0;
    }
}

-(void)increaseSuccess
{
    _totalSuccess ++;
}

-(void)resetSuccess
{
    _totalSuccess = 0;
}


-(void)initView
{
    CGRect rect;
    
    _roundArray = [[NSMutableArray alloc]initWithCapacity:ROUND_COUNT];
    
    for( NSInteger index = 0; index <= ROUND_COUNT-1; ++ index )
    {
        double ang = 30+index * 60;
        
        double y = CENTER_ROUND_CENTER_Y - sin((ang/180.0)*M_PI)*CIRCLE_RADIUS;
        double x = cos((ang/180.0)*M_PI)*CIRCLE_RADIUS+CENTER_ROUND_CENTER_X;
        
        rect = CGRectMake(x-ROUND_WIDTH/2, y-ROUND_WIDTH/2, ROUND_WIDTH, ROUND_WIDTH);
        UIButton * btn = [[UIButton alloc]initWithFrame:rect];
        btn.layer.cornerRadius = ROUND_WIDTH/2;
        btn.userInteractionEnabled = NO;
        
        btn.backgroundColor = [UIColor redColor];
        
        [_bgImgView addSubview:btn];
        
        btn.tag = index;
        
        [_roundArray addObject:btn];
    }
    
    
    //////
    rect = CGRectMake(CENTER_ROUND_CENTER_X-ROUND_WIDTH/2, CENTER_ROUND_CENTER_Y-ROUND_WIDTH/2, ROUND_WIDTH, ROUND_WIDTH);
    _center_view = [[UIButton alloc]initWithFrame:rect];
    _center_view.layer.cornerRadius = ROUND_WIDTH/2;
    _center_view.backgroundColor = [UIColor grayColor];
    [_bgImgView addSubview:_center_view];

    
    //
    rect = CGRectMake(0, 0, ROUND_WIDTH,30);
    _textLabel = [[UILabel alloc]initWithFrame:rect];
    _textLabel.textColor = [UIColor redColor];
    _textLabel.font = [UIFont systemFontOfSize:20];
    _textLabel.center = CGPointMake(ROUND_WIDTH/2 , ROUND_WIDTH/2);
    _textLabel.text = @"string";
    _textLabel.textAlignment = NSTextAlignmentCenter;
    [_center_view addSubview:_textLabel];
    
    
    //
    rect = CGRectMake(0, 0, 0, 0);
    _scoreLabel = [[UILabel alloc]initWithFrame:rect];
    _scoreLabel.textColor = [UIColor blackColor];
    _scoreLabel.text = @"00000";
    _scoreLabel.font = [UIFont systemFontOfSize:15];
    [_bgImgView addSubview:_scoreLabel];
    
    
    //
    {
        UIButton * btnBack = [[UIButton alloc]initWithFrame:CGRectMake(BACK_POS_X, BACK_POS_Y, BACK_WIDTH, BACK_HEIGHT)];
        [btnBack setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [btnBack addTarget:self action:@selector(btnBack) forControlEvents:UIControlEventTouchUpInside];
        [_bgImgView addSubview:btnBack];
    }
    
}


-(void)layoutSuccessView
{
    //1  灰色
    //2  蓝色
    //3  黑色
    
    #define MARGIN  10
    #define RET_VIEW_WIDTH 100
    #define RET_VIEW_HEIGHT  (SCREEN_HEIGHT-MARGIN*2)
    
    #define SMALL_ROUNT_WIDTH 20
    
    
    CGRect rect;
    int tempSuccess = _totalSuccess;
    
    NSLog(@"success:%d",_totalSuccess);
    
    if( !_restView )
    {
        rect = CGRectMake(SCREEN_WIDTH - RET_VIEW_WIDTH ,MARGIN, RET_VIEW_WIDTH, RET_VIEW_HEIGHT);
        _restView = [[UIView alloc]initWithFrame:rect];
        _restView.backgroundColor = [UIColor clearColor];
        //_restView.alpha = 0.3;
        [_bgImgView addSubview:_restView];
    }
    
    for( UIView * subView in _restView.subviews )
    {
        [subView removeFromSuperview];
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////
    
    int i = 0;
    int index = 0;
 
    
    if( tempSuccess / 100 > 0 )
    {
        int black = tempSuccess / 100;
        index = black;
        
        for( i = 0; i < black; ++ i )
        {
            rect = CGRectMake(RET_VIEW_WIDTH - MARGIN/2-SMALL_ROUNT_WIDTH, MARGIN/2 + (SMALL_ROUNT_WIDTH +MARGIN) * i , SMALL_ROUNT_WIDTH, SMALL_ROUNT_WIDTH);
            
            UIView * view = [[UIView alloc]initWithFrame:rect];
            view.backgroundColor = [UIColor blackColor];
            view.layer.cornerRadius = SMALL_ROUNT_WIDTH/2;
            [_restView addSubview:view];
        }
        
        tempSuccess = tempSuccess%100;
    }
    
    
    if( tempSuccess / 10 > 0 )
    {
        int blue = tempSuccess / 10;
        
        for( i = 0; i < blue; ++ i )
        {
            //这里的10表示一列只能放10个圈
            rect = CGRectMake(RET_VIEW_WIDTH - MARGIN/2-SMALL_ROUNT_WIDTH-((i+index)>=10? (SMALL_ROUNT_WIDTH+MARGIN/2):(0)), MARGIN/2 + (SMALL_ROUNT_WIDTH +MARGIN) * ((i+index)%10) , SMALL_ROUNT_WIDTH, SMALL_ROUNT_WIDTH);
            
            UIView * view = [[UIView alloc]initWithFrame:rect];
            view.backgroundColor = [UIColor blueColor];
            view.layer.cornerRadius = SMALL_ROUNT_WIDTH/2;
            [_restView addSubview:view];
        }
        
        index += blue;
        tempSuccess = tempSuccess%10;
    }
    
    
    if( tempSuccess > 0 )
    {
        int gray = tempSuccess;
        
        for( i = 0; i < gray; ++ i )
        {
            rect = CGRectMake(RET_VIEW_WIDTH - MARGIN/2-SMALL_ROUNT_WIDTH-((i+index)/10*(SMALL_ROUNT_WIDTH+MARGIN/2)), MARGIN/2 + (SMALL_ROUNT_WIDTH +MARGIN) * ((i+index)%10) , SMALL_ROUNT_WIDTH, SMALL_ROUNT_WIDTH);
            
            UIView * view = [[UIView alloc]initWithFrame:rect];
            view.backgroundColor = [UIColor grayColor];
            view.layer.cornerRadius = SMALL_ROUNT_WIDTH/2;
            [_restView addSubview:view];
        }
        
        index += gray;
    }
}


-(void)startAnim
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^(void){
       
        dispatch_async(dispatch_get_main_queue(), ^(void){
            
            for( NSInteger index = 0; index <= ROUND_COUNT-1; ++ index )
            {
                double ang = 30+index * 60;
                
                UIBezierPath * path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CENTER_ROUND_CENTER_X, CENTER_ROUND_CENTER_Y) radius:CIRCLE_RADIUS startAngle:(ang/180.0)*M_PI endAngle:((ang-1)/(180.0))*M_PI clockwise:YES];
                
                CAKeyframeAnimation *orbit = [CAKeyframeAnimation animationWithKeyPath:@"position"];
                orbit.path = path.CGPath;
                orbit.duration = 46;
                orbit.repeatCount = HUGE_VALF;
                
                [((UIButton*)[_roundArray objectAtIndex:index]).layer addAnimation:orbit forKey:@"orbit"];
                
            }
        });
        
    });
}


-(void)randColor
{
    NSArray *temp = [NSArray arrayWithObjects:@"0",@"1", @"2", @"3", @"4", @"5",nil];
    
    NSMutableArray *tempArray = [[NSMutableArray alloc] initWithArray:temp];
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    
    [self resetRandArray];
    
    int i;
    
    for (i = 0; i < ROUND_COUNT; i ++)
    {
        int index = arc4random() % (ROUND_COUNT - i);
        [resultArray addObject:[tempArray objectAtIndex:index]];
        
        [tempArray removeObjectAtIndex:index];
    }

    
    for( i = 0; i < ROUND_COUNT; ++ i )
    {
        _randArray[i] = [[resultArray objectAtIndex:i] intValue];
        
        //NSLog(@"rand:%d",_randArray[i]);
    }
    
    for( i = 0; i < ROUND_COUNT; ++ i )
    {
        ((UIButton*)[_roundArray objectAtIndex:i]).backgroundColor = [_colorArray objectAtIndex:_randArray[i]];
    }
    
    //
    srand(time(0));
    _targetIndex = rand()%ROUND_COUNT;
    _targetIndex *= _targetIndex;
    _targetIndex %= ROUND_COUNT;
    
    NSLog(@"_targetIndex:%d",_targetIndex);
    
    _textLabel.textColor = [_colorArray objectAtIndex:_targetIndex];
    
    switch(_randArray[_targetIndex] )
    {
        case 0:
            _textLabel.text = @"红色";
            break;
        case 1:
            _textLabel.text = @"橙色";
            break;
        case 2:
            _textLabel.text = @"紫色";
            break;
        case 3:
            _textLabel.text = @"棕色";
            break;
        case 4:
            _textLabel.text = @"蓝色";
            break;
        case 5:
            _textLabel.text = @"黑色";
            break;
    }
}


-(void)startGame
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^(void){
        
        while(YES)
        {
            dispatch_async(dispatch_get_main_queue(), ^(void){
                
                [self randColor];
        
            });
            
            if( _viewDisp )
            {
                break;
            }
            
            [NSThread sleepForTimeInterval:RAND_INTERVAL];
        }
    });
}


-(void)viewWillDisappear:(BOOL)animated
{
    _viewDisp = YES;
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
