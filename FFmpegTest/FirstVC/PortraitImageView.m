//
//  PortraitImageView.m
//  FFmpegTest
//
//  Created by zhaoyuan on 16/6/16.
//  Copyright © 2016年 times. All rights reserved.
//

#import "PortraitImageView.h"

@implementation PortraitImageView

/**
 *  设置边框宽度
 *
 *  @param borderWidth 可视化视图传入的值

 */
- (void)setBorderWidth:(CGFloat)borderWidth {
    
    if (borderWidth < 0) return;
    
    self.layer.borderWidth = borderWidth;
}

/**
 *  设置边框颜色
 *
 *  @param borderColor 可视化视图传入的值
 */
- (void)setBorderColor:(UIColor *)borderColor {
    
    self.layer.borderColor = borderColor.CGColor;
}

/**
 *  设置圆角
 *
 *  @param cornerRadius 可视化视图传入的值
 */
- (void)setCornerRadius:(CGFloat)cornerRadius {
    
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = cornerRadius > 0;
}


@end
