//
//  RGBViewController.m
//  FirstGame
//
//  Created by zhuang chaoxiao on 14-7-29.
//  Copyright (c) 2014年 zhuang chaoxiao. All rights reserved.
//

#import "RGBViewController.h"
#import "Header.h"


#define LEFT_UP_ROUND_X 100
#define LEFT_UP_ROUND_Y 100

#define LEFT_DOWN_ROUND_X 100
#define LEFT_DOWN_ROUND_Y 200

#define RIGHT_UP_ROUND_X 300
#define RIGHT_UP_ROUND_Y 100

#define RIGHT_DOWN_ROUND_X 300
#define RIGHT_DOWN_ROUND_Y 200

#define UP_ROUND_X  200
#define UP_ROUND_Y  50

#define DOWN_ROUND_X 200
#define DOWN_ROUND_Y 250

#define CENTER_ROUND_X 200
#define CENTER_ROUND_Y 150


#define CIRCLE_RADIUS  (CENTER_ROUND_Y-UP_ROUND_Y)

#define C_ROUND_WIDTH  60
#define C_ROUND_HEIGHT 60


#define ROUND_COUNT  6

#define RAND_INTERVAL  2.5



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
    NSArray * _roundArray;
    
    
    NSInteger _randArray[ROUND_COUNT];
    
    NSInteger _targetIndex;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _bgImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _bgImgView.image = [UIImage imageNamed:@"OtherGameBG"];
    _bgImgView.userInteractionEnabled = YES;
    [self.view addSubview:_bgImgView];
    
    
    [self initView];
    
    
    
    [self startGame];
    
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


-(void)initView
{
    CGRect rect;
    
    //////
    rect = CGRectMake(LEFT_UP_ROUND_X, LEFT_UP_ROUND_Y, C_ROUND_WIDTH, C_ROUND_HEIGHT);
    _left_up_btn = [[UIButton alloc]initWithFrame:rect];
    _left_up_btn.layer.cornerRadius = C_ROUND_WIDTH/2;
    
    _left_up_btn.backgroundColor = [UIColor redColor];
    
    [_bgImgView addSubview:_left_up_btn];
    
    ///////
    rect = CGRectMake(LEFT_DOWN_ROUND_X, LEFT_DOWN_ROUND_Y, C_ROUND_WIDTH, C_ROUND_HEIGHT);
    _left_down_btn = [[UIButton alloc]initWithFrame:rect];
    _left_down_btn.layer.cornerRadius = C_ROUND_WIDTH/2;
    _left_down_btn.backgroundColor = [UIColor blackColor];
    
    [_bgImgView addSubview:_left_down_btn];
    
    //////
    rect = CGRectMake(RIGHT_UP_ROUND_X, RIGHT_UP_ROUND_Y, C_ROUND_WIDTH, C_ROUND_HEIGHT);
    _right_up_btn = [[UIButton alloc]initWithFrame:rect];
    _right_up_btn.layer.cornerRadius = C_ROUND_WIDTH/2;
    _right_up_btn.backgroundColor = [UIColor orangeColor];
    
    [_bgImgView addSubview:_right_up_btn];
    
    //////
    rect = CGRectMake(RIGHT_DOWN_ROUND_X, RIGHT_DOWN_ROUND_Y, C_ROUND_WIDTH, C_ROUND_HEIGHT);
    _right_down_btn = [[UIButton alloc]initWithFrame:rect];
    _right_down_btn.layer.cornerRadius = C_ROUND_WIDTH/2;
    _right_down_btn.backgroundColor = [UIColor blueColor];
    
    [_bgImgView addSubview:_right_down_btn];
    
    
    //////
    rect = CGRectMake(UP_ROUND_X, UP_ROUND_Y, C_ROUND_WIDTH, C_ROUND_HEIGHT);
    _up_btn = [[UIButton alloc]initWithFrame:rect];
    _up_btn.layer.cornerRadius = C_ROUND_WIDTH/2;
    _up_btn.backgroundColor = [UIColor lightGrayColor];
    
    [_bgImgView addSubview:_up_btn];
    
    
    //////
    rect = CGRectMake(DOWN_ROUND_X, DOWN_ROUND_Y, C_ROUND_WIDTH, C_ROUND_HEIGHT);
    _down_btn = [[UIButton alloc]initWithFrame:rect];
    _down_btn.layer.cornerRadius = C_ROUND_WIDTH/2;
    _down_btn.backgroundColor = [UIColor darkGrayColor];
    
    [_bgImgView addSubview:_down_btn];
    
    //////
    rect = CGRectMake(CENTER_ROUND_X, CENTER_ROUND_Y, C_ROUND_WIDTH, C_ROUND_HEIGHT);
    _center_view = [[UIButton alloc]initWithFrame:rect];
    _center_view.layer.cornerRadius = C_ROUND_WIDTH/2;
    _center_view.backgroundColor = [UIColor grayColor];
    
    [_bgImgView addSubview:_center_view];
    
    //
    [_up_btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchDown];
    [_right_up_btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchDown];
    [_right_down_btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchDown];
    [_down_btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchDown];
    [_left_down_btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchDown];
    [_left_up_btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchDown];
    
    //
    _up_btn.tag = 0;
    _right_up_btn.tag = 1;
    _right_down_btn.tag = 2;
    _down_btn.tag = 3;
    _left_down_btn.tag = 4;
    _left_up_btn.tag = 5;
    
    _roundArray = [[NSArray alloc]initWithObjects:_up_btn,_right_up_btn,_right_down_btn,_down_btn,_left_down_btn,_left_up_btn, nil];
    //
    
    
    //
    
    rect = CGRectMake(0, 0, C_ROUND_WIDTH,30);
    _textLabel = [[UILabel alloc]initWithFrame:rect];
    _textLabel.textColor = [UIColor redColor];
    _textLabel.font = [UIFont systemFontOfSize:20];
    _textLabel.center = CGPointMake(C_ROUND_WIDTH/2 , C_ROUND_HEIGHT / 2);
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


-(void)btnClicked:(UIButton*)btn
{
    int tag = btn.tag;
    
    if( tag == _targetIndex )
    {
        NSLog(@"successed");
    }
    
}


-(void)startAnim
{
    
    //
    CGRect rect = CGRectMake(0-CIRCLE_RADIUS-C_ROUND_WIDTH/2, 0-C_ROUND_WIDTH/2, CENTER_ROUND_X+CIRCLE_RADIUS-C_ROUND_WIDTH/2, CENTER_ROUND_Y + CIRCLE_RADIUS-C_ROUND_WIDTH/2);
    
    CAKeyframeAnimation *orbit = [CAKeyframeAnimation animation];
    orbit.keyPath = @"position";
    orbit.path = CFAutorelease(CGPathCreateWithEllipseInRect(rect, NULL));
    orbit.duration = 4;
    orbit.additive = YES;
    orbit.repeatCount = HUGE_VALF;
    orbit.calculationMode = kCAAnimationPaced;
    orbit.rotationMode = kCAAnimationRotateAuto;
    
    [_up_btn.layer addAnimation:orbit forKey:@"orbit"];

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
    
    
    // _center_view.backgroundColor = [_colorArray objectAtIndex:_randArray[_targetIndex]];
    //_colorArray = [[NSArray alloc]initWithObjects:[UIColor redColor],[UIColor orangeColor],[UIColor purpleColor],[UIColor brownColor],[UIColor blueColor],[UIColor blackColor], nil];

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
            
            [NSThread sleepForTimeInterval:RAND_INTERVAL];
        }
        
    });
}



-(void)btnBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
