//
//  GZTableViewCell.h
//  FFmpegTest
//
//  Created by zhaoyuan on 16/6/5.
//  Copyright © 2016年 times. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LivesModel.h"

//"creator": {
//    "id": 1924922,
//    "nick": "我就是心机婊",
//    "portrait": "NTA2MDQxNDU0Mzg2Nzg0.jpg"
//},
//"id": "1454399684660249",
//"name": "听帅比唱歌",
//"city": "南宁市",
//"share_addr": "http://inke.tv/s/?uid=1924922&liveid=1454399684660249&ctime=1454399684",
//"stream_addr": "http://inke.8686c.com/live/1454399684660249.flv",
//"version": 0,
//"slot": 1,
//"optimal": 0,
//"online_users": 8607,
//"group": 0


@interface GZTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *online_users;
@property (weak, nonatomic) IBOutlet UILabel *city;
@property (weak, nonatomic) IBOutlet UIImageView *portrait;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIImageView *bg;

-(void)setCellDataModel:(LivesModel *)model;

@end
