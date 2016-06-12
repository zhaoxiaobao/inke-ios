//
//  ZYTabBarView.h
//  FFmpegTest
//
//  Created by zhaoyuan on 16/6/8.
//  Copyright © 2016年 times. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYTabBarView : UIView

+(instancetype ) createView;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *firstButton;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *secondButton;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *centreButton;

@end
