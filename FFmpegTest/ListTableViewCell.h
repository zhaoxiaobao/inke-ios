//
//  ListTableViewCell.h
//  FFmpegTest
//
//  Created by zhaoyuan on 16/2/2.
//  Copyright © 2016年 times. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListTableViewCell : UITableViewCell

@property (strong, nonatomic) UIImageView *bgImgeView;
@property (strong, nonatomic) UIImageView *prodImgeView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *priceLabel;

@property (strong, nonatomic) UILabel *onlineLabel;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *snameLabel;

@property (nonatomic, strong) UIView *line;
;



@end
