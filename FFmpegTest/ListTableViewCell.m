//
//  ListTableViewCell.m
//  FFmpegTest
//
//  Created by zhaoyuan on 16/2/2.
//  Copyright © 2016年 times. All rights reserved.
//

#import "ListTableViewCell.h"

#define kTitleFont 16
#define kPriceFont 15
#define kImageWidth 60

@interface ListTableViewCell (){
    
}


@end

@implementation ListTableViewCell


- (UIImageView *)bgImgeView
{
    if (!_bgImgeView) {
        _bgImgeView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 80, screen_width, screen_width)];
        _bgImgeView.backgroundColor = [UIColor whiteColor];
        _bgImgeView.clipsToBounds = YES;
        [_bgImgeView setContentMode:UIViewContentModeScaleAspectFill];
    }
    return _bgImgeView;
}


- (UIImageView *)prodImgeView
{    
    if (!_prodImgeView) {
        _prodImgeView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, kImageWidth, kImageWidth)];
        _prodImgeView.layer.borderWidth = kImageWidth/2;
        [_prodImgeView.layer setMasksToBounds:YES];
        [_prodImgeView.layer setCornerRadius:kImageWidth/2];
        [_prodImgeView.layer setBorderWidth:2];
        _prodImgeView.layer.borderColor=fontGray.CGColor;
        _prodImgeView.backgroundColor = [UIColor whiteColor];
        _prodImgeView.clipsToBounds = YES;
        [_prodImgeView setContentMode:UIViewContentModeScaleAspectFill];
    }
    return _prodImgeView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.prodImgeView.right+10, self.prodImgeView.top, screen_width-self.prodImgeView.right-10, self.prodImgeView.height*2/3.0)];
        _titleLabel.font = [UIFont systemFontOfSize:kTitleFont];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.numberOfLines = 2;
    }
    return _titleLabel;
}

- (UILabel *)priceLabel
{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLabel.left, self.titleLabel.bottom+2,100, self.prodImgeView.height/3.0)];
        _priceLabel.font = [UIFont systemFontOfSize:kPriceFont];
        _priceLabel.textColor=fontGray;
    }
    return _priceLabel;
}

- (UILabel *)onlineLabel
{
    if (!_onlineLabel) {
        _onlineLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.priceLabel.right, self.titleLabel.bottom+2,  screen_width-self.priceLabel.right-60, self.prodImgeView.height/3.0)];
        _onlineLabel.font = [UIFont systemFontOfSize:kTitleFont];
        _onlineLabel.textColor = navigationBarColor;
        _onlineLabel.numberOfLines = 2;
        _onlineLabel.textAlignment=2;
        _onlineLabel.font=[UIFont systemFontOfSize:15];
    }
    return _onlineLabel;
}

- (UILabel *)snameLabel
{
    if (!_snameLabel) {
        _snameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.onlineLabel.right, self.titleLabel.bottom+2, screen_width-self.onlineLabel.right, self.prodImgeView.height/3.0)];
        _snameLabel.font = [UIFont systemFontOfSize:kTitleFont];
        _snameLabel.textColor = fontGray;
        _snameLabel.numberOfLines = 2;
        _snameLabel.text=@"在看";
        _snameLabel.font=[UIFont systemFontOfSize:12];

    }
    return _snameLabel;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, self.bgImgeView.bottom+10, screen_width-20, 20)];
        _nameLabel.font = [UIFont systemFontOfSize:kTitleFont];
        _nameLabel.textColor = fontGray;
        _nameLabel.numberOfLines = 2;
        _nameLabel.font=[UIFont systemFontOfSize:15];

    }
    return _nameLabel;
}

- (UIView *)line
{
    if (!_line) {
        _line = [[UIView alloc] initWithFrame:CGRectMake(0, self.nameLabel.bottom, screen_width, 5)];
        _line.backgroundColor=[UIColor colorWithRed:0.898 green:0.898 blue:0.898 alpha:1.00];
    }
    return _line;
}



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.bgImgeView];
        [self.contentView addSubview:self.prodImgeView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.priceLabel];
        [self.contentView addSubview:self.onlineLabel];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.snameLabel];
        [self.contentView addSubview:self.line];
        
        
    }
    return self;
}

- (void)setUIWithImage:(NSString *)urlStr Title:(NSString *)title Price: (double)price
{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
