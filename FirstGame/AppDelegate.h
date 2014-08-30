//
//  AppDelegate.h
//  FirstGame
//
//  Created by zhuang chaoxiao on 14-7-15.
//  Copyright (c) 2014年 zhuang chaoxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


@property (nonatomic)  BOOL soundPlay;


-(void)wirteSoundSetting:(BOOL)bFlag;

-(BOOL)readSoundSetting;

-(BOOL)canShowAdv;

@end
