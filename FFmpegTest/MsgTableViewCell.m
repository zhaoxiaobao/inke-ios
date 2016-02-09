//
//  MsgTableViewCell.m
//  FFmpegTest
//
//  Created by zhaoyuan on 16/2/9.
//  Copyright © 2016年 times. All rights reserved.
//

#import "MsgTableViewCell.h"

@implementation MsgTableViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setView];
    }
    return self;
}


- (void)setView {
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
