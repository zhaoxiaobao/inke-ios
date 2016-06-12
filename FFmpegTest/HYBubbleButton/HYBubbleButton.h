//
//  HYBubbleButton.h
//  animationDemo
//
//  Created by nathan on 15/7/4.
//  Copyright (c) 2015年 nathan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYBubbleButton : UIButton

- (instancetype)initWithFrame:(CGRect)frame
                      maxLeft:(CGFloat)maxLeft
                     maxRight:(CGFloat)maxRight
                    maxHeight:(CGFloat)maxHeight;


@property (nonatomic, assign)CGFloat maxLeft;
@property (nonatomic, assign)CGFloat maxRight;
@property (nonatomic, assign)CGFloat maxHeight;
@property (nonatomic, assign)CGFloat duration;
@property (nonatomic, strong)NSArray *images;

- (void)generateBubbleWithImage:(UIImage *)image;


// you have to set images first.
- (void)generateBubbleInRandom;

@end
