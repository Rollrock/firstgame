//
//  SettingViewController.m
//  FirstGame
//
//  Created by zhuang chaoxiao on 14-8-3.
//  Copyright (c) 2014年 zhuang chaoxiao. All rights reserved.
//

#import "SettingViewController.h"
#import "Header.h"
#import "AdvViewController.h"

@interface SettingViewController ()
{
    UISwitch * _switch;
}
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
    
    self.view.backgroundColor = [UIColor grayColor];
    
    CGRect rect;
    
    {
        rect = CGRectMake(80, 20, 70, 20);
        UILabel * lab = [[UILabel alloc]initWithFrame:rect];
        lab.text = @"声音效果";
        lab.textColor = [UIColor orangeColor];
        lab.font = [UIFont systemFontOfSize:15];
        [self.view addSubview:lab];
    }
    
    {
        rect = CGRectMake(150, 20, 100, 100);
        _switch = [[UISwitch alloc]initWithFrame:rect];
        [_switch addTarget:self action:@selector(switchVlaueChanged:) forControlEvents:UIControlEventValueChanged];
        
        
        
        [self.view addSubview:_switch];
    }
    
    
    {
        UIButton * btnBack = [[UIButton alloc]initWithFrame:CGRectMake(BACK_POS_X, BACK_POS_Y, BACK_WIDTH, BACK_HEIGHT)];
        [btnBack setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [btnBack addTarget:self action:@selector(btnBack) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btnBack];
    }

    
   
}


-(void)switchValueChanged:(UISwitch*)sender
{
    if( sender == _switch )
    {
        BOOL isOn = sender.on;
        
        NSLog(@"isOn:%d",isOn);
    }
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
