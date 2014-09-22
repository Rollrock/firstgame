//
//  MainViewController.m
//  GameDemo
//
//  Created by zhuang chaoxiao on 14-7-7.
//  Copyright (c) 2014年 zhuang chaoxiao. All rights reserved.
//

#import "MainViewController.h"
#import "Header.h"
#import "FirstViewController.h"
#import "NumberViewController.h"
#import "Number2ViewController.h"
#import "RGBViewController.h"
#import "AskViewController.h"
#import "SettingViewController.h"
#import "AdvViewController.h"
#import "SlideViewController.h"
#import "AppsViewController.h"
#import "AppDelegate.h"
#import "YouMiWallSpot.h"
#import "YouMiWallSpotView.h"
#import "SecondViewController.h"
#import "SettingViewController.h"

#define BTN_1_POS_X  50
#define BTN_1_POS_Y  35

#define BTN_2_POS_X  230
#define BTN_2_POS_Y  35

#define BTN_3_POS_X  50
#define BTN_3_POS_Y  170

#define BTN_4_POS_X  240
#define BTN_4_POS_Y  170





#define BTN_5_POS_X  85
#define BTN_5_POS_Y  140

#define BTN_6_POS_X  210
#define BTN_6_POS_Y  130

#define BTN_7_POS_X  320
#define BTN_7_POS_Y  130

#define BTN_8_POS_X  150
#define BTN_8_POS_Y  205

#define BTN_9_POS_X  270
#define BTN_9_POS_Y  210


@interface MainViewController ()
{
    NSTimeInterval firstTime;
    NSTimeInterval secondTime;
    
    NSMutableArray * _btnArray;
    
}
@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        _btnArray = [[ NSMutableArray alloc]init];
    }
    return self;
}


-(void)viewDidAppear:(BOOL)animated
{
    return;
    
    NSLog(@"viewDidAppear");
    
    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
    
    [userDefault setBool:YES forKey:PASS_1_ID];

    for( NSInteger index = 0; index < [_btnArray count]; ++ index )
    {
        NSString * str = [NSString stringWithFormat:@"pass_%d_id",index+1];
        
        BOOL pass = [userDefault boolForKey:str];
        
        UIButton * btn = [_btnArray objectAtIndex:index];
        btn.enabled = YES;//pass;
    }
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
 
    UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    imgView.image = [UIImage imageNamed:@"GameBg"];
    imgView.userInteractionEnabled = YES;
    [self.view addSubview:imgView];
    
    
    NSLog(@"screen w:%f h:%f",SCREEN_WIDTH,SCREEN_HEIGHT);
    
    
    {
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectZero];
        NSString * strName = @"main_1";
        UIImage * img = [UIImage imageNamed:strName];
        [btn setBackgroundImage:img forState:UIControlStateNormal];
        
        CGPoint pt = [self getImageWidthHeight:strName];
        
        btn.frame = CGRectMake(BTN_1_POS_X, BTN_1_POS_Y, pt.x*2, pt.y*2);
        
        btn.tag = 1;
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [imgView addSubview:btn];
        
        [_btnArray addObject:btn];
    }
    
    {
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectZero];
        NSString * strName = @"main_2";
        UIImage * img = [UIImage imageNamed:strName];
        [btn setBackgroundImage:img forState:UIControlStateNormal];
        
        CGPoint pt = [self getImageWidthHeight:strName];
        
        btn.frame = CGRectMake(BTN_2_POS_X, BTN_2_POS_Y, pt.x*2, pt.y*2);
        
        btn.tag = 2;
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [imgView addSubview:btn];
        
        [_btnArray addObject:btn];
    }
    
    {
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectZero];
        NSString * strName = @"main_3";
        UIImage * img = [UIImage imageNamed:strName];
        [btn setBackgroundImage:img forState:UIControlStateNormal];
        
        CGPoint pt = [self getImageWidthHeight:strName];
        
        btn.frame = CGRectMake(BTN_3_POS_X, BTN_3_POS_Y, pt.x*2, pt.y*2);
        btn.tag = 3;
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [imgView addSubview:btn];
        
        [_btnArray addObject:btn];
    }
    
    {
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectZero];
        NSString * strName = @"main_4";
        UIImage * img = [UIImage imageNamed:strName];
        [btn setBackgroundImage:img forState:UIControlStateNormal];
        btn.tag = 4;
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        CGPoint pt = [self getImageWidthHeight:strName];
        
        btn.frame = CGRectMake(BTN_4_POS_X, BTN_4_POS_Y, pt.x*2, pt.y*2);
        
        [imgView addSubview:btn];
        
        [_btnArray addObject:btn];
    }
    
    
    /*
    {
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectZero];
        NSString * strName = @"main_5";
        UIImage * img = [UIImage imageNamed:strName];
        [btn setBackgroundImage:img forState:UIControlStateNormal];
        btn.tag = 5;
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        CGPoint pt = [self getImageWidthHeight:strName];
        
        btn.frame = CGRectMake(BTN_5_POS_X, BTN_5_POS_Y, pt.x, pt.y);
        
        [imgView addSubview:btn];
        
        [_btnArray addObject:btn];
        
        btn.enabled = NO;
    }
    
    {
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectZero];
        NSString * strName = @"main_6";
        UIImage * img = [UIImage imageNamed:strName];
        [btn setBackgroundImage:img forState:UIControlStateNormal];
        btn.tag = 6;
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        CGPoint pt = [self getImageWidthHeight:strName];
        
        btn.frame = CGRectMake(BTN_6_POS_X, BTN_6_POS_Y, pt.x, pt.y);
        
        [imgView addSubview:btn];
        
        [_btnArray addObject:btn];
        
        btn.enabled = NO;
    }
    
    {
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectZero];
        NSString * strName = @"main_7";
        UIImage * img = [UIImage imageNamed:strName];
        [btn setBackgroundImage:img forState:UIControlStateNormal];
        
        CGPoint pt = [self getImageWidthHeight:strName];
        
        btn.frame = CGRectMake(BTN_7_POS_X, BTN_7_POS_Y, pt.x, pt.y);
        
        [imgView addSubview:btn];
        
        [_btnArray addObject:btn];
        
        btn.enabled = NO;
    }
    
    {
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectZero];
        NSString * strName = @"main_8";
        UIImage * img = [UIImage imageNamed:strName];
        [btn setBackgroundImage:img forState:UIControlStateNormal];
        
        CGPoint pt = [self getImageWidthHeight:strName];
        
        btn.frame = CGRectMake(BTN_8_POS_X, BTN_8_POS_Y, pt.x, pt.y);
        
        [imgView addSubview:btn];
        
        [_btnArray addObject:btn];
        
        btn.enabled = NO;
    }
    
    {
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectZero];
        NSString * strName = @"main_9";
        UIImage * img = [UIImage imageNamed:strName];
        [btn setBackgroundImage:img forState:UIControlStateNormal];
        
        CGPoint pt = [self getImageWidthHeight:strName];
        
        btn.frame = CGRectMake(BTN_9_POS_X, BTN_9_POS_Y, pt.x, pt.y);
        
        [imgView addSubview:btn];
        
        [_btnArray addObject:btn];
        
        btn.enabled = NO;
    }
     */
    
    //
    //  打分  声音设置  app推介
#define HELP_ROUND_WIDTH 40
    
    {
        CGRect rect = CGRectMake(20, 270, 220, 50);
        UIView * helpView = [[UIView alloc]initWithFrame:rect];
        helpView.backgroundColor = [UIColor grayColor];
        helpView.layer.cornerRadius = 10;
        //helpView.alpha = 0.5;
        
        [imgView addSubview:helpView];
        
        //
        // score
        {
            CGRect rect;
            rect = CGRectMake(10, 5, HELP_ROUND_WIDTH, HELP_ROUND_WIDTH);
            UIButton * askBtn = [[UIButton alloc]initWithFrame:rect];
            [askBtn setBackgroundImage:[UIImage imageNamed:@"store"] forState:UIControlStateNormal];
            [askBtn addTarget:self action:@selector(scoreClick) forControlEvents:UIControlEventTouchUpInside];
            
            [helpView addSubview:askBtn];
        }
        
        // sound
        {
            
            AppDelegate *appDel = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            BOOL mute = [appDel readSoundSetting];
            
            CGRect rect;
            rect = CGRectMake(10+HELP_ROUND_WIDTH+10, 5, HELP_ROUND_WIDTH, HELP_ROUND_WIDTH);
            UIButton * askBtn = [[UIButton alloc]initWithFrame:rect];
            
            if( !mute )
            {
                [askBtn setBackgroundImage:[UIImage imageNamed:@"sound"] forState:UIControlStateNormal];
            }
            else
            {
               [askBtn setBackgroundImage:[UIImage imageNamed:@"mute"] forState:UIControlStateNormal];
            }
            
            [askBtn addTarget:self action:@selector(soundClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [helpView addSubview:askBtn];
        }
        
        AppDelegate * appDel = [[UIApplication sharedApplication] delegate];
        
        
        // apps
        {
            CGRect rect;
            rect = CGRectMake(10+2*(HELP_ROUND_WIDTH+10), 5, HELP_ROUND_WIDTH, HELP_ROUND_WIDTH);
            UIButton * askBtn = [[UIButton alloc]initWithFrame:rect];
            [askBtn setBackgroundImage:[UIImage imageNamed:@"apps"] forState:UIControlStateNormal];
            [askBtn addTarget:self action:@selector(appClick) forControlEvents:UIControlEventTouchUpInside];
            
            [helpView addSubview:askBtn];
            
            //if( ![appDel canShowAdv] )
            {
                //askBtn.hidden = NO;
            }
        }

        
        // adv
        {
            CGRect rect;
            rect = CGRectMake(10+3*(HELP_ROUND_WIDTH+10), 5, HELP_ROUND_WIDTH, HELP_ROUND_WIDTH);
            UIButton * askBtn = [[UIButton alloc]initWithFrame:rect];
            [askBtn setBackgroundImage:[UIImage imageNamed:@"advs"] forState:UIControlStateNormal];
            [askBtn addTarget:self action:@selector(advClick) forControlEvents:UIControlEventTouchUpInside];
            
            [helpView addSubview:askBtn];
            
            if( ![appDel canShowAdv] )
            {
                askBtn.hidden = YES;
            }
        }
    }
}


//展示第三方广告
-(void)advClick
{
    NSLog(@"advClick");
    
    AppDelegate * appDel = [[UIApplication sharedApplication] delegate];
    
    if( [appDel canShowAdv ] )
    {
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
        
    }

}

// 展示自己的app集合
-(void)appClick
{
    SettingViewController * vc = [[SettingViewController alloc]initWithNibName:nil bundle:nil];
    
    [self presentViewController:vc animated:YES completion:nil];
    
    /*
    NSLog(@"appClick");
    
    AppsViewController * vc = [[AppsViewController alloc]init];
    
    [self presentViewController:vc animated:YES completion:nil];
    */
}

-(void)scoreClick
{
    NSLog(@"scoreClick");
    
    NSString *str =  [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@",@"912210779"];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    
}

-(void)soundClick:(UIButton*)btn
{
    NSLog(@"soundClick");
    
    AppDelegate *appDel = (AppDelegate*)[[UIApplication sharedApplication] delegate];

    if([appDel readSoundSetting])
    {
        [btn setBackgroundImage:[UIImage imageNamed:@"sound"] forState:UIControlStateNormal];
        [appDel wirteSoundSetting:NO];
    }
    else
    {
        [btn setBackgroundImage:[UIImage imageNamed:@"mute"] forState:UIControlStateNormal];
        [appDel wirteSoundSetting:YES];
    } 
}

-(void)settingBtnClick
{
    SettingViewController * vc = [[SettingViewController alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
}

-(void)askBtnClick
{
    AskViewController * vc = [[AskViewController alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
}


-(CGPoint)getImageWidthHeight:(NSString* )imageName
{
    UIImage * img = [UIImage imageNamed:imageName];
    
    return CGPointMake(img.size.width/2, img.size.height/2);
}

-(void)btnClicked:(UIButton*)btn
{
    
    NSLog(@"btnClicked tag:%d",btn.tag);
    
    switch (btn.tag) {
        case 1:
        {
            FirstViewController * vc = [[FirstViewController alloc]initWithNibName:nil bundle:nil];
            
            [self presentViewController:vc animated:YES completion:^(void){
                
            }];
            
            vc = nil;
        }
            break;
            
        case 2:
        {
            NumberViewController * vc = [[NumberViewController alloc]init];
            [self presentViewController:vc animated:YES completion:nil];
        }
            break;
            
        case 3:
        {
            /*
            Number2ViewController * vc = [[Number2ViewController alloc]init];
            [self presentViewController:vc animated:YES completion:nil];
             */
            
            SecondViewController * vc = [[SecondViewController alloc]init];
            
            [self presentViewController:vc animated:YES completion:nil];

        }
            break;
            
        case 4:
        {
            RGBViewController * vc = [[RGBViewController alloc]init];
            [self presentViewController:vc animated:YES completion:nil];
        }
            break;
            
        case 5:
        {
            /*
            SecondViewController * vc = [[SecondViewController alloc]init];
            
            [self presentViewController:vc animated:YES completion:nil];
             */
        }
            break;
   
        default:
            break;
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
