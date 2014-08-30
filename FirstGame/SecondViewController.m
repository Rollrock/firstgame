//
//  FirstViewController.m
//  FirstGame
//
//  Created by zhuang chaoxiao on 14-7-15.
//  Copyright (c) 2014年 zhuang chaoxiao. All rights reserved.
//

#import "SecondViewController.h"
#import "Header.h"
#import "YouMiWallSpot.h"
#import "YouMiWallSpotView.h"
#import "MyAdmobView.h"
#import "AppDelegate.h"

#define ROUND_WIDTH  100
#define ROUND_HEIGHT 100
#define ROUND_POS_X  ((SCREEN_WIDTH - ROUND_WIDTH)/2)
#define ROUND_POS_Y  ((SCREEN_HEIGHT - ROUND_HEIGHT)/2)

#define MAX_TIME_DIS  111.0

//30秒
#define DWON_COUNT_TIMER   30
#define BASE_TAG  10086


@interface SecondViewController ()
{
    NSTimeInterval firstTime;
    NSTimeInterval secondTime;
    
    CAShapeLayer * _cirleLayer;
    UIImageView * _bgImgView;
    UIButton * _btn;
    
    UIButton * _startBtn;
    
    UILabel * _downCountLab;
    int _downCount;
    
    UILabel * _scoreLab;
    int _currScore;
    int _lastTag;
    
    
    SystemSoundID soundId;
    BOOL  _soundPlay;
}
@end

@implementation SecondViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    
        _downCount = DWON_COUNT_TIMER;
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
    
    //
    CGRect rect;
    
#define TEMP_ROUND_WIDHT   60
    
    {
        rect = CGRectMake(100, 100, TEMP_ROUND_WIDHT, TEMP_ROUND_WIDHT);
        UIButton * btn = [[UIButton alloc]initWithFrame:rect];
        btn.layer.cornerRadius = TEMP_ROUND_WIDHT/2;
        btn.tag = 0+BASE_TAG;
        [btn setBackgroundImage:[UIImage imageNamed:@"second_1"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchDown];
        [_bgImgView addSubview:btn];
    }
    
    
    {
        rect = CGRectMake(240, 100, TEMP_ROUND_WIDHT, TEMP_ROUND_WIDHT);
        UIButton * btn = [[UIButton alloc]initWithFrame:rect];
        btn.layer.cornerRadius = TEMP_ROUND_WIDHT/2;
        btn.tag = 1+BASE_TAG;
        [btn setBackgroundImage:[UIImage imageNamed:@"second_2"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchDown];
        [_bgImgView addSubview:btn];
    }
    
    {
        rect = CGRectMake(100, 200, TEMP_ROUND_WIDHT, TEMP_ROUND_WIDHT);
        UIButton * btn = [[UIButton alloc]initWithFrame:rect];
        btn.layer.cornerRadius = TEMP_ROUND_WIDHT/2;
        btn.tag = 3+BASE_TAG;
        [btn setBackgroundImage:[UIImage imageNamed:@"second_4"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchDown];
        [_bgImgView addSubview:btn];
    }
    
    {
        rect = CGRectMake(240, 200, TEMP_ROUND_WIDHT, TEMP_ROUND_WIDHT);
        UIButton * btn = [[UIButton alloc]initWithFrame:rect];
        btn.layer.cornerRadius = TEMP_ROUND_WIDHT/2;
        btn.tag = 2+BASE_TAG;
        [btn setBackgroundImage:[UIImage imageNamed:@"second_3"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchDown];
        [_bgImgView addSubview:btn];
    }
    
    //倒数计时
    {
        rect = CGRectMake(400, 20, 50, 20);
        _downCountLab = [[UILabel alloc]initWithFrame:rect];
        _downCountLab.text = [NSString stringWithFormat:@"%d秒",_downCount];
        _downCountLab.textAlignment = NSTextAlignmentCenter;
        _downCountLab.backgroundColor = [UIColor orangeColor];
        //_downCountLab.layer.cornerRadius = 20/2;
        [_bgImgView addSubview:_downCountLab];
    }
    
    //提示
    {
        rect = CGRectMake(80, 20, 300, 20);
        UILabel * tipLab = [[UILabel alloc]initWithFrame:rect];
        tipLab.text = @"在30秒内依次按 右->下->左->上 顺序点击的次数尽量多";
        tipLab.textAlignment = NSTextAlignmentCenter;
        tipLab.backgroundColor = [UIColor whiteColor];
        tipLab.font = [UIFont systemFontOfSize:12];
        [_bgImgView addSubview:tipLab];

    }
    
    //重新开始按钮
    {
        rect = CGRectMake(380, 150, TEMP_ROUND_WIDHT, TEMP_ROUND_WIDHT);
        _startBtn = [[UIButton alloc]initWithFrame:rect];
        _startBtn.layer.cornerRadius = TEMP_ROUND_WIDHT/2;
        _startBtn.backgroundColor = [UIColor orangeColor];
        [_startBtn addTarget:self action:@selector(reStartGame) forControlEvents:UIControlEventTouchDown];
        [_bgImgView addSubview:_startBtn];
        
        
        rect = CGRectMake(5, 20, TEMP_ROUND_WIDHT-10, 20);
        UILabel * text = [[UILabel alloc]initWithFrame:rect];
        text.text = @"重新开始";
        text.font = [UIFont systemFontOfSize:12];
        text.backgroundColor = [UIColor clearColor];
        [_startBtn addSubview:text];
        
    }
    
    {
        
        rect = CGRectMake(400, 60, 50, 20);
        _scoreLab = [[UILabel alloc]initWithFrame:rect];
        _scoreLab.text = @"0分";
        _scoreLab.textAlignment = NSTextAlignmentCenter;
        _scoreLab.font = [UIFont systemFontOfSize:12];
        _scoreLab.backgroundColor = [UIColor orangeColor];
        [_bgImgView addSubview:_scoreLab];

    }
    
    //
    {
        UIButton * btnBack = [[UIButton alloc]initWithFrame:CGRectMake(BACK_POS_X, BACK_POS_Y, BACK_WIDTH, BACK_HEIGHT)];
        [btnBack setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [btnBack addTarget:self action:@selector(btnBack) forControlEvents:UIControlEventTouchUpInside];
        [imgView addSubview:btnBack];
    }
    
    [self downCount];
    
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

    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"success" ofType:@"wav"];
    
    if (path)
    {
         AudioServicesCreateSystemSoundID((CFURLRef)CFBridgingRetain([NSURL fileURLWithPath:path]),&soundId);
    }
    
    path = nil;
}


-(void)playSound
{
    if( _soundPlay )
    {
        AudioServicesPlaySystemSound(soundId);
    }
    
}

-(void)stopGame
{
    _downCount = 1;
    
    _currScore = 0;
    
    _lastTag  = 0;
    
    [self enableBtn:NO];
}

-(void)reStartGame
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^(void){
       
        _downCount = 1;
        
        [NSThread sleepForTimeInterval:1.5];
        
        _downCount = DWON_COUNT_TIMER;
        
        dispatch_async(dispatch_get_main_queue(), ^(void){
           
            
            [self enableBtn:YES];
            
            [self downCount];
        });
        
    });

}


-(void)downCount
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^(void){
       
        while (YES)
        {
            [NSThread sleepForTimeInterval:1];
            
            -- _downCount;
            
            dispatch_async(dispatch_get_main_queue(), ^(void){
                
                _downCountLab.text = [NSString stringWithFormat:@"%d秒",_downCount];
                
                if( _downCount <= 0 )
                {
                    [self enableBtn:NO];
                }
            });
            
            
            if( _downCount <= 0 )
            {
                break;
            }
            
        }
       
    });
}



-(void)btnBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
}



-(NSTimeInterval)getCurrentTime
{
    NSDate *date=[NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval time=[date timeIntervalSince1970]*1000;
    
    return time;
}



-(void)clicked:(UIButton*)btn
{
    NSLog(@"btnTag:%d",btn.tag);
    
    if( btn.tag -BASE_TAG == _lastTag %4 )
    {
        ++ _lastTag;
        
        
        ++_currScore;
        _scoreLab.text = [NSString stringWithFormat:@"%d分",_currScore];
        
        
        [self playSound];
    }
    else
    {
        NSLog(@"wrong");
        
        [self stopGame];
        
        //显示广告
        
        
        AppDelegate * appDel = [[UIApplication sharedApplication] delegate];
        
        if( [appDel canShowAdv] )
        {
            srand(time(0));
            
            if( rand() % 3 == 0 )
            {
                [[MyAdmobView alloc]initWithViewController:self];
            }
            else
            {
                if ([YouMiWallSpot isReady]) {
                    [YouMiWallSpot showSpotViewWithBlock:^{
                        NSLog(@"积分插播退出");
                    }];
                }
            }
        }
        else
        {
            [[MyAdmobView alloc]initWithViewController:self];
        }
        
     }
}





-(void)enableBtn:(BOOL)bFlag
{
    
    for( int i = 0; i < 4; ++ i )
    {
      ((UIButton*)[_bgImgView viewWithTag:BASE_TAG+i]).enabled = bFlag;
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

