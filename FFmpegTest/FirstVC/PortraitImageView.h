//
//  PortraitImageView.h
//  FFmpegTest
//
//  Created by zhaoyuan on 16/6/16.
//  Copyright © 2016年 times. All rights reserved.
//

#import <UIKit/UIKit.h>


IB_DESIGNABLE

@interface PortraitImageView : UIImageView

@property (nonatomic, assign)IBInspectable CGFloat borderWidth;

@property (nonatomic, strong)IBInspectable UIColor *borderColor;

@property (nonatomic, assign)IBInspectable CGFloat cornerRadius;

@end
