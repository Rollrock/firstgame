//
//  AppsViewController.m
//  FirstGame
//
//  Created by zhuang chaoxiao on 14-8-6.
//  Copyright (c) 2014年 zhuang chaoxiao. All rights reserved.
//

#import "AppsViewController.h"
#import "Header.h"


//#define APP_RECOMMEND_URL  @"http://www.999dh.net/firstgame/appRecommend.html"

#define APP_RECOMMEND_URL  @"http://www.999dh.net/firstgame/index.html"

@interface AppsViewController ()
{
    UIWebView * _webView;
}
@end

@implementation AppsViewController

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
    
    CGRect rect = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    _webView = [[UIWebView alloc]initWithFrame:rect];
    NSURL * url = [[NSURL alloc]initWithString:APP_RECOMMEND_URL];
    [_webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    [self.view addSubview:_webView];
    
    //
    
    {
        UIButton * btnBack = [[UIButton alloc]initWithFrame:CGRectMake(BACK_POS_X, BACK_POS_Y, BACK_WIDTH, BACK_HEIGHT)];
        [btnBack setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [btnBack addTarget:self action:@selector(btnBack) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btnBack];
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
