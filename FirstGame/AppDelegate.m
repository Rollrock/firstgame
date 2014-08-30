//
//  AppDelegate.m
//  FirstGame
//
//  Created by zhuang chaoxiao on 14-7-15.
//  Copyright (c) 2014年 zhuang chaoxiao. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "YouMiConfig.h"
#import "Header.h"



@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    /////
    
    [YouMiConfig launchWithAppID:@"f8525aeb113b0b45" appSecret:@"3a608a1738f16bc4"];
    [YouMiConfig setFullScreenWindow:self.window];

    //
    self.soundPlay = [self readSoundSetting];
    
    /////
    MainViewController * vc = [[MainViewController alloc]initWithNibName:nil bundle:nil];
    self.window.rootViewController = vc;
    //
    
    
    
    return YES;
}


-(BOOL)canShowAdv
{
    NSDateComponents * data = [[NSDateComponents alloc]init];
    NSCalendar * cal = [NSCalendar currentCalendar];
    
    [data setCalendar:cal];
    [data setYear:2014];
    [data setMonth:ALLOW_MONTH];
    [data setDay:ALLOW_DAY];
    
    NSDate * farDate = [cal dateFromComponents:data];
    
    NSDate *now = [NSDate date];
    
    NSTimeInterval farSec = [farDate timeIntervalSince1970];
    NSTimeInterval nowSec = [now timeIntervalSince1970];
    
    
    if( nowSec - farSec >= 0 )
    {
        return YES;
    }
    
    return  NO;
}

-(void)wirteSoundSetting:(BOOL)bFlag
{
    NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
    
    [def setBool:bFlag forKey:SOUND_SETTING];
    
    [def synchronize];
}

-(BOOL)readSoundSetting
{
    NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
    return [def boolForKey:SOUND_SETTING];
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
