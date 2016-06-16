//
//  ZYTabBarController.h
//  
//
//  Created by zhaoyuan on 16/6/14.
//  Copyright © 2016年 赵远. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYTabBarController : UITabBarController {
    UIButton *settingsButton;
    UIButton *infoButton;
    UIButton *aboutUsButton;
}

@property (nonatomic, retain) UIButton *settingsButton;
@property (nonatomic, retain) UIButton *infoButton;
@property (nonatomic, retain) UIButton *aboutUsButton;

-(void) addCustomElements;
-(void) selectTab:(int)tabID;

@end