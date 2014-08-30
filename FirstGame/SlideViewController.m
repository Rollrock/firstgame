//
//  SlideViewController.m
//  FirstGame
//
//  Created by zhuang chaoxiao on 14-8-5.
//  Copyright (c) 2014年 zhuang chaoxiao. All rights reserved.
//

#import "SlideViewController.h"
#import "Header.h"

@interface SlideViewController ()

@end

@implementation SlideViewController

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

    
    
    {
        UIButton * btnBack = [[UIButton alloc]initWithFrame:CGRectMake(BACK_POS_X, BACK_POS_Y, BACK_WIDTH, BACK_HEIGHT)];
        [btnBack setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [btnBack addTarget:self action:@selector(btnBack) forControlEvents:UIControlEventTouchUpInside];
        [imgView addSubview:btnBack];
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
