//
//  ZYLivePreview.h
//  FFmpegTest
//
//  Created by zhaoyuan on 16/6/10.
//  Copyright © 2016年 times. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^closeblock)();

@interface ZYLivePreview : UIView

@property(nonatomic,copy)closeblock close;




-(void)startLive;
-(void)stopLive;


@end
