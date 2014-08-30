//
//  NumberViewController.m
//  FirstGame
//
//  Created by zhuang chaoxiao on 14-7-16.
//  Copyright (c) 2014年 zhuang chaoxiao. All rights reserved.
//

#import "Number2ViewController.h"
#import "Header.h"

#define CIRCLE_WIDTH   60
#define CIRCLE_HEIGHT  60
#define CIRCLE_DIS_X   25
#define CIRCLE_DIS_Y   10

#define CIRCLE_MARGIN_LEFT   125
#define CIRCLE_MARGIN_TOP   95


#define TAG_BASE   10086

#define NUM_MAX_LEN  10


@interface Number2ViewController ()
{
    UIImageView * _bgImgView;
    NSMutableArray * _btnArray;
    NSMutableArray * _btnRetArray;
    UIButton * _btnStart;
    NSInteger _dataArr[NUM_MAX_LEN];
    NSInteger _cmpdataArr[NUM_MAX_LEN];
    
    NSInteger _randArr[NUM_MAX_LEN];
    
    BOOL _canClicked;
}
@end

@implementation Number2ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        _btnArray = [[NSMutableArray alloc]init];
        _btnRetArray = [[NSMutableArray alloc]init];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGRect rect = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    _bgImgView = [[UIImageView alloc]initWithFrame:rect];
    _bgImgView.image = [UIImage imageNamed:@"OtherGameBG"];
    _bgImgView.userInteractionEnabled = YES;
    [self.view addSubview:_bgImgView];
    
    [self initRandArray];
    
    //[self initNumberView];
    
    //
    {
        UIButton * btnBack = [[UIButton alloc]initWithFrame:CGRectMake(BACK_POS_X, BACK_POS_Y, BACK_WIDTH, BACK_HEIGHT)];
        [btnBack setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [btnBack addTarget:self action:@selector(btnBack) forControlEvents:UIControlEventTouchUpInside];
        [_bgImgView addSubview:btnBack];
    }
}

-(void)btnBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)initRandArray
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^(void){
        
        for( NSInteger index = 0; index < NUM_MAX_LEN-1; ++ index )
        {
            _randArr[index] = index + 1;
        }
        
        srand((unsigned)time(0));
        NSInteger genNum =  rand();
        
        for( NSInteger index = 0; index < NUM_MAX_LEN*3; ++ index )
        {
            NSInteger ret = genNum % (9);  // 0-8
            genNum = genNum/9;
            
            if( index % 3 == 0 )
            {
                NSInteger temp = _randArr[ret];
                _randArr[ret] = _randArr[8-ret];
                _randArr[8-ret] = temp;
            }
            else
            {
                NSInteger temp = _randArr[ret];
                _randArr[ret] = _randArr[index%9];
                _randArr[index%9] = temp;
            }
        }
        
        
        for( NSInteger index = 0; index < NUM_MAX_LEN-1; ++ index )
        {
            //NSLog(@"_ranArray:%d",_randArr[index]);
        }
        
        dispatch_async(dispatch_get_main_queue(),^(void){
           
            [self initNumberView];
            
        });
        
    });

}

-(void)initNumberView
{
    for( UIButton * btn in _btnArray )
    {
        [btn removeFromSuperview];
    }
    
    [_btnArray removeAllObjects];
    
    ////
    for( NSInteger i = 0; i < 3; ++ i )
    {
        for( NSInteger j = 0; j < 3; ++ j )
        {
            CGRect rect = CGRectMake(CIRCLE_MARGIN_LEFT + (CIRCLE_WIDTH + CIRCLE_DIS_X)*(j), CIRCLE_MARGIN_TOP+(CIRCLE_HEIGHT + CIRCLE_DIS_Y)*(i), CIRCLE_WIDTH, CIRCLE_HEIGHT);
            
            UIButton * btn = [[UIButton alloc]initWithFrame:rect];
            btn.tag = TAG_BASE + (i*3+j+1);
            [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"num_%d",_randArr[i*3+j]/*(i*3+j+1)*/]] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [_bgImgView addSubview:btn];
            
            [_btnArray addObject:btn];
        }
    }
    
    /////////
    _btnStart = [[UIButton alloc]initWithFrame:CGRectMake(50, 200, 50, 50)];
    _btnStart.backgroundColor = [UIColor grayColor];
    [_btnStart addTarget:self action:@selector(startGame) forControlEvents:UIControlEventTouchUpInside];
    [_bgImgView addSubview:_btnStart];
    
    //
}


-(void)btnClicked:(UIButton*)btn
{
    NSInteger tag = btn.tag - TAG_BASE;
    NSLog(@"tag:%d",tag);
    
    BOOL bFlag = NO;
    NSInteger retIndex = 0;
    
    for( NSInteger index = 0; index < NUM_MAX_LEN; ++ index )
    {
        if( _cmpdataArr[index] == 0 )
        {
            _cmpdataArr[index] = _randArr[tag-1];
            break;
        }
    }
    
    
    for(NSInteger index = 0; index < NUM_MAX_LEN; ++ index )
    {
        if( (_cmpdataArr[index] != _dataArr[index]) &&( _cmpdataArr[index] != 0 ))
        {
            bFlag = YES;
            break;
        }
    }
    
    for(NSInteger index = 0; index < NUM_MAX_LEN; ++ index )
    {
        if( _cmpdataArr[index] == _dataArr[index] )
        {
            retIndex = index;
        }
        else
        {
            break;
        }
    }
    
    
    /////////
    if( bFlag )
    {
        NSLog(@"wrong");
        
        [self layoutResult:NO];
        
        [self enableNum:NO];
    }
    else
    {
        [self layoutResult:YES];
    }
    
    if( retIndex == NUM_MAX_LEN -1)
    {
        NSLog(@"success ");
    }
}


-(void)layoutResult:(BOOL)bFlag
{
    #define RET_POS_X  80
    #define RET_POS_Y  20
    #define RET_WIDTH  35
    #define RET_HEIGHT 35
    #define RET_DIS  5
    
    NSInteger count = 0;
    
    for(NSInteger index = 0; index < NUM_MAX_LEN; ++ index )
    {
        if( _cmpdataArr[index] != 0)
        {
            ++ count;
        }
        else
        {
            break;
        }
    }
    
    
    CGRect rect = CGRectMake(RET_POS_X + (RET_WIDTH + RET_DIS)*(count-1), RET_POS_Y, RET_WIDTH, RET_HEIGHT);
    UIImageView * imgView = [[UIImageView alloc]initWithFrame:rect];
    
    if( bFlag )
    {
        UIImage * img = [UIImage imageNamed:[NSString stringWithFormat:@"num_%d",_cmpdataArr[count-1]]];
        imgView.image = img;
    }
    else
    {
        UIImage * img = [UIImage imageNamed:@"num_wrong"];
        imgView.image = img;
    }
    
    
    [_bgImgView addSubview:imgView];
    
    /////////////
    [_btnRetArray addObject:imgView];
    
}


-(void)enableNum:(BOOL)bFlag
{
    for(NSInteger index = 0; index < 9; ++ index )
    {
        UIButton * btn = [_btnArray objectAtIndex:index];
        
        btn.enabled = bFlag;
    }
}


-(void)generNumber
{
    //
    for( NSInteger index = 0; index < NUM_MAX_LEN; ++ index )
    {
        _cmpdataArr[index] = 0;
        _dataArr[index] = 0;
    }
    
    //
    
    srand((unsigned)time(0));
    NSInteger genNum =  rand() % 10000000000;
    
    //NSLog(@"genNum:%d",genNum);
    
    for( NSInteger index = 0; index < NUM_MAX_LEN; ++ index )
    {
        NSInteger ret1 = genNum%10;
        genNum = genNum / 10;
        
        if( genNum == 0 )
        {
            break;
        }
        
        if( ret1 == 0 )
        {
            -- index;
        }
        else
        {
            _dataArr[index] = ret1;
        }
        
        NSLog(@"ret1:%d",ret1);
    }
    
    // log out
    
    for( NSInteger index = 0; index < NUM_MAX_LEN; ++ index )
    {
        NSLog(@"data:%d",_dataArr[index]);
    }
}


-(void)startGame
{
    
    [self initRandArray];
    
    _canClicked = NO;
    
    [self generNumber];
    
    [self enableNum:NO];
    
    
    /////////////////////////////////////////////
    for( UIImageView * imgView in _btnRetArray )
    {
        [imgView removeFromSuperview];
    }
    
    [_btnRetArray removeAllObjects];
    /////////////////////////////////////////////
    

    dispatch_time_t delay = dispatch_time(DISPATCH_TIME_NOW, 1*NSEC_PER_SEC);
    
    dispatch_after(delay, dispatch_get_global_queue(0, 0), ^(void){
        
        for (NSInteger index = 0 ; index < NUM_MAX_LEN-1; ++index)
        {
            NSInteger num = _dataArr[index];
            
            if( num <= 0 )
            {
                dispatch_async(dispatch_get_main_queue(), ^(void)
                               {
                                   [self enableNum:YES];
                               });
                
                break;
            }
            
            dispatch_async(dispatch_get_main_queue(), ^(void)
                           {
                               //[self blinkNumber:num-1];
                               
                               NSInteger loop = 0;
                               
                               for(loop = 0; loop < NUM_MAX_LEN-2; ++ loop )
                               {
                                   if( _randArr[loop] == num )
                                   {
                                       break;
                                   }
                               }
                               
                               [self blinkNumber:loop];
                           });
            
            [NSThread sleepForTimeInterval:0.5f];
        }

        
    });
    
    
    //
   // dispatch_async(dispatch_get_global_queue(0, 0), ^(void){
        
  //         });
    
    //
}



-(void)blinkNumber:(NSInteger)num
{
    CGRect rect = CGRectMake(0, 0, CIRCLE_WIDTH, CIRCLE_HEIGHT);
    
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:CIRCLE_HEIGHT/2];
    CAShapeLayer * layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    layer.fillColor = [[UIColor orangeColor] CGColor];
    layer.opacity = 0.8;
    
    UIButton * btn = [_btnArray objectAtIndex:num];
    [btn.layer addSublayer:layer];
    
    //
    dispatch_async(dispatch_get_main_queue(), ^(void){
        
        [NSThread sleepForTimeInterval:0.4];
        [layer removeFromSuperlayer];
    });
    
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
