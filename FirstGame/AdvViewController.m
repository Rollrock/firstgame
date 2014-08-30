//
//  AdvViewController.m
//  FirstGame
//
//  Created by zhuang chaoxiao on 14-8-4.
//  Copyright (c) 2014年 zhuang chaoxiao. All rights reserved.
//

#import "AdvViewController.h"
#import "Header.h"

@interface AdvViewController ()<UIWebViewDelegate>
{
    UIWebView * _webView;
}
@end

@implementation AdvViewController

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
    
    /*
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _webView.delegate = self;
    [self.view addSubview:_webView];
    
    
    [self loadWebWithUrlString:@"http://www.999dh.net/firstgame/index.html"];
    */
}


/*
-(void)loadWebWithUrlString:(NSString*)urlStr
{
    NSURL * url = [NSURL URLWithString:urlStr];
    NSURLRequest * req = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:req];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"webViewDidFinishLoad");
}
 */


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
