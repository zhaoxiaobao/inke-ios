//
//  ZYTabBarView.m
//  FFmpegTest
//
//  Created by zhaoyuan on 16/6/8.
//  Copyright © 2016年 times. All rights reserved.
//

#import "ZYTabBarView.h"

@implementation ZYTabBarView

+(instancetype) createView{
    NSBundle *bundle=[NSBundle mainBundle];
    NSArray *objs=[bundle loadNibNamed:@"ZYTabBarView" owner:nil options:nil];
    return [objs lastObject];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
