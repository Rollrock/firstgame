//
//  Header.h
//  FirstGame
//
//  Created by zhuang chaoxiao on 14-7-15.
//  Copyright (c) 2014年 zhuang chaoxiao. All rights reserved.
//

#ifndef FirstGame_Header_h
#define FirstGame_Header_h

#import <UIKit/UIKit.h>


#define degreesToRadians(x) (M_PI*(x)/180.0)
#define  UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue &0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.height)

#define ROUND_WIDTH  100
#define ROUND_HEIGHT 100
#define ROUND_POS_X  ((SCREEN_WIDTH - ROUND_WIDTH)/2)
#define ROUND_POS_Y  ((SCREEN_HEIGHT - ROUND_HEIGHT)/2)


#define BACK_POS_X  20
#define BACK_POS_Y  20
#define BACK_HEIGHT  40
#define BACK_WIDTH   40




#define PASS_1_ID  @"pass_1_id"
#define PASS_2_ID  @"pass_2_id"
#define PASS_3_ID  @"pass_3_id"
#define PASS_4_ID  @"pass_4_id"
#define PASS_5_ID  @"pass_5_id"
#define PASS_6_ID  @"pass_6_id"
#define PASS_7_ID  @"pass_7_id"
#define PASS_8_ID  @"pass_8_id"
#define PASS_9_ID  @"pass_9_id"


//声音设置
#define SOUND_SETTING @"sound_setting"

//admob 广告
#define ADMOB_ADV_ID  @"ca-app-pub-3058205099381432/9592754743"

#define ALLOW_MONTH  9
#define ALLOW_DAY   29

#endif
