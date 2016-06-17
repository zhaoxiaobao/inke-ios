//
//  ZYTabBarController.h
//  
//
//  Created by zhaoyuan on 16/6/14.
//  Copyright © 2016年 赵远. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYTabBarView.h"

@interface ZYTabBarController : UITabBarController {
   
}

@property (nonatomic, retain) ZYTabBarView  *tabbar;

-(void) addCustomElements;
-(void) selectTab:(int)tabID;

@end