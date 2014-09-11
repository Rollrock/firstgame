//
//  SettingViewController.m
//  EyeDir
//
//  Created by zhuang chaoxiao on 14-9-9.
//  Copyright (c) 2014年 zhuang chaoxiao. All rights reserved.
//

#import "SettingViewController.h"
#import "Header.h"
#import "GADBannerView.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

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
    
    [self initBackView];
    
    [self initInfoView];
    
    [self layAdvView];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
}


-(void)layAdvView
{
    GADBannerView *_bannerView;
    
    CGPoint pt = CGPointMake(10,230);
    
    _bannerView = [[GADBannerView alloc]initWithAdSize:kGADAdSizeFullBanner origin:pt];
 
    
    _bannerView.adUnitID = ADMOB_ADV_ID;//调用你的id
    
    _bannerView.rootViewController = self;
    
    [self.view addSubview:_bannerView];//添加bannerview到你的试图
    
    GADRequest * request =  [GADRequest request];
    request.testDevices = @[ @"29658c04b9b3f85f9d54622cfbaae8bc" ];
    
    [_bannerView loadRequest:request];
    
}

-(void)initInfoView
{
    CGRect rect;
    
    rect = CGRectMake(100, 30, 310, 180);
    UIView * view = [[UIView alloc]initWithFrame:rect];
    view.backgroundColor = [UIColor grayColor];
    view.layer.cornerRadius = 10;
    view.layer.masksToBounds = YES;
    
    [self.view addSubview:view];
    
    
    {
        rect = CGRectMake(50, 30, 210, 30);
        UILabel * lab = [[UILabel alloc]initWithFrame:rect];
        lab.text = @"     QQ:          479408690";
        lab.backgroundColor = [UIColor whiteColor];
        lab.layer.cornerRadius = 5;
        lab.layer.masksToBounds = YES;
        
        [view addSubview:lab];
    }
    
    {
        rect = CGRectMake(50, 80, 210, 30);
        UILabel * lab = [[UILabel alloc]initWithFrame:rect];
        lab.text = @"     联系人:       小土豆 ";
        lab.backgroundColor = [UIColor whiteColor];
        lab.layer.cornerRadius = 5;
        lab.layer.masksToBounds = YES;
        
        [view addSubview:lab];
    }
    
    {
        rect = CGRectMake(50, 130, 210, 30);
        UILabel * lab = [[UILabel alloc]initWithFrame:rect];
        lab.text = @"     电话:       15921931771 ";
        lab.backgroundColor = [UIColor whiteColor];
        lab.layer.cornerRadius = 5;
        lab.layer.masksToBounds = YES;
        
        [view addSubview:lab];
    }
}


///
-(void)initBackView
{
    CGRect rect;
    
    rect = CGRectMake(10, 20, BACK_WIDTH, BACK_WIDTH);
    UIButton * btn = [[UIButton alloc]initWithFrame:rect];
    [btn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backBtnClicked) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:btn];
    btn = nil;
    
}

-(void)backBtnClicked
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
