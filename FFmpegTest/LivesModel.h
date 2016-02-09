//
//  LivesModel.h
//  FFmpegTest
//
//  Created by zhaoyuan on 16/2/2.
//  Copyright © 2016年 times. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

@property(nonatomic,strong)NSString * nick;
@property(nonatomic,strong)NSString * ID;
@property(nonatomic,strong)NSString * portrait;


@end


@interface LivesModel : NSObject

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


@property(nonatomic,strong)UserModel * creator;
@property(nonatomic,strong)NSString * ID;// "1454399684660249",
@property(nonatomic,strong)NSString * name;// "听帅比唱歌",
@property(nonatomic,strong)NSString * city;// "南宁市",
@property(nonatomic,strong)NSString * share_addr;// "http://inke.tv/s/?uid=1924922&liveid=1454399684660249&ctime=1454399684",
@property(nonatomic,strong)NSString * stream_addr;// "http://inke.8686c.com/live/1454399684660249.flv",
@property(nonatomic,strong)NSString * version;// 0,
@property(nonatomic,strong)NSString * slot;// 1,
@property(nonatomic,strong)NSString * optimal;// 0,
@property(nonatomic,strong)NSString * online_users;// 8607,
@property(nonatomic,strong)NSString * group;// 0

@end
