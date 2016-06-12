//
//  LiveTopHeaderView.h
//  FFmpegTest
//
//  Created by zhaoyuan on 16/6/7.
//  Copyright © 2016年 times. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LivesModel.h"


@interface LiveTopHeaderView : UIView


@property (weak, nonatomic) IBOutlet UIButton *action;
@property (weak, nonatomic) IBOutlet UIImageView *portrait;
@property (weak, nonatomic) IBOutlet UILabel *online_users;


+(instancetype) createView;

+(instancetype) createViewWithData:(LivesModel *)model;


@end
