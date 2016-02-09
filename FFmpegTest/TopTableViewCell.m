//
//  TopTableViewCell.m
//  FFmpegTest
//
//  Created by zhaoyuan on 16/2/5.
//  Copyright © 2016年 times. All rights reserved.
//

#define kImageWidth 38

#import "TopTableViewCell.h"

@implementation TopTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (UIImageView *)prodImgeView
{
    if (!_prodImgeView) {
        _prodImgeView = [[UIImageView alloc] initWithFrame:CGRectMake(1, 1, kImageWidth, kImageWidth)];
        _prodImgeView.layer.borderWidth = kImageWidth/2;
        [_prodImgeView.layer setMasksToBounds:YES];
        [_prodImgeView.layer setCornerRadius:kImageWidth/2];
        [_prodImgeView.layer setBorderWidth:1];
        _prodImgeView.layer.borderColor=fontGray.CGColor;
        _prodImgeView.backgroundColor = [UIColor clearColor];
        _prodImgeView.clipsToBounds = YES;
        [_prodImgeView setContentMode:UIViewContentModeScaleAspectFill];
    }
    return _prodImgeView;
}



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.prodImgeView];
    }
    return self;
}

@end
