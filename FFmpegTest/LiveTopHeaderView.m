//
//  LiveTopHeaderView.m
//  FFmpegTest
//
//  Created by zhaoyuan on 16/6/7.
//  Copyright © 2016年 times. All rights reserved.
//

#import "LiveTopHeaderView.h"

@implementation LiveTopHeaderView

+(instancetype) createView{
    NSBundle *bundle=[NSBundle mainBundle];
    NSArray *objs=[bundle loadNibNamed:@"LiveTopHeaderView" owner:nil options:nil];
    return [objs lastObject];
}


+(instancetype) createViewWithData:(LivesModel *)model{
    
    LiveTopHeaderView *view = [self createView];
    view.online_users.text = [NSString stringWithFormat:@"%@",model.online_users];
    NSString *urlStr;
    if ([model.creator.portrait rangeOfString:@"http"].location !=NSNotFound) {
        //$$字符串判断
        urlStr= model.creator.portrait;
        
    }else{
        urlStr= [NSString stringWithFormat:@"http://img.meelive.cn/%@",model.creator.portrait];
    }
    
    
    view.portrait.layer.cornerRadius = view.portrait.width/2;

    [view.portrait sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"default_head"] options:SDWebImageCacheMemoryOnly];
    
    return view;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
