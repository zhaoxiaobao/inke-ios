//
//  DetailViewController.m
//  FFmpegTest
//
//  Created by zhaoyuan on 16/2/2.
//  Copyright © 2016年 times. All rights reserved.
//

#import "DetailViewController.h"
#import "NetworkSingleton.h"
#import "MJExtension.h"
//#import <SDWebImage/UIImageView+WebCache.h>
#import "LivesModel.h"
#import <MediaPlayer/MediaPlayer.h>
#import <QuartzCore/QuartzCore.h>
#import "KxMovieDecoder.h"
#import "KxAudioManager.h"
#import "KxMovieGLView.h"


@interface DetailViewController (){
    KxMovieDecoder      *_decoder;
    KxMovieGLView       *_glView;
    NSMutableArray *_listData;
    
}

@end

@implementation DetailViewController


// ////////////////////////////////////////////

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self initNav];
    [self initView];
    [self initData];
}




-(void)initNav{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 64)];
    [self.view addSubview:backView];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 20, 54, 44);
    UIImageView  *img=[[UIImageView alloc] initWithFrame:CGRectMake(10,10,13,23)];
    [img setImage:[ UIImage imageNamed:@"icon_back"]];
    [backBtn addSubview:img];
    [backBtn addTarget:self action:@selector(backBtnTap:) forControlEvents:UIControlEventTouchUpInside];
    backBtn.adjustsImageWhenHighlighted = NO;
    [backView addSubview:backBtn];
    
    
}


- (void)initView{
    
}

- (void)initData{
    _listData = [[NSMutableArray alloc] init];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
        
        //        [self getListData];
        dispatch_async(dispatch_get_main_queue(), ^{
            //update UI
        });
    });
    
}



- (void)getListData{
    
    NSString *url = @"http://101.200.29.199/api/live/next?action=down&cc=TG0001&conn=Wifi&cv=IK2.5.10_Iphone&devi=44d94653f9a0934cc94f12e542d7d363fae4256b&id=1454401299844860&idfa=07506DA9-419B-460D-BAC8-E035DD6099BC&idfv=3D5EC291-4DDF-44FE-8AC7-B9598B532319&imei=&imsi=&lc=0000000000000014&multiaddr=1&osversion=ios_9.200000&proto=1&sid=EE3qPwpb4VuMR65ShMqfaS8i3&source=0&step=0&ua=iPhone%205s&uid=509195";
    
    [[NetworkSingleton sharedManager] getJsonData:nil url:url successBlock:^(id responseBody){
        NSLog(@"%@",responseBody);
        
        NSMutableArray *dataDic = [responseBody objectForKey:@"infos"];

        for (int i=0; i<dataDic.count; i++) {
            
            LivesModel *model=[LivesModel mj_objectWithKeyValues:dataDic[i]];
            
            [_listData addObject:model];
            
            
            NSLog(@"%@",model.stream_addr);

            
            
        }
        
        
    } failureBlock:^(NSString *error){
        NSLog(@"%@",error);
    }];
    
}



//响应事件
-(void)backBtnTap:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)rightBtnTap:(UIButton *)sender{
    
}


- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
